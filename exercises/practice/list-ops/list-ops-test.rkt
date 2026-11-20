#lang racket/base

(require "list-ops.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "list-ops tests"

      (test-equal? "empty lists"
                   (my-append '() '())
                   '())

      (test-equal? "list to empty list"
                   (my-append '() '(1 2 3 4))
                   '(1 2 3 4))

      (test-equal? "empty list to list"
                   (my-append '(1 2 3 4) '())
                   '(1 2 3 4))

      (test-equal? "non-empty lists"
                   (my-append '(1 2) '(2 3 4 5))
                   '(1 2 2 3 4 5))

      (test-equal? "empty list"
                   (my-concatenate '())
                   '())

      (test-equal? "list of lists"
                   (my-concatenate '((1 2) (3) () (4 5 6)))
                   '(1 2 3 4 5 6))

      (test-equal? "list of nested lists"
                   (my-concatenate '(((1) (2)) ((3)) (()) ((4 5 6))))
                   '((1) (2) (3) () (4 5 6)))

      (test-equal? "empty list"
                   (my-filter odd? '())
                   '())

      (test-equal? "non-empty list"
                   (my-filter odd? '(1 2 3 5))
                   '(1 3 5))

      (test-equal? "empty list"
                   (my-length '())
                   0)

      (test-equal? "non-empty list"
                   (my-length '(1 2 3 4))
                   4)

      (test-equal? "empty list"
                   (my-map add1 '())
                   '())

      (test-equal? "non-empty list"
                   (my-map add1 '(1 3 5 7))
                   '(2 4 6 8))

      (test-equal? "empty list"
                   (my-foldl * 2 '())
                   2)

      (test-equal? "direction independent function applied to non-empty list"
                   (my-foldl + 5 '(1 2 3 4))
                   15)

      (test-equal? "direction dependent function applied to non-empty list"
                   (my-foldl / 24 '(1 2 3 4))
                   64)

      (test-equal? "empty list"
                   (my-foldr * 2 '())
                   2)

      (test-equal? "direction independent function applied to non-empty list"
                   (my-foldr + 5 '(1 2 3 4))
                   15)

      (test-equal? "direction dependent function applied to non-empty list"
                   (my-foldr / 24 '(1 2 3 4))
                   9)

      (test-equal? "empty list"
                   (my-reverse '())
                   '())

      (test-equal? "non-empty even-length list"
                   (my-reverse '(1 3 5 7))
                   '(7 5 3 1))

      (test-equal? "non-empty odd-length list"
                   (my-reverse '(1 3 5 7 9 11 13))
                   '(13 11 9 7 5 3 1))

      (test-equal? "list of lists is not flattened"
                   (my-reverse '((1 2) (3) () (4 5 6)))
                   '((4 5 6) () (3) (1 2)))))

  (run-tests suite))
