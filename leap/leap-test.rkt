#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require "leap.rkt")

(define leap-tests
  (test-suite
   "leap tests"

   (test-eqv? "vanilla-leap-year" (leap-year? 1996) #t)
   (test-eqv? "any-old-year" (leap-year? 1997)#f)
   (test-eqv? "non-leap-even-year" (leap-year? 1998) #f)
   (test-eqv? "century" (leap-year? 1900)#f)
   (test-eqv? "exceptional-century" (leap-year? 2400) #t)))

(run-tests leap-tests)
