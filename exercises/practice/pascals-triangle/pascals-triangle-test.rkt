#lang racket/base

(require "pascals-triangle.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite "pascal's triangle tests"

      (test-equal? "zero rows"
        (rows 0)
        '())

      (test-equal? "single row"
        (rows 1)
        '((1)))

      (test-equal? "two rows"
        (rows 2)
        '((1)
          (1 1)))

      (test-equal? "three rows"
        (rows 3)
        '((1)
          (1 1)
          (1 2 1)))

      (test-equal? "four rows"
        (rows 4)
        '((1)
          (1 1)
          (1 2 1)
          (1 3 3 1)))

      (test-equal? "five rows"
        (rows 5)
        '((1)
          (1 1)
          (1 2 1)
          (1 3 3 1)
          (1 4 6 4 1)))

      (test-equal? "six rows"
        (rows 6)
        '((1)
          (1 1)
          (1 2 1)
          (1 3 3 1)
          (1 4 6 4 1)
          (1 5 10 10 5 1)))

      (test-equal? "ten rows"
        (rows 10)
        '((1)
          (1 1)
          (1 2 1)
          (1 3 3 1)
          (1 4 6 4 1)
          (1 5 10 10 5 1)
          (1 6 15 20 15 6 1)
          (1 7 21 35 35 21 7 1)
          (1 8 28 56 70 56 28 8 1)
          (1 9 36 84 126 126 84 36 9 1)))))

  (run-tests suite))
