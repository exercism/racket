#lang racket

(require rackunit)
(require rackunit/text-ui)
(require "hello-world.rkt")

(define hello-tests
  (test-suite
    "hello world tests"
    
    (test-equal? "no arg returns Hello, World!" (hello) "Hello, World!")
    (test-equal? "with arg returns Hello, arg!" (hello "exercism") "Hello, exercism!")))

(run-tests hello-tests)
