import csv
import json
import logging
import os
from datetime import datetime
from distutils.dir_util import copy_tree
from typing import Any, List

import numpy as np
import pandas as pd
import tensorflow as tf
from bert import tokenization
from flask import Blueprint
from models import class_based_attention

import app.tasks as tasks
from app.classifier import Classifier
from app.embedder import MAX_SEQ_LENGTH, Embedder
from app.models import ClassificationSample, sessionLock

train_bp = Blueprint('train_bp', __name__)

# LEARNING_RATE = 2e-3
LEARNING_RATE = 0.02
NUM_WARMUP_STEPS = 100
WARMUP_PROPORTION = 0.0
DROPOUT = 0.1
# SHARED_SIZE = 512
SHARED_SIZE = 0
BATCH_SIZE = 256


def _one_hot_labels(label_list: List[str], all_labels: List[str]) -> List[int]:
    labels = [0] * len(all_labels)
    indices = [all_labels.index(label) for label in label_list]
    for ind in indices:
        labels[ind] = 1
    return labels


class InputExample(object):
    """A single training/test example for simple sequence classification."""

    def __init__(self, guid: str, text_a: str, labels: List[int]) -> None:
        """Constructs a InputExample.

    Args:
        guid: Unique id for the example.
        text_a: string. The untokenized text of the first sequence. For single
        sequence tasks, only this sequence must be specified.
        Only must be specified for sequence pair tasks.
        labels: (Optional) [string]. The label of the example. This should be
        specified for train and dev examples, but not for test examples.
    """
        self.guid = guid
        self.text_a = text_a
        self.labels = labels


class InputFeatures(object):
    """A single set of features of data."""

    def __init__(self,
                 embeddings: np.array,
                 label_ids: Any,
                 is_real_example: bool = True) -> None:
        self.hidden_size = embeddings.shape[-1]
        self.embeddings = np.zeros([MAX_SEQ_LENGTH, self.hidden_size],
                                   dtype=np.float32)
        self.input_mask = np.zeros([MAX_SEQ_LENGTH], dtype=np.int32)
        self.embeddings[:len(embeddings)] = embeddings
        self.input_mask[:len(embeddings)] = 1
        self.label_id = np.array(label_ids, dtype=np.int32)

        self.is_real_example = is_real_example


def create_examples(data: pd.DataFrame,
                    num_classes: int,
                    set_type: str = 'train') -> List[InputExample]:
    examples = []
    for index, row in data.iterrows():
        guid = '%s-%s' % (set_type, index)
        text_a = tokenization.convert_to_unicode(row.seq)
        if set_type == 'test':
            labels = [0] * num_classes
        else:
            labels = row.one_hot_labels
        examples.append(InputExample(guid=guid, text_a=text_a, labels=labels))
    return examples


def convert_examples_to_features(examples: List[InputExample],
                                 embedder: Embedder) -> List[InputFeatures]:
    """Loads a data file into a list of `InputBatch`s."""

    embeddings = embedder.get_embedding([e.text_a for e in examples])

    return [
        InputFeatures(embeddings=em, label_ids=e.labels)
        for e, em in zip(examples, embeddings)
    ]


def input_fn_builder(examples: List[InputExample],
                     num_classes: int,
                     embedder: Embedder,
                     is_training: bool = True,
                     drop_remainder: bool = True) -> Any:
    """Creates an `input_fn` closure to be passed to Estimator."""

    features = convert_examples_to_features(examples, embedder)

    total_size = len(features)
    hidden_size = features[0].hidden_size
    all_input_mask = np.zeros([total_size, MAX_SEQ_LENGTH], dtype=np.int32)
    all_embeddings = np.zeros([total_size, MAX_SEQ_LENGTH, hidden_size],
                              dtype=np.float32)
    all_label_ids = np.zeros([total_size, num_classes], dtype=np.int32)

    for i in range(len(features)):
        all_input_mask[i] = features[i].input_mask
        all_embeddings[i] = features[i].embeddings
        all_label_ids[i] = features[i].label_id

    def input_fn() -> Any:
        """The actual input function."""
        dataset = tf.data.Dataset.from_tensor_slices(({
            'input_mask': tf.convert_to_tensor(all_input_mask),
            'embeddings': tf.convert_to_tensor(all_embeddings)
        }, {
            'label_ids': tf.convert_to_tensor(all_label_ids),
        }))

        if is_training:
            dataset = dataset.repeat()
            dataset = dataset.shuffle(buffer_size=100)

        dataset = dataset.batch(batch_size=BATCH_SIZE,
                                drop_remainder=drop_remainder)
        return dataset

    return input_fn


def save_model(output_dir: str, estimator: tf.estimator.Estimator) -> None:

    def serving_input_receiver_fn() -> Any:
        embeddings = tf.placeholder(dtype=tf.float32,
                                    shape=[None, None, 768],
                                    name='embeddings')
        input_mask = tf.placeholder(dtype=tf.int32,
                                    shape=[None, None],
                                    name='input_mask')
        features = {'embeddings': embeddings, 'input_mask': input_mask}
        return tf.estimator.export.ServingInputReceiver(
            features=features, receiver_tensors=features)

    estimator.export_saved_model(output_dir, serving_input_receiver_fn)


