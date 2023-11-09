#lang racket

(provide high-scores%)

(define high-scores%
  (class object%
    (init values)
    (define current-values values)
    (super-new)
    (define/public (scores) current-values)
    (define/public (latest) (car (reverse (scores))))
    (define/public (personal-best) (apply max (scores)))
    (define/public (personal-top-three)
      (define sorted (sort (scores) >))
      (if (< (length sorted) 3)
          sorted
          (take sorted 3)))))
