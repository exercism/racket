#lang racket

(require "accumulate.rkt")

(module+ test
  (require rackunit rackunit/text-ui)
  
  (define reverse-words (lambda (word)
                          (list->string (reverse (string->list word)))))
  
  (define suite
    (test-suite
     "accumulate tests"
     
     (test-equal? "empty list"              
                  (accumulate empty (lambda (arg) arg))
                  empty)
     
     
     (test-equal? "squaring"              
                  (accumulate '(1 3 4) (lambda (arg) (* arg arg)))
                  '(1 9 16))              
     
     (test-equal? "upper cases"
                  (let 
                      ([toupper (lambda (word) (string-upcase word))])
                    (accumulate '("hello" "world") toupper))
                  '("HELLO" "WORLD"))                
     
     (test-equal? "reverse strings"                
                  (accumulate (list "the" "quick" "brown" "fox" "jumped" "over" "the" "lazy" "dog") reverse-words)
                  (map reverse-words '("the" "quick" "brown" "fox" "jumped" "over" "the" "lazy" "dog")))
     
     
     (run-tests suite))))
