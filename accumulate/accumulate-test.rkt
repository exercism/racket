#lang racket

(require "accumulate.rkt")

(module+ test
  (require rackunit rackunit/text-ui)
  
  (define suite
    (test-suite
     "accumulate tests"
     
     (test-equal? "empty list"
                  (accumulate empty (lambda (arg) (arg)))
                  empty)     
     
     (test-equal? "doubling"
                  (accumulate '(1 3 4) (lambda (arg) (arg * arg)))
                  '(1 9 16))     
     
     (run-tests suite))))
