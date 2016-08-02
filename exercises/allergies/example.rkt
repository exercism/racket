#lang racket

(provide allergic-to? list-allergies)

(define allergies
  #hash(("eggs"         . 1)
        ("peanuts"      . 2)
        ("shellfish"    . 4)
        ("strawberries" . 8)
        ("tomatoes"     . 16)
        ("chocolate"    . 32)
        ("pollen"       . 64)
        ("cats"         . 128)))

(define codes
  (for/hash ([(k v) (in-hash allergies)])
    (values v k)))

(define (has-bit? n m)
  (> (bitwise-and n m) 0))

(define (allergic-to? name code)
  (has-bit? (hash-ref allergies name 0) code))

(define (list-allergies n)
  (for/list ([(code name) (in-hash codes)]
             #:when (has-bit? code n))
    name))
