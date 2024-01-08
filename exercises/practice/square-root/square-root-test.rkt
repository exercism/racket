#lang racket/base

(require "square-root.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "square-root tests"

     (test-eqv? "root of 1"
                (square-root 1)
                1)

     (test-eqv? "root of 4"
                (square-root 4)
                2)

     (test-eqv? "root of 25"
                (square-root 25)
                5)

     (test-eqv? "root of 81"
                (square-root 81)
                9)

     (test-eqv? "root of 196"
                (square-root 196)
                14)

     (test-eqv? "root of 65025"
                (square-root 65025)
                255)))

(run-tests suite))
