# topic-classification

Learn and apply paragraph to attribute training.

## Installation

This code requires Python 3.6 and pip.

To install, run

```bash
./run install
```

## Setup

The code requires a BERT(-like) model to produce sequence (sentence / paragraph) embeddings.

A good starting point is "https://tfhub.dev/google/bert_uncased_L-12_H-768_A-12/1".

Model names starting with "http" are retrieved from tfhub, others are loaded from bert_models/.

## Running

To run the web service, `./run server`.

## Testing

To run operations from the command line, `./run local --help`.

To run nose tests, `./run test`.

To run pycodestyle, `./run lint`.
