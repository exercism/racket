#lang racket

(provide my-length
         my-reverse
         my-map
         my-filter
         my-fold
         my-append
         my-concatenate)

(define (my-length l)
  (define (go l acc)
    (if (null? l)
        acc
        (go (rest l) (+ 1 acc))))
  (go l 0))

(define (my-reverse l)
  (define (go l acc)
    (if (null? l)
        acc
        (go (rest l) (cons (first l) acc))))
  (go l '()))

(define (my-map f l)
  (define (go l acc)
    (if (null? l)
        (my-reverse acc)
        (go (rest l) (cons (f (first l)) acc))))
  (go l '()))

(define (my-filter f l)
  (define (go l acc)
    (if (null? l)
        (my-reverse acc)
        (if (f (first l))
            (go (rest l) (cons (first l) acc))
            (go (rest l) acc))))
  (go l '()))

(define (my-fold f acc l)
  (if (null? l)
      acc
      (my-fold f (f (first l) acc) (rest l))))

(define (my-append a b)
  (define (go l acc)
    (if (null? l)
        acc
        (go (rest l) (cons (first l) acc))))
  (go (my-reverse a) b))

(define (my-concatenate ll)
  (my-fold my-append '() (my-reverse ll)))
