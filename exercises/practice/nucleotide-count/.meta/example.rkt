#lang racket

(provide nucleotide-counts)

(define (nucleotide-counts strand)
  (if (valid-nucleotides? strand)
      (map (lambda (c) (cons c (dna-count c strand))) (string->list "ACGT"))
      (raise-argument-error 'nucleotide-counts "strand with valid nucleotides" strand)))

(define (valid-nucleotides? strand)
  (if (andmap (lambda (n) (member n (string->list "ACGT"))) (string->list strand))
      #t
      #f))

(define (dna-count nucleotide strand)
  (length (filter (lambda (x) (char=? nucleotide x)) (string->list strand))))