class Trainer:

    def __init__(self, base_classifier_dir: str, model_name: str) -> None:
        self.logger = logging.getLogger()
        self.model_name = model_name
        self.base_classifier_dir = base_classifier_dir
        self.model_config_path = os.path.join(base_classifier_dir, model_name)
        if not os.path.isdir(base_classifier_dir):
            raise Exception('Invalid base_classifier_dir: %s' %
                            base_classifier_dir)

    def train(self,
              embedder: Embedder,
              vocab: List[str],
              limit: int,
              forced_instance: str = '',
              train_ratio: float = 0.9,
              num_train_steps: int = 1000,
              test_subset_csv: str = '') -> Classifier:
        # timestamp = str(1578318208)
        timestamp = str(int(datetime.utcnow().timestamp()))
        if forced_instance:
            timestamp = forced_instance
        instance_path = os.path.join(self.model_config_path, timestamp)
        train_path = os.path.join(instance_path, 'train')
        if 'nan' not in vocab:
            vocab.append('nan')
        num_classes = len(vocab)

        with sessionLock:
            samples: List[ClassificationSample] = list(
                ClassificationSample.query.find(
                    dict(model=self.model_name, use_for_training=True)).sort([
                        ('seqHash', -1)
                    ]).limit(limit))

            data = pd.DataFrame(data=dict(
                seq=[s.seq for s in samples],
                one_hot_labels=[
                    _one_hot_labels(
                        list(set([l.topic
                                  for l in s.training_labels])), vocab)
                    for s in samples
                ]))
        if len(data) == 0:
            raise RuntimeError('no data found')

        if not os.path.exists(instance_path):
            os.mkdir(instance_path)
            os.mkdir(train_path)
        with open(os.path.join(instance_path, 'label.vocab'), 'w') as f:
            f.writelines([label + '\n' for label in vocab])
        with open(os.path.join(instance_path, 'config.json'), 'w') as f:
            json.dump(
                dict(bert=embedder.bert,
                     vocab='label.vocab',
                     is_released=False,
                     training_subset_path='test_seqs.csv',
                     description='From Trainer.train'), f)

        if test_subset_csv:
            BLERG
            subset_seqs: List[str] = []
            if subset_file:
                with open(subset_file, 'r') as subset_handle:
                    subset_seqs = [
                        row[0]
                        for row in csv.reader(subset_handle, delimiter=',')
                        if row
                    ]
            print('Subset example: ', subset_seqs[:1])
            train_values = data.drop()
        else:
            train_values = data.sample(frac=train_ratio, random_state=42)

        test_values = data.drop(train_values.index)

        with open(os.path.join(instance_path, 'train_seqs.csv'), 'w') as f:
            writer = csv.writer(f)
            writer.writerow(['text'])
            for index, row in train_values.iterrows():
                writer.writerow([row.seq])
        with open(os.path.join(instance_path, 'test_seqs.csv'), 'w') as f:
            writer = csv.writer(f)
            writer.writerow(['text'])
            for index, row in test_values.iterrows():
                writer.writerow([row.seq])

        # dev_values = test_values.sample(frac=0.50, random_state=42)
        # test_values = test_values.drop(dev_values.index)

        train_examples = create_examples(train_values, num_classes, 'train')
        # eval_examples = create_examples(dev_values, num_classes, 'dev')

        params = dict(num_classes=num_classes,
                      learning_rate=LEARNING_RATE,
                      num_warmup_steps=NUM_WARMUP_STEPS,
                      dropout=DROPOUT,
                      class_based_attention=True,
                      shared_size=SHARED_SIZE,
                      num_train_steps=num_train_steps)

        run_config = tf.estimator.RunConfig(model_dir=train_path,
                                            save_checkpoints_steps=min(
                                                [num_train_steps, 500]))

        model_fn = class_based_attention.model_fn_builder(use_tpu=False)

        estimator = tf.estimator.Estimator(model_fn=model_fn,
                                           config=run_config,
                                           params=params)

        print('***** Started training at {} *****'.format(datetime.now()))
        train_input_fn = input_fn_builder(train_examples,
                                          num_classes,
                                          embedder,
                                          is_training=True,
                                          drop_remainder=False)

        saved_model_path = os.path.join(train_path, 'saved_models')
        estimator.train(input_fn=train_input_fn, steps=num_train_steps)
        save_model(saved_model_path, estimator)
        print('***** Finished training at {} *****'.format(datetime.now()))

        copy_tree(
            os.path.join(saved_model_path,
                         sorted(os.listdir(saved_model_path), reverse=True)[0]),
            instance_path)

        c = Classifier(self.base_classifier_dir,
                       self.model_name,
                       forced_instance=timestamp)
        c.refresh_thresholds(limit,
                             subset_file=os.path.join(instance_path,
                                                      'test_seqs.csv'))
        return c


class _TrainModel(tasks.TaskProvider):

    def __init__(self, json: Any):
        super().__init__(json)
        self.base_classifier_dir = json['base_classifier_dir']
        self.model = json['model']
        self.vocab = json['vocab'] if 'vocab' in json else None
        self.bert = json['bert'] if 'bert' in json else None
        self.limit = json['limit'] if 'limit' in json else 2000

    def Run(self, status_holder: tasks.StatusHolder) -> None:
        status_holder.status = 'Training model ' + self.model
        # Don't use the cache for long-running operations
        if not self.bert or not self.vocab:
            c = Classifier(self.base_classifier_dir, self.model)
            if not self.bert:
                self.bert = c.embedder.bert
            if not self.vocab:
                self.vocab = c.vocab

        e = Embedder(self.bert)
        t = Trainer(self.base_classifier_dir, self.model)
        status_holder.status = str(
            t.train(embedder=e, vocab=self.vocab, limit=self.limit))


tasks.providers['TrainModel'] = _TrainModel