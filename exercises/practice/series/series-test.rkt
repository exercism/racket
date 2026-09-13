#lang racket/base

(require "series.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "series tests"

     (test-equal? "slices of one from one"
                  (slices "1" 1)
                  '("1"))

     (test-equal? "slices of one from two"
                  (slices "12" 1)
                  '("1" "2"))

     (test-equal? "slices of two"
                  (slices "35" 2)
                  '("35"))

     (test-equal? "slices of two overlap"
                  (slices "9142" 2)
                  '("91" "14" "42"))

     (test-equal? "slices can include duplicates"
                  (slices "777777" 3)
                  '("777" "777" "777" "777"))

     (test-equal? "slices of a long series"
                  (slices "918493904243" 5)
                  '("91849" "18493" "84939" "49390"
                    "93904" "39042" "90424" "04243"))

     (test-exn "slice length is too large"
               exn:fail?
               (lambda () (slices "12345" 6)))

     (test-exn "slice length is way too large"
               exn:fail?
               (lambda () (slices "12345" 42)))

     (test-exn "slice length cannot be zero"
               exn:fail?
               (lambda () (slices "12345" 0)))

     (test-exn "slice length cannot be negative"
               exn:fail?
               (lambda () (slices "123" -1)))

     (test-exn "empty series is invalid"
               exn:fail?
               (lambda () (slices "" 1)))))

  (run-tests suite))
