#lang racket/base

(require "nth-prime.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "nth prime tests"
     (test-equal? "first prime"
                  (nth-prime 1)
                  2)
     (test-equal? "second prime"
                  (nth-prime 2)
                  3)
     (test-equal? "sixth prime"
                  (nth-prime 6)
                  13)
     (test-equal? "big prime"
                  (nth-prime 10001)
                  104743)
     (test-exn "there is no zeroth prime"
               exn:fail? (lambda () (nth-prime 0)))))

  (run-tests suite))
