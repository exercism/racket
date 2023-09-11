# Exercism Racket Track

[![Configlet Status](https://github.com/exercism/racket/actions/workflows/configlet.yml/badge.svg)](https://github.com/exercism/racket/actions/workflows/configlet.yml)
[![Exercise Test Status](https://github.com/exercism/racket/actions/workflows/ci.yml/badge.svg)](https://github.com/exercism/racket/actions/workflows/ci.yml)

Exercism exercises in Racket.

## Contributing

Please see the [contributing guide](https://exercism.org/docs/building). We welcome both improvements to the existing exercises and the addition of new exercises.

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

## Suuport

For support with Racket in Exercism, please visit [the Racket subcategory](https://forum.exercism.org/c/programming/racket/) on the official [Exercism forum](https://forum.exercism.org).

## Submitting a Pull Request

Pull requests should be focused on a single exercise, issue, or conceptually cohesive change. Please refer to Exercism's [pull request guidelines](https://github.com/exercism/docs/blob/master/contributing/pull-request-guidelines.md). If you plan to make significant or breaking changes, please open an issue so we can discuss it first.

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
