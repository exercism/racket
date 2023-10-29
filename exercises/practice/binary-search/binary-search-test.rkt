#lang racket/base

(require "binary-search.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "binary-search tests"

     (test-eqv? "finds a value in an array with one element"
                (binary-search '(6) 6)
                0)
     (test-eqv? "finds a value in the middle of an array"
                (binary-search '(1 3 4 6 8 9 11) 6)
                3)
     (test-eqv? "finds a value at the beginning of an array"
                (binary-search '(1 3 4 6 8 9 11) 1)
                0)
     (test-eqv? "finds a value at the end of an array"
                (binary-search '(1 3 4 6 8 9 11) 11)
                6)
     (test-eqv? "finds a value in an array of odd length"
                (binary-search '(1 3 5 8 13 21 34 55 89 144 233 377 634) 144)
                9)
     (test-eqv? "finds a value in an array of even length"
                (binary-search '(1 3 5 8 13 21 34 55 89 144 233 377) 21)
                5)
     (test-exn "identifies that a value is not included in the array"
               exn:fail?
               (lambda () (binary-search '(1 3 4 6 8 9 11) 7)))
     (test-exn "a value smaller than the array's smallest value is not found"
               exn:fail?
               (lambda () (binary-search '(1 3 4 6 8 9 11) 0)))
     (test-exn "a value larger than the array's smallest value is not found"
               exn:fail?
               (lambda () (binary-search '(1 3 4 6 8 9 11) 13)))
     (test-exn "nothing is found in an empty array"
               exn:fail?
               (lambda () (binary-search '() 1)))
     (test-exn "nothing is found when the left and right bounds cross"
               exn:fail?
               (lambda () (binary-search '(1 2) 0)))))

  (run-tests suite))
