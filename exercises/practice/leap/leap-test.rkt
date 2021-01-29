#lang racket/base

(require "leap.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "leap tests"

     (test-eqv? "vanilla-leap-year" (leap-year? 1996) #t)
     (test-eqv? "any-old-year" (leap-year? 2015)#f)
     (test-eqv? "non-leap-even-year" (leap-year? 1998) #f)
     (test-eqv? "century" (leap-year? 2100)#f)
     (test-eqv? "not an exceptional-century" (leap-year? 1800) #f)
     (test-eqv? "exceptional-century" (leap-year? 2000) #t)))

  (run-tests suite))
