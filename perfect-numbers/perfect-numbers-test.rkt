#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require "perfect-numbers.rkt")

(define perfect-numbers-tests
  (test-suite
   "perfect numbers tests"

   (test-equal? "no perfect numbers in 1 - 5"
              (perfect-numbers 5)
              '())

   (test-equal? "return one perfect number for range 1 - 6"
              (perfect-numbers 6)
              '(6))

   (test-equal? "return 3 perfect numbers for range 1 - 1000"
              (perfect-numbers 1000)
              '(6 28 496))

   (test-equal? "return 4 perfect numbers for range 1 - 10000"
              (perfect-numbers 10000)
              '(6 28 496 8128))))

(run-tests perfect-numbers-tests)
