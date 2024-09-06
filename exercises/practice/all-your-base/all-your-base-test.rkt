#lang racket

(require "all-your-base.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "all-your-base tests"

      (test-equal? "single-bit-one-to-decimal"
                   (rebase '( 1 ) 2 10)
                   '( 1 ))

      (test-equal? "binary-to-single-decimal"
                   (rebase '( 1 0 1 ) 2 10)
                   '( 5 ))

      (test-equal? "single-decimal-to-binary"
                   (rebase '( 5 ) 10 2)
                   '( 1 0 1 ))

      (test-equal? "binary-to-multiple-decimal"
                   (rebase '( 1 0 1 0 1 0 ) 2 10)
                   '( 4 2 ))

      (test-equal? "decimal-to-binary"
                   (rebase '( 4 2 ) 10 2)
                   '( 1 0 1 0 1 0 ))

      (test-equal? "trinary-to-hexadecimal"
                   (rebase '( 1 1 2 0 ) 3 16)
                   '( 2 10 ))

      (test-equal? "hexadecimal-to-trinary"
                   (rebase '( 2 10 ) 16 3)
                   '( 1 1 2 0 ))

      (test-equal? "number-15-bit-integer"
                   (rebase '( 3 46 60 ) 97 73)
                   '( 6 10 45 ))

      (test-equal? "empty-list"
                   (rebase '() 2 10)
                   '( 0 ))

      (test-equal? "single-zero"
                   (rebase '( 0 ) 10 2)
                   '( 0 ))

      (test-equal? "multiple-zeros"
                   (rebase '( 0 0 0 ) 10 2)
                   '( 0 ))

      (test-equal? "leading-zeros"
                   (rebase '( 0 6 0 ) 7 10)
                   '( 4 2 ))

      (test-false "input-base-is-one"
                   (rebase '( 0 ) 1 10))

      (test-false "input-base-is-zero"
                   (rebase '() 0 10))

      (test-false "input-base-is-negative"
                   (rebase '( 1 ) -2 10))

      (test-false "negative-digit"
                   (rebase '( 1 -1 1 0 1 0 ) 2 10))

      (test-false "invalid-positive-digit"
                   (rebase '( 1 2 1 0 1 0 ) 2 10))

      (test-false "output-base-is-one"
                   (rebase '( 1 0 1 0 1 0 ) 2 1))

      (test-false "output-base-is-zero"
                   (rebase '( 7 ) 10 0))

      (test-false "output-base-is-negative"
                   (rebase '( 1 ) 2 -7))

      (test-false "both-bases-are-negative"
                   (rebase '( 1 ) -2 -7))))

    (run-tests suite))
