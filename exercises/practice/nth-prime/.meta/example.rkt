#lang racket

(provide nth-prime)

(define/contract (nth-prime number)
  (-> exact-positive-integer? exact-positive-integer?)
  (let loop ([candidate 2]
             [count 0])
    (cond
      [(prime? candidate)
       (cond
         [(= (add1 count) number) candidate]
         [else (loop (add1 candidate)
                     (add1 count))])]
      [else (loop (add1 candidate)
                  count)])))

(define (prime? number)
  (cond
    [(zero? number) #f]
    [(= number 1) #f]
    [(= number 2) #t]
    [(even? number) #f]
    [else
     (let loop ([factor 3])
       (cond
         [(> (expt factor 2) number) #t]
         [(zero? (remainder number factor)) #f]
         [else (loop (+ factor 2))]))]))