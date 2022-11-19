#lang racket

(require "hello-world.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "hello world tests"

     (test-equal? "returns Hello, World!" (hello) "Hello, World!")))

  (run-tests suite))
