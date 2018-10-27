# Exercism Racket Track

[![Build Status](https://travis-ci.org/exercism/racket.svg?branch=master)](https://travis-ci.org/exercism/racket)

Exercism exercises in Racket.

## Contributing

Please read about how to [get involved in a track](https://github.com/exercism/docs/tree/master/contributing-to-language-tracks). Also, be sure to read the Exercism [Code of Conduct](https://exercism.io/code-of-conduct).

We welcome both improvements to the existing exercises and the addition of new exercises. If you are creating a new exercise from scratch please see [adding new exercises](https://github.com/exercism/docs/blob/master/you-can-help/make-up-new-exercises.md).  If you are porting an exercise that exists in other exercism language tracks, see [porting an exercise](https://github.com/exercism/docs/blob/master/you-can-help/implement-an-exercise-from-specification.md).

Please note that this track's exercises must conform to the Exercism-wide standards described in the [documentation](https://github.com/exercism/docs/tree/master/language-tracks/exercises). If you're unsure about how to make a change, then go ahead and open an issue on Github.

Each exercise should have an example solution, a description file, a test suite and a stub file for the solution declaring the module and exports.

### Naming Conventions

The example solution should be named `example.rkt`. The description file: `README.md`. The test suite: `<exercise-name>-test.rkt`, and the stub: `<exercise-name>.rkt`.

For example, if you were to work on the `binary` exercise, you would create and commit the following four files:

```bash
$ racket/exercises/binary/
.
├── binary.rkt
├── binary-test.rkt
├── README.md
└── example.rkt
```

### Code Style
The Racket code in this repo is meant to conform with the conventions set forth in [How to Program Racket](http://docs.racket-lang.org/style/index.html).

### Dependencies
Try to avoid external dependencies.

### Creating the description file

`README.md` may be [generated](https://github.com/exercism/docs/blob/master/maintaining-a-track/regenerating-exercise-readmes.md) from exercism data. The generator will use the `description.md` from the exercise directory in the [problem-specifications repository](https://github.com/exercism/problem-specifications/tree/master/exercises).  To generate `README.md` for your execise only use the following command from your racket track directory:

```bash
bin/configlet generate . --only <exercise-name>
```

### Adding the exercise to config.json
Be sure to add the exercise to an appropriate place in the `config.json` file.  The position in the file determines the order exercises are fetched by users.  Generate a unique UUID for the exercise with ```configlet uuid```.  Finally check `config.json` with:

```bash
bin/configlet lint .
```

## Opening an Issue

If you plan to make significant or breaking changes, please open an issue so we can discuss it first. If this is a discussion that is relevant to more than just the Racket track, please open an issue in [exercism/discussions](https://github.com/exercism/discussions/issues).

## Submitting a Pull Request

Pull requests should be focused on a single exercise, issue, or conceptually cohesive change. Please refer to Exercism's [pull request guidelines](https://github.com/exercism/docs/blob/master/contributing/pull-request-guidelines.md).

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

## Racket icon
The Racket logo was created by [Matthew Butterick](https://en.wikipedia.org/wiki/Matthew_Butterick) and released under the Creative Commons Attribution-Share Alike 3.0 Unported license.
We have adapted it, changing the colour scheme for use on Exercism.
