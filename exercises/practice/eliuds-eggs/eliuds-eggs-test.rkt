#lang racket/base

(require "eliuds-eggs.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "eliud's eggs tests"

     (test-equal? "0 eggs" (number->eggs 0) 0)

     (test-equal? "1 egg" (number->eggs 16) 1)

     (test-equal? "4 eggs" (number->eggs 89) 4)

     (test-equal? "13 eggs" (number->eggs 2000000000) 13)))

  (run-tests suite))