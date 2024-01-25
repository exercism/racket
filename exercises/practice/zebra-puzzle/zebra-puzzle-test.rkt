#lang racket/base

(require "zebra-puzzle.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
      "zebra puzzle tests"

      (test-equal? "who owns the zebra?"
		   (owns-zebra) 'Japanese)

      (test-equal? "who drinks water?"
		   (drinks-water) 'Norwegian)))
  (run-tests suite))
