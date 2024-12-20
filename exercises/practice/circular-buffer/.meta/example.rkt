#lang racket

(provide circular-buffer%)

(define circular-buffer%
  (class object%
    (super-new)
    (init capacity)
    (define buf-size capacity)
    (define buf-modulus (* 2 capacity))
    (define data (make-vector capacity))
    (define front 0)
    (define back 0)
    (define (buf-empty?) (= front back))
    (define (buf-full?) (= (modulo (- back front) buf-modulus) buf-size))
    (define (next-spot s) (modulo (add1 s) buf-modulus))
    (define (advance-front) (set! front (next-spot front)))
    (define (advance-back) (set! back (next-spot back)))
    (define/public (clear) (set! front back))
    (define/public (read)
      (if (buf-empty?)
        (error "buffer is empty")
        (let ([v (vector-ref data (modulo front buf-size))])
          (begin (advance-front) v))))
    (define/public (write v)
      (if (buf-full?)
        (error "buffer is full")
        (begin (vector-set! data (modulo back buf-size) v)
               (advance-back))))
    (define/public (overwrite v)
      (if (buf-full?) (advance-front) null)
      (write v))))
