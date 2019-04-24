#lang racket/base

(provide (contract-out
  [encode (string? . -> . string?)]
  [decode (string? . -> . string?)]

(define (encode msg)
  "not implemented")

(define (decode msg)
  "not implemented")
