#lang racket

;; Converts integers to English-language descriptions

;; --- NOTE -------------------------------------------------------------------
;; The test cases in "say-test.rkt" assume:
;; - Calling a function with an out-of-range argument triggers a contract error
;; - That `step3` returns a list of (number, symbol) pairs
;;
;; We have provided sample contracts so the tests compile, but you
;;  will want to edit & strengthen these.
;;
;; (For example, things like 0.333 and 7/8 pass the `number?` contract
;;  but these functions expect integers and natural numbers)
;; ----------------------------------------------------------------------------

(require racket/contract)

(provide (contract-out
  [step1 (-> number? string?)]
  ;; Convert a positive, 2-digit number to an English string

  [step2 (-> number? (listof number?))]
  ;; Divide a large positive number into a list of 3-digit (or smaller) chunks

  [step3 (-> number? (listof (cons/c number? symbol?)))]
  ;; Break a number into chunks and insert scales between the chunks

  [step4 (-> number? string?)]
  ;; Convert a number to an English-language string
))

;; =============================================================================

(define (step1 n)
  (error "Please implement 'step1'"))

(define (step2 N)
  (error "Please implement 'step2'"))

(define (step3 n)
  (error "Please implement 'step3'"))

(define (step4 N)
  (error "Please implement 'step4'"))
