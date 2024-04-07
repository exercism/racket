#lang racket/base

(require "binary-search.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "binary-search tests"

     (test-eqv? "finds a value in a vector with one element"
                (binary-search #(6) 6)
                0)
     (test-eqv? "finds a value in the middle of a vector"
                (binary-search #(1 3 4 6 8 9 11) 6)
                3)
     (test-eqv? "finds a value at the beginning of a vector"
                (binary-search #(1 3 4 6 8 9 11) 1)
                0)
     (test-eqv? "finds a value at the end of a vector"
                (binary-search #(1 3 4 6 8 9 11) 11)
                6)
     (test-eqv? "finds a value in a vector of odd length"
                (binary-search #(1 3 5 8 13 21 34 55 89 144 233 377 634) 144)
                9)
     (test-eqv? "finds a value in a vector of even length"
                (binary-search #(1 3 5 8 13 21 34 55 89 144 233 377) 21)
                5)
     (test-eqv? "identifies that a value is not included in the vector"
               (binary-search #(1 3 4 6 8 9 11) 7)
               #f)
     (test-eqv? "a value smaller than the vector's smallest value is not found"
               (binary-search #(1 3 4 6 8 9 11) 0)
               #f)
     (test-eqv? "a value larger than the vector's largest value is not found"
               (binary-search #(1 3 4 6 8 9 11) 13)
               #f)
     (test-eqv? "nothing is found in an empty vector"
               (binary-search #() 1)
               #f)
     (test-eqv? "nothing is found when the left and right bounds cross"
               (binary-search #(1 2) 0)
               #f)))

  (run-tests suite))
