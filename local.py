"local.py is a way to test the app's functionality without starting a server, not used in prod."

import os
from app import embedder
from app import classifier
from app import model_config as mc
from app import model_fetcher
from absl import app
from absl import flags

MODEL = "UPR_2percent_ps0"
INSTANCE = "1573031002"
PATH_TO_CLASSIFIER = os.path.join(
    os.getcwd(),
    "classifier_models/multilabel/{model_name}/saved_model/{training_instance}")
PATH_TO_VOCAB = os.path.join(PATH_TO_CLASSIFIER, "label.vocab")

FLAGS = flags.FLAGS

flags.DEFINE_string(
    "bert", "https://tfhub.dev/google/bert_uncased_L-12_H-768_A-12/1", "The bert model to use")
flags.DEFINE_string(
    "classifier", PATH_TO_CLASSIFIER.format(
        model_name=MODEL, training_instance=INSTANCE
    ), "The classifier model to use.")
flags.DEFINE_string("vocab",
                    PATH_TO_VOCAB.format(
                        model_name=MODEL, training_instance=INSTANCE),
                    "Where is label.vocab?")
flags.DEFINE_string("seq", "", "The string sequence to process")
flags.DEFINE_enum("mode", "embed", ["embed", "classify", "prefetch"], "The operation to perform.")


def main(argv):

    if FLAGS.mode == "embed":
        e = embedder.Embedder(FLAGS.bert)
        m = e.GetEmbedding(FLAGS.seq)
        print(len(m.tostring()))
    elif FLAGS.mode == "classify":
        c = classifier.Classifier(
            FLAGS.bert, FLAGS.classifier, FLAGS.vocab, prefetch=True)
        print(c.classify(FLAGS.seq))
    elif FLAGS.mode == "prefetch":
        f = model_fetcher.Fetcher()
        new = f.fetchAll()
        for l in new:
            print(l)
    return


if __name__ == '__main__':
    os.environ['TFHUB_CACHE_DIR'] = os.getcwd() + "/bert_models"
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = (
        "/home/samschaevitz/Downloads/BERT Classification-9a8b5ef88627.json")
    app.run(main)
