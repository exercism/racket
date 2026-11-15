#lang racket/base

(require "perfect-numbers.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "perfect-numbers tests"
      (test-equal? "Smallest perfect number is classified correctly"
                   (classify 6)
                   'perfect)

      (test-equal? "Medium perfect number is classified correctly"
                   (classify 28)
                   'perfect)

      (test-equal? "Large perfect number is classified correctly"
                   (classify 33550336)
                   'perfect)

      (test-equal? "Smallest abundant number is classified correctly"
                   (classify 12)
                   'abundant)

      (test-equal? "Medium abundant number is classified correctly"
                   (classify 30)
                   'abundant)

      (test-equal? "Large abundant number is classified correctly"
                   (classify 33550335)
                   'abundant)

      (test-equal? "Perfect square abundant number is classified correctly"
                   (classify 196)
                   'abundant)

      (test-equal? "Smallest prime deficient number is classified correctly"
                   (classify 2)
                   'deficient)

      (test-equal? "Smallest non-prime deficient number is classified correctly"
                   (classify 4)
                   'deficient)

      (test-equal? "Medium deficient number is classified correctly"
                   (classify 32)
                   'deficient)

      (test-equal? "Large deficient number is classified correctly"
                   (classify 33550337)
                   'deficient)

      (test-equal? "Edge case (no factors other than itself) is classified correctly"
                   (classify 1)
                   'deficient)))


  (run-tests suite))
