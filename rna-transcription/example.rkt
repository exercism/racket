#lang racket

(provide to-rna)

(define (to-rna dna)
  (let ([dna-seq (string->list dna)])
    (apply string
           (map (lambda (c) (rest (assoc c lookup))) dna-seq))))

(define lookup
  '((#\C . #\G)
    (#\G . #\C)
    (#\A . #\U)
    (#\T . #\A)))
