#lang racket

(provide encode decode)

(define (encode val)
  (let rec ([bytes '()]
            [quot  (quotient val 128)]
            [rem   (remainder val 128)])
    (if (= 0 quot)
        (cons rem bytes)
        (rec (cons val bytes)
             (quotient (- val 127) 128)
             (remainder (- val 127) 128)))))

(define (decode val))
