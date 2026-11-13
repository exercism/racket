#lang racket/base

(require "collatz-conjecture.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite "collatz-conjecture tests"
      (test-eqv? "zero steps for one"
                 (collatz 1)
                 0)

      (test-eqv? "divide if even"
                 (collatz 16)
                 4)

      (test-eqv? "even and odd steps"
                 (collatz 12)
                 9)

      (test-eqv? "large number of even and odd steps"
                 (collatz 1000000)
                 152)

      (test-exn "zero is an error"
                exn:fail?
                (lambda () (collatz 0)))

      (test-exn "negative value is an error"
                exn:fail?
                (lambda () (collatz -15)))))

  (run-tests suite))
