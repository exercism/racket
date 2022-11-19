#lang racket/base

(require "matching-brackets.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "matching brackets tests"

     ; Simple passing tests
     (test-eqv? "empty is balanced" (balanced? "") #t)
     (test-eqv? "'[]' is balanced" (balanced? "[]") #t)
     (test-eqv? "'{}' is balanced" (balanced? "{}") #t)
     (test-eqv? "'{ }' is balanced" (balanced? "{ }") #t)
     (test-eqv? "'()' is balanced" (balanced? "()") #t)

     ; Complicated passing tests
     (test-eqv? "'()[]{}' is balanced" (balanced? "()[]{}") #t)
     (test-eqv? "'([{}])' is balanced" (balanced? "([{}])") #t)
     (test-eqv? "'([{}({}[])])' is balanced" (balanced? "([{}({}[])])") #t)

     ; Additional characters but still balanced
     (test-eqv? "'123' is balanced" (balanced? "123") #t)
     (test-eqv? "'[1]' is balanced" (balanced? "[1]") #t)
     (test-eqv? "'(((185 + 223.85) * 15) - 543)/2' is balanced" (balanced? "(((185 + 223.85) * 15) - 543)/2") #t)
     (test-eqv? "'a{b}c(d)e[f]g' is balanced" (balanced? "a{b}c(d)e[f]g") #t)
     (test-eqv? "'a{b(c[de]f)g}h' is balanced" (balanced? "a{b(c[de]f)g}h") #t)

     ; Simple failing tests
     (test-eqv? "'][' is UN-balanced" (balanced? "][") #f)
     (test-eqv? "')(' is UN-balanced" (balanced? ")(") #f)
     (test-eqv? "'}{' is UN-balanced" (balanced? "}{") #f)
     (test-eqv? "'(]' is UN-balanced" (balanced? "(]") #f)
     (test-eqv? "']]' is UN-balanced" (balanced? "][") #f)
     (test-eqv? "'((' is UN-balanced" (balanced? "((") #f)

     ; Complicated failing tests
     (test-eqv? "'{}[' is UN-balanced" (balanced? "{}[") #f)
     (test-eqv? "'[}]' is UN-balanced" (balanced? "[}]") #f)
     (test-eqv? "'{[}' is UN-balanced" (balanced? "{[}") #f)
     (test-eqv? "'{[])' is UN-balanced" (balanced? "{[])") #f)
     (test-eqv? "'{}[()' is UN-balanced" (balanced? "{}[()") #f)
     (test-eqv? "'{[)][]}' is UN-balanced" (balanced? "{[)][]}") #f)

     ; Additional characters but unbalanced
     (test-eqv? "'(1]' is UN-balanced" (balanced? "(1]") #f)
     (test-eqv? "'{}[1' is UN-balanced" (balanced? "{}[1") #f)

     ))

  (run-tests suite))
