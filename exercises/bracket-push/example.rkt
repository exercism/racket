#lang racket

(provide is-paired?)

(define (match a b)
  (ormap (curry equal? (list a b))
         (list '(#\( #\)) '(#\[ #\]) '(#\{ #\}))))

(define (one-step xs)
  (cond [(> 2 (length xs)) xs]
        [(match (car xs) (cadr xs)) (one-step (cddr xs))]
        [else (cons (car xs) (one-step (cdr xs)))]))

(define (is-paired-helper xs)
  (let ([new (one-step xs)])
    (cond [(empty? new) #t]
          [(= (length xs) (length new)) #f]
          [else (is-paired-helper new)])))

(define (is-paired? xs)
  (is-paired-helper
     (filter (lambda (x) (member x (string->list "{}[]()")))
             (string->list xs))))
