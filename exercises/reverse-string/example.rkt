#lang racket

(provide (contract-out
          [my-reverse (string?  . -> . string?)]))

(define (my-reverse s)
  (let loop ([v (string->list s)]
             [answer '()])
    (if (empty? v)
      (list->string answer)
      (loop (cdr v) (cons (car v) answer)))))