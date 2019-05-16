#lang racket

(provide (contract-out
          [isogram? (string? . -> . boolean?)]))

(define (isogram? s)
  (if (check-duplicates
       (filter (λ (c)
                 (char-alphabetic? c))
               (string->list
                (string-downcase s))))
      #f
      #t))
