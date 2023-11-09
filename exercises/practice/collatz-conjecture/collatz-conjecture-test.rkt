#lang racket/base

(require "collatz-conjecture.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define (exn-msg-matches? msg f)
    (with-handlers ([exn:fail? (lambda (exn)
                                 (string=? (exn-message exn) msg))])
      (f)))

  (define suite
    (test-suite
     "collatz conjecture tests"

     (test-eqv? "zero steps for one"
                (collatz 1)
                0)

     (test-eqv? "divide if even"
                (collatz 16)
                4)

     (test-eqv? "even and odd steps"
                (collatz 12)
                9)

     (test-eqv? "Large number of even and odd steps"
                (collatz 1000000)
                152)

     (test-true "zero is an error"
                (exn-msg-matches?
                  "Only positive integers are allowed"
                  (lambda () (collatz 0))))

     (test-true "negative value is an error"
                (exn-msg-matches?
                  "Only positive integers are allowed"
                  (lambda () (collatz -15))))

     (test-true "non exact value is an error"
                (exn-msg-matches?
                  "Only positive integers are allowed"
                  (lambda () (collatz 3.4))))))

(run-tests suite))
