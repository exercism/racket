#lang racket

(define (hamming-distance dna1 dna2)
  (unless (= (string-length dna1) (string-length dna2))
    (raise-argument-error 'hamming-distance "strings of equal length" 1 dna1 dna2))
  (count (compose not eqv?) (string->list dna1) (string->list dna2)))

(provide hamming-distance)
