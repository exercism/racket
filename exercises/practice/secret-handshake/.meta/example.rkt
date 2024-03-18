#lang racket

(provide commands)

(define actions '((1 . "wink") (2 . "double blink")
                  (4 . "close your eyes") (8 . "jump")))

(define (bit-set? b n)
  (not (zero? (bitwise-and b n))))

(define (commands code)
  (let ([acts (filter-map
                (λ (a) (and (bit-set? (car a) code) (cdr a)))
                actions)])
    (if (bit-set? 16 code)
      (reverse acts)
      acts)))

