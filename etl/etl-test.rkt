#lang racket

(require "example.rkt")
;(require "etl.rkt")

;(module+ test
(require rackunit rackunit/text-ui)

(define input (hash 1 '("a" "E" "I" "o" "U" "L" "N" "r" "s" "T")
                       2 '("D" "G")
                       3 '("B" "c" "M" "P")
                       4 '("f" "h" "V" "W" "y")
                       5 '("K")
                       8 '("J" "x")
                       10 '("q" "z")))
   
(define suite
  (test-suite
   "etl tests"
   
   (test-equal? "empty hash"              
                (etl (hash))
                (hash))
   
   
   ; TODO Must be checked value by value...
   (test-equal? "mixed case input"                  
                (list-ref (hash-ref (etl input) 1) 0)
                #|(define expected-result (hash "a" 1 "b" 3 "c" 3 "d" 2 "e" 1 "f" 4 "g" 2 
                                              "h" 4 "i" 1 "j" 8 
                                              "k" 5 "l" 1 "m" 3 "n" 1 "o" 1 "p" 3 "q" 10 
                                              "r" 1 "s" 1 "t" 1 
                                              "u" 1 "v" 4 "x" 8 "w" 4 "y" 4 "z" 10))|#
                1)
                
                
                ; TODO Test error when providing other types of input (e.g., characters)
                ;(run-tests suite))))
                ))