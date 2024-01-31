#lang racket

(provide largest-product)

(define (validate digits span)
  (or (>= (string-length digits) span)
      (error "span must be smaller than string length")) ; XXX or equal to
  (or (not (negative? span)) (error "span must not be negative"))
  (or (regexp-match #px"^\\d*$" digits)
      (error "digits input must only contain digits")))

(define (value d)
  (- (char->integer d) (char->integer #\0)))

(define (largest-product digits span)
  (validate digits span)
  (if (zero? span)
    1
    (for/fold
      ([prod 1] [plen 0] [most 0]
       #:result most)
      ([i (in-range (string-length digits))]
       [c (in-string digits)])
      (let* ([trailing
               (if (= plen span)
                 (quotient prod (value (string-ref digits (- i span))))
                 prod)]
               [new-prod (* trailing (value c))]
               [new-plen (if (= plen span) plen (add1 plen))]
               [new-most (if (= new-plen span) (max new-prod most) most)])
         (if (char=? c #\0)
           (values 1 0 most)
             (values new-prod new-plen new-most))))))

