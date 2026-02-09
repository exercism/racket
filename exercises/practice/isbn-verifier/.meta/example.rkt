#lang racket

(provide isbn?)

(define (isbn? isbn)
  (define (valid-format?)
    (regexp-match-exact? #px"(\\d-?){9}[\\dX]" isbn))
  (define (valid-checksum? number)
    (define (char->digit c)
      (if (char=? c #\X) 10
          (string->number (string c))))
    (define (checksum)
      (for/sum ([c number]
                [i (in-range (string-length number) 0 -1)])
        (* (char->digit c) i)))
    (zero? (modulo (checksum) 11)))
  (define (cleaned)
    (string-replace isbn "-" ""))

  (and (valid-format?)
       (valid-checksum? (cleaned))))
