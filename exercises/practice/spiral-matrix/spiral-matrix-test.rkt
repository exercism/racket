#lang racket/base

(require "spiral-matrix.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite "spiral matrix tests"
      (test-equal? "empty spiral"
        (spiral-matrix 0)
        '())

      (test-equal? "trivial spiral"
        (spiral-matrix 1)
        '((1)))

      (test-equal? "spiral of size 2"
        (spiral-matrix 2)
        '((1 2)
          (4 3)))

      (test-equal? "spiral of size 3"
        (spiral-matrix 3)
        '((1 2 3)
          (8 9 4)
          (7 6 5)))

      (test-equal? "spiral of size 4"
        (spiral-matrix 4)
        '((1 2 3 4)
          (12 13 14 5)
          (11 16 15 6)
          (10 9 8 7)))

      (test-equal? "spiral of size 5"
        (spiral-matrix 5)
        '((1 2 3 4 5)
          (16 17 18 19 6)
          (15 24 25 20 7)
          (14 23 22 21 8)
          (13 12 11 10 9)))))

  (run-tests suite))

