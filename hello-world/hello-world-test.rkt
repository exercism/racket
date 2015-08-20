#lang racket

(require rackunit)
(require rackunit/text-ui)
(require "hello-world.rkt")

(define suite
  (test-suite
    "hello world tests"

    (test-equal? "no arg returns Hello, World!" (hello) "Hello, World!")
    (test-equal? "with arg returns Hello, arg!" (hello "exercism") "Hello, exercism!")))

(exit (if (zero? (run-tests suite)) 0 1))
