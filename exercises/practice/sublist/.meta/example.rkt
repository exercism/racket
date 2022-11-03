#lang racket

(provide sublist?)

(define (sublist? s l)
  (match (list s l)
    [(list '() '()) 'equal]
    [(list '() _) 'sublist]
    [(list _ '()) 'superlist]
    [(list s l) #:when (= (length s) (length l))
                (if (equal? s l) 'equal 'unequal)]
    [(list _ _2) (let*-values
                     [((s-len) (length s))
                      ((l-len) (length l))
                      ((which len a b)
                       (if (< s-len l-len)
                           (values 'sublist s-len s l)
                           (values 'superlist l-len l s)))
                      ((starts-with?)
                       (lambda (b) (and
                                    (equal? (car a) (car b)) ; should we even check further?
                                    (equal? a (take b len)))))
                      ]
                   (let find [(b-len (length b)) (b b)]
                     (cond
                       [(< b-len len) 'unequal]
                       [(starts-with? b) which]
                       [#t (find (sub1 b-len) (cdr b))]
                       ))
                   )]
    )
  )
