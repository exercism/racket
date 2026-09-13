#lang racket/base

(require "matrix.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "matrix tests"

     (test-equal? "extract row from one number matrix"
                  (row "1" 1)
                  '(1))

     (test-equal? "can extract row"
                  (row "1 2\n3 4" 2)
                  '(3 4))

     (test-equal? "extract row where numbers have different widths"
                  (row "1 2\n10 20" 2)
                  '(10 20))

     (test-equal? "can extract row from non-square matrix with no corresponding column"
                  (row "1 2 3\n4 5 6\n7 8 9\n8 7 6" 4)
                  '(8 7 6))

     (test-equal? "extract column from one number matrix"
                  (column "1" 1)
                  '(1))

     (test-equal? "can extract column"
                  (column "1 2 3\n4 5 6\n7 8 9" 3)
                  '(3 6 9))

     (test-equal? "can extract column from non-square matrix with no corresponding row"
                  (column "1 2 3 4\n5 6 7 8\n9 8 7 6" 4)
                  '(4 8 6))

     (test-equal? "extract column where numbers have different widths"
                  (column "89 1903 3\n18 3 1\n9 4 800" 2)
                  '(1903 3 4))))

  (run-tests suite))
