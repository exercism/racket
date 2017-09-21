#lang racket

(require "pascals-triangle.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "pascals-triangle tests"

     (test-equal? "zero-rows"
                  (rows 0)
                  '())

     (test-equal? "single row"
                  (rows 1)
                  '((1)))

     (test-equal? "two-rows"
                  (rows 2)
                  '((1) (1 1)))

     (test-equal? "three-rows"
                  (rows 3)
                  '((1) (1 1) (1 2 1)))

     (test-equal? "four-rows"
                  (rows 4)
                  '((1) (1 1) (1 2 1) (1 3 3 1)))

     (test-equal? "negative-rows"
                  (rows -1)
                  '())))

  (run-tests suite))
