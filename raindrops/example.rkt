#lang racket

(provide convert)

(define (convert n)
  (let ([drops ""]
        (factors (filter (lambda (v)
                           (and (>= v 3) (<= v 7)))
                         (prime-factors n))))
    (if (not (null? factors))
        (begin
          (when (member 3 factors)
            (set! drops (string-append drops "Pling")))
          (when (member 5 factors)
            (set! drops (string-append drops "Plang")))
          (when (member 7 factors)
            (set! drops (string-append drops "Plong"))))
        (set! drops (string-append drops (number->string n))))
    drops))

(define (prime-factors n)
  (let loop ([n n] [m 2] [factors '()])
    (cond [(= n 1) factors]
          [(= 0 (modulo n m)) (loop (/ n m) 2 (cons m factors))]
          [else (loop n (+ 1 m) factors)])))
