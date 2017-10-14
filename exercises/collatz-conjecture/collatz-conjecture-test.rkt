#lang racket/base

(require "collatz-conjecture.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "collatz-conjecture tests"

     (test-eqv? "zero steps for one" (collatz 1) 0)
     (test-eqv? "divide if even" (collatz 16) 4)
     (test-eqv? "even and odd steps" (collatz 12) 9)
     (test-eqv? "Large number of even and odd steps" (collatz 1000000) 152)
     (test-eqv? "zero is an error" (collatz 0) "Error: number must be a positive integer")
     (test-eqv? "negative value is an error" (collatz -15) "Error: number must be a positive integer")
     (test-eqv? "non exact value is an error" (collatz 3.4) "Error: number must be a positive integer")))

  (run-tests suite))
