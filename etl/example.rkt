#lang racket

(provide (contract-out
          [etl (-> valid-input valid-output)]))

(define (lower-case? s) (not (regexp-match? #rx"[A-Z]" s)))

;; Accept upper- or lower-case-letters strings as values
(define valid-input
  (hash/c exact-nonnegative-integer? (listof string?)))

;; Keys will always be lower-case
(define valid-output
  (hash/c lower-case? exact-nonnegative-integer?))

(define (etl h)
  (for*/hash ([(score letter*) (in-hash h)]
              [letter (in-list letter*)])
    (values (string-downcase letter) score)))

