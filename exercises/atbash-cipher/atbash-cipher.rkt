#lang racket

(provide (contract-out
          [encode (string? . -> . string?)]
          [decode (string? . -> . string?)]))

(define (encode m)
  "not implemented")

; The Atbash cipher is symmetric: encoding and decoding perform the same operation.
(define (decode m)
  (encode m))
