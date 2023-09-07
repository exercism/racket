#lang racket/base

(require "armstrong-numbers.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
  	(test-suite
  		"armstrong numbers tests"
  		(test-true "Zero is an Armstrong number"
  					(armstrong-number? 0))

        (test-true "Single-digit numbers are Armstrong numbers"
  					(armstrong-number? 5))

        (test-false "There are no two-digit Armstrong numbers"
  					(armstrong-number? 10))

        (test-true "Three-digit number that is an Armstrong number"
  					(armstrong-number? 153))

        (test-false "Three-digit number that is not an Armstrong number"
  					(armstrong-number? 100))

        (test-true "Four-digit number that is an Armstrong number"
  					(armstrong-number? 9474))

        (test-false "Four-digit number that is not an Armstrong number"
  					(armstrong-number? 9475))

        (test-true "Seven-digit number that is an Armstrong number"
  					(armstrong-number? 9926315))

        (test-false "Seven-digit number that is not an Armstrong number"
  					(armstrong-number? 9926314))

        (test-true "Armstrong number containing seven zeroes"
  					(armstrong-number? 186709961001538790100634132976990))

        (test-true "The largest and last Armstrong number"
  					(armstrong-number? 115132219018763992565095597973971522401))))

 (run-tests suite))
