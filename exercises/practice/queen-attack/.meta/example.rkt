#lang racket

(provide create-queen
         can-attack?)

(struct queen (row column))

(define (grid-position? n)
  (and (exact-nonnegative-integer? n)
       (> 8 n)))

(define/contract (create-queen row column)
  (-> grid-position? grid-position? queen?)
  (queen row column))

(define/contract (can-attack? white-queen black-queen)
  (-> queen? queen? boolean?)
  (match (list white-queen black-queen)
    [(list (queen r _) (queen r _))
     #t]
    [(list (queen _ c) (queen _ c))
     #t]
    [(list (queen wr wc) (queen br bc))
     #:when (= (abs (- wr br))
               (abs (- wc bc)))
     #t]
    [_ #f]))
