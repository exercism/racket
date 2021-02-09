#lang racket

(provide rebase)


(define (rebase list-digits in-base out-base)
  (and (< 1 in-base)
       (< 1 out-base)
       (andmap (λ (x)
                 (< -1 x in-base))
               list-digits)
       (if (null? list-digits)
           '( 0 )
           (num->list (list->num list-digits in-base)
                      out-base))))

(define (list->num lst base)
  (reduce
    (λ (c sum)
      (+ (* sum base) c))
    lst))

(define (num->list num base)
  (define (listerator lst rem mult)
            (if (> rem 0)
                (letrec ([m (* mult base)]
                         [v (remainder rem m)]
                         [d (/ v mult)])
                  (listerator
                    (cons d lst)
                    (- rem v)
                    m))
                lst))
    (let ([res (listerator '() num 1)])
      (if (null? res)
          '(0)
          res)))

(define (reduce fn lst)
  (if (null? (cdr lst))
      (car lst)
      (foldl fn (car lst) (cdr lst))))
