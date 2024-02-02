#lang racket

(provide valid?)

(define (value d)
  (- (char->integer d) (char->integer #\0)))

(define (valid? digits)
  (let ([xs (string-replace digits " " "")])
    (if (or (regexp-match #px"[^0-9]" xs)
            (< (string-length xs) 2))
      #f
      (let* ([ds (map value (string->list xs))]
             [total
               (for/sum ([d ds]
                         [i (in-range (length ds))])
                 (if (zero? (modulo (- (length ds) i) 2))
                   (- (* 2 d) (if (> d 4) 9 0))
                   d))])
        (zero? (modulo total 10))))))
