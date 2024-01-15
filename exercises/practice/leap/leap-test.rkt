#lang racket/base

(require "leap.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "leap tests"

     (test-false "year not divisible by 4 is a common year"
                 (leap-year? 2015))

     (test-false "year divisible by 2, not divisible by 4 is a common year" 
                 (leap-year? 1970))

     (test-true "year divisible by 4, not divisible by 100 is a leap year"
                (leap-year? 1996))

     (test-true "year divisible by 4 and 5 is still a leap year"
                (leap-year? 1960))

     (test-false "year divisible by 100, not divisible by 400 is a common year"
                 (leap-year? 2100))

     (test-false "year divisible by 100 but not by 3 is still not a leap year"
                 (leap-year? 1900))

     (test-true "year divisible by 400 is a leap year"
                (leap-year? 2000))

     (test-true "year divisible by 400 but not by 125 is still a leap year"
                (leap-year? 2400))

     (test-false "year divisible by 200, not divisible by 400 is a common year"
                 (leap-year? 1800))))

  (run-tests suite))
