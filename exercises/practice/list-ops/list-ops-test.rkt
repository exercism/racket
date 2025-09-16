#lang racket/base

(require "list-ops.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
     "list ops tests"

     (test-equal? "append empty lists"
                  (my-append '() '())
                  '())
            
     (test-equal? "append list to empty list"
                  (my-append '() '(1 2 3 4))
                  '(1 2 3 4))
            
     (test-equal? "append empty list to list"
                  (my-append '(1 2 3 4) '())
                  '(1 2 3 4))

     (test-equal? "append non-empty lists"
                  (my-append '(1 2) '(2 3 4 5))
                  '(1 2 2 3 4 5))

     (test-equal? "concatenate empty list"
                  (my-concatenate '())
                  '())

     (test-equal? "concatenate list of lists"
                  (my-concatenate '((1 2) (3) () (4 5 6)))
                  '(1 2 3 4 5 6))

     (test-equal? "concatenate list of nested lists"
                  (my-concatenate '(((1) (2)) ((3)) (()) ((4 5 6))))
                  '((1) (2) (3) () (4 5 6)))

     (test-equal? "filter empty list"
                  (my-filter odd? '())
                  '())

     (test-equal? "filter non-empty list"
                  (my-filter odd? '(1 2 3 5))
                  '(1 3 5))  

     (test-equal? "length of empty list"
                  (my-length '())
                  0) 

     (test-equal? "length of non-empty list"
                  (my-length '(1 2 3 4))
                  4)

     (test-equal? "map empty list"
                  (my-map add1 '())
                  '())

     (test-equal? "map non-empty list"
                  (my-map add1 '(1 3 5 7))
                  '(2 4 6 8))))

     (test-equal? "foldl empty list"
                  (my-foldl * 2 '())
                  2)

     (test-equal? "fold left direction independent function applied to non-empty list"
                  (my-foldl + 5 '(1 2 3 4))
                  15)

     (test-equal? "fold left direction dependent function applied to non-empty list"
                  (my-foldl / 24 '(1 2 3 4))
                  64)

     (test-equal? "fold right empty list"
                  (my-foldr * 2 '())
                  2)

     (test-equal? "fold right direction independent function applied to non-empty list"
                  (my-foldr + 5 '(1 2 3 4))
                  15)

     (test-equal? "fold right direction dependent function applied to non-empty list"
                  (my-foldr / 24 '(1 2 3 4))
                  9)

     (test-equal? "reverse empty list"
                  (my-reverse '())
                  '())

     (test-equal? "reverse non-empty list"
                  (my-reverse '(1 3 5 7))
                  '(7 5 3 1))

     (test-equal? "reverse list of lists is not flattened"
                  (my-reverse '((1 2) (3) () (4 5 6)))
                  '((4 5 6) () (3) (1 2)))

(run-tests suite))
