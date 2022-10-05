#lang racket/base
(require racket/contract)

(provide (contract-out
          [encode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]
          [decode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]))

(define (encode msg a b)
  (error "Not implemented yet"))

(define (decode msg a b)
  (error "Not implemented yet"))
