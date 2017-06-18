# Exercism Racket Track

Exercism problems in Racket.

## Working on the Exercises

We welcome both improvements to the existing exercises and the addition of new exercises. A pool of exercise ideas can be found in the [x-common repo](https://github.com/exercism/x-common). An overview about which language tracks implement which exercises is at [synopsis.exercism.io](http://synopsis.exercism.io/).

Each exercise should have an example solution and a test suite, as well as a stub file for the solution declaring the module and exports.

### Naming Conventions

The example solution should be named `example.rkt`. The test should be named `<exercise-name>-test.rkt`, and the stub should be named `<exercise-name>.rkt`.

For example, if you were to work on the `binary` exercise, you would have the following three files:

```bash
$ tree
.
├── binary.rkt
├── binary-test.rkt
└── example.rkt
```

### Code Style
The Racket code in this repo is meant to conform with the conventions set forth in [How to Program Racket](http://docs.racket-lang.org/style/index.html).

### Dependencies
Try to avoid external dependencies.

### Pull Requests
Prior to submitting a pull request, ensure that your test requires the stub file, and not the example file - like so:

```Racket
#lang racket/base

(require "perfect-numbers.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "perfect numbers tests"

     (test-equal? "no perfect numbers in 1 - 5"
                  (perfect-numbers 5)
                  '())))

  (run-tests suite))
```
The exercise should also be added as a value for the `problems` key in [config.json](https://github.com/exercism/racket/blob/master/config.json); otherwise, the pull request will not pass the Travis CI build. Use [Order of exercises](https://github.com/exercism/racket/wiki/Order-of-exercises) in our wiki to find a good place for the new exercise in the curriculum.

You can perform additional checks by running the following in your terminal:

```bash
bin/check_exercises.sh
```

and:

```bash
bin/configlet .
```
Your pull request won't pass the Travis CI build if either of those fail.

If you're new to Git, take a look at [this short guide](https://github.com/exercism/x-common/blob/master/CONTRIBUTING.md#git-basics).

## READMEs
Please do not add a README or README.md file to the problem directory. The READMEs are constructed using shared metadata, which lives in the [exercism/x-common](https://github.com/exercism/x-common) repository.

## Contributing Guide

Please see the [contributing guide](https://github.com/exercism/x-api/blob/master/CONTRIBUTING.md#the-exercise-data)


## Racket icon
The Racket logo was created by [Matthew Butterick](https://en.wikipedia.org/wiki/Matthew_Butterick) and released under the Creative Commons Attribution-Share Alike 3.0 Unported license.
We have adapted it, changing the colour scheme, for use on Exercism.
