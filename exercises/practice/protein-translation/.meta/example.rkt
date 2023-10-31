#lang racket

(provide proteins)

(define (empty-string? str) ((negate non-empty-string?) str))

(define (translate protein)
  (case protein
    [("AUG") "Methionine"]
    [("UUU" "UUC") "Phenylalanine"]
    [("UUA" "UUG") "Leucine"]
    [("UCU" "UCC" "UCA" "UCG") "Serine"]
    [("UAU" "UAC") "Tyrosine"]
    [("UGU" "UGC") "Cysteine"]
    [("UGG") "Tryptophan"]
    [("UAA" "UAG" "UGA") ""]
    [else (error "Invalid codon")]))

(define (proteins strand)
  (define (codon) (translate (substring strand 0 3)))
  (cond
    [(zero? (string-length strand)) '()]
    [(< (string-length strand) 3) (error "Incomplete RNA sequence can't translate")]
    [else (cond [(empty-string? (codon)) '()]
                [else (cons (codon) (proteins (substring strand 3)))])]))
