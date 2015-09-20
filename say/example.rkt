#lang racket/base

;; say : Convert integers to English-language descriptions

(require racket/contract)

(define UPPER-BOUND 1000000000000)
;; The largest printable number

(define scale/c (or/c 'trillion 'billion 'million 'thousand 'END))
;; Size classifiers for number chunks

(provide (contract-out
  [step1 (-> (integer-in 0 99) string?)]
  ;; Convert a positive, 2-digit number to an English string

  [step2 (-> natural-number/c (listof (integer-in 0 999)))]
  ;; Divide a large positive number into a list of 3-digit (or smaller) chunks

  [step3 (-> (integer-in (- UPPER-BOUND) UPPER-BOUND)
             (listof (cons/c natural-number/c scale/c)))]
  ;; Break a number into chunks and insert scales between the chunks

  [step4 (-> (integer-in (- UPPER-BOUND) UPPER-BOUND)
             string?)]
  ;; Convert a number to an English-language string
))

;; =============================================================================

(define (step1 n)
  'TODO)

(define (step2 n)
  'TODO)

(define (step3 n)
  'TODO)

(define (step4 n)
  'TODO)

