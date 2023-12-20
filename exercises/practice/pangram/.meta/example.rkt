#lang racket

(provide pangram?)

(define alphabet-length
 (length (string->list "abcdefghijklmnopqrstuvwxyz")))

(define (pangram? sentence)
 (define letters (for/set ([chr sentence]
                           #:when (char-alphabetic? chr))
                  (char-downcase chr)))
 (eq? (set-count letters) alphabet-length))
