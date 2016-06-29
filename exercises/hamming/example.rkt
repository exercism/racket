#lang racket

(provide hamming-distance)

(define (hamming-distance dna1 dna2)
  (if (= (string-length dna1) (string-length dna2))
      (length
       (filter not
               (map char=?
                    (string->list dna1)
                    (string->list dna2))))
      (error "String length mismatch.")))
