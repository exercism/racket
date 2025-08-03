#lang racket

(require racket/contract)

(provide (contract-out
          [encode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]
          [decode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]))

(define (encode msg a b)
  (error "Please implement 'encode'"))

(define (decode msg a b)
  (error "Please implement 'decode'"))
