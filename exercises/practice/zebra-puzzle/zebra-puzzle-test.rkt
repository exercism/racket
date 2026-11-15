#lang racket/base

(require "zebra-puzzle.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "zebra-puzzle tests"
      (test-equal? "resident who drinks water"
                   (drinks-water)
                   'Norwegian)
      (test-equal? "resident who owns zebra"
                   (owns-zebra)
                   'Japanese)))

  (run-tests suite))
