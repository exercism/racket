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
        (go (cdr l) (+ 1 acc))))
  (go l 0))

(define (my-reverse l)
  (define (go l acc)
    (if (null? l)
        acc
        (go (cdr l) (cons (car l) acc))))
  (go l '()))

(define (my-map f l)
  (define (go l acc)
    (if (null? l)
        (my-reverse acc)
        (go (cdr l) (cons (f (car l)) acc))))
  (go l '()))

(define (my-filter f l)
  (define (go l acc)
    (if (null? l)
        (my-reverse acc)
        (if (f (car l))
            (go (cdr l) (cons (car l) acc))
            (go (cdr l) acc))))
  (go l '()))

(define (my-fold f acc l)
  (if (null? l)
      acc
      (my-fold f (f (car l) acc) (cdr l))))

(define (my-append a b)
  (define (go l acc)
    (if (null? l)
        acc
        (go (cdr l) (cons (car l) acc))))
  (go (my-reverse a) b))

(define (my-concatenate ll)
  (my-fold my-append '() (my-reverse ll)))
