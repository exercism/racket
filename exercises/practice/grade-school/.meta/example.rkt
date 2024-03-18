#lang racket

(provide school%)

(define school%
  (class object%
    (super-new)
    (define students (mutable-set))
    (define grade-list (make-hash))

    (define/public (add name grade)
      (and
        (not (set-member? students name))
        (begin
          (set-add! students name)
          (let* ([current (hash-ref grade-list grade '())]
                 [updated (sort (cons name current) string<?)])
             (hash-set! grade-list grade updated))
          #t)))

     (define/public (grade g)
       (hash-ref grade-list g '()))

     (define/public (roster)
       (sort (hash->list grade-list) < #:key car))))
