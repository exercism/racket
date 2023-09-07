#lang racket/base

(require "matching-brackets.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "matching brackets tests"

     (test-true "paired square brackets"
                (balanced? "[]"))

     (test-true "empty string"
                (balanced? ""))

     (test-false "unpaired brackets"
                (balanced? "[["))

     (test-false "wrong ordered brackets"
                (balanced? "}{"))

     (test-false "wrong closing bracket"
                (balanced? "{]"))

     (test-true "paired with whitespace"
                (balanced? "{ }"))

     (test-false "partially paired brackets"
                (balanced? "{[])"))

     (test-true "several paired brackets"
                (balanced? "{}[]"))

     (test-true "paired and nested brackets"
                (balanced? "([{}({}[])])"))

     (test-false "unopened closing brackets"
                (balanced? "{[)][]}"))

     (test-false "unpaired and nested brackets"
                (balanced? "([{])"))

     (test-false "paired and wrong nested brackets"
                (balanced? "[({]})"))

     (test-false "paired and wrong nested brackets but innermost are correct"
                (balanced? "[({}])"))

     (test-false "paired and incomplete brackets"
                (balanced? "{}["))

     (test-false "too many closing brackets"
                (balanced? "[]]"))

     (test-false "early unexpected brackets"
                (balanced? ")()"))

     (test-false "early mismatched brackets"
                (balanced? "{)()"))

     (test-true "math expression"
                (balanced? "(((185 + 223.85) * 15) - 543)/2"))

     (test-true "complex latex expression"
                (balanced? "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)"))))

  (run-tests suite))
