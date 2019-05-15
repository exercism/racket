#lang racket

(provide (contract-out
          [armstrong-number? (exact-nonnegative-integer? . -> . boolean?)]))

(define (armstrong-number? n)
  "not implemented")
