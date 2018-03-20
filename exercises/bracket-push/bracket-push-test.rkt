#lang racket/base

(require "bracket-push.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "bracket push tests"

     (test-eqv? "paired square brackets"
                (is-paired? "[]")
                #t)
     (test-eqv? "empty string"
                (is-paired? "")
                #t)
     (test-eqv? "unpaired brackets"
                (is-paired? "[[")
                #f)
     (test-eqv? "wrong ordered brackets"
                (is-paired? "}{")
                #f)
     (test-eqv? "wrong closing bracket"
                (is-paired? "{]")
                #f)
     (test-eqv? "paired with whitespace"
                (is-paired? "{ }")
                #t)
     (test-eqv? "simple nested brackets"
                (is-paired? "{[]}")
                #t)
     (test-eqv? "several paired brackets"
                (is-paired? "{}[]")
                #t)
     (test-eqv? "paired and nested brackets"
                (is-paired? "([{}({}[])])")
                #t)
     (test-eqv? "unopened closing brackets"
                (is-paired? "{[)][]}")
                #f)
     (test-eqv? "unpaired and nested brackets"
                (is-paired? "([{])")
                #f)
     (test-eqv? "paired and wrong nested brackets"
                (is-paired? "[({]})")
                #f)
     (test-eqv? "math expression"
                (is-paired? "(((185 + 223.85) * 15) - 543)/2")
                #t)
     (test-eqv? "complex latex expression"
                (is-paired? "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")
                #t)))
  (run-tests suite))
