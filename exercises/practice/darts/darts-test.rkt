#lang racket

(require "darts.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
      "darts tests"

      (test-equal? "Missed target"
                  (score -9.0 9.0)
                  0)

      (test-equal? "On the outer circle"
                  (score 0.0 10.0)
                  1)

      (test-equal? "On the middle circle"
                  (score -5.0 0.0)
                  5)

      (test-equal? "On the inner circle"
                  (score 0.0 -1.0)
                  10)

      (test-equal? "Exactly on centre"
                  (score 0.0 0.0)
                  10)

      (test-equal? "Near the centre"
                  (score -0.1 -0.1)
                  10)

      (test-equal? "Just within the inner circle"
                  (score 0.7 0.7)
                  10)

      (test-equal? "Just outside the inner circle"
                  (score 0.8 -0.8)
                  5)

      (test-equal? "Just within the middle circle"
                  (score -3.5 3.5)
                  5)

      (test-equal? "Just outside the middle circle"
                  (score -3.6 -3.6)
                  1)

      (test-equal? "Just within the outer circle"
                  (score -7.0 7.0)
                  1)

      (test-equal? "Just outside the outer circle"
                  (score 7.1 -7.1)
                  0)

      (test-equal? "Asymmetric position between the inner and middle circles"
                  (score 0.5 -4.0)
                  5)))

  (run-tests suite))
