#lang racket
(require "robot-name.rkt")

(module+ test
  (require rackunit
           rackunit/text-ui)
  (define suite
    (test-suite
     "robot name test"))

  (run-tests suite))

(define (check-robot-name n)
  (regexp-match #px"\\p{Lu}{2}\\p{Nd}{4}" n))