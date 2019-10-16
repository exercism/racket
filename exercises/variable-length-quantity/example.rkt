#lang racket

(provide encode decode)

(define (encode . nums)
  (append-map encode+ nums))

(define (encode+ val)
  (let rec ([bytes '()]
            [value (bitwise-and val 127)]
            [rem   (arithmetic-shift val -7)]
            [msb   0])
    (if (= 0 rem)
        (cons (bitwise-ior msb value) bytes)
        (rec (cons (bitwise-ior msb value) bytes)
             (bitwise-and rem 127)
             (arithmetic-shift rem -7)
             128))))

(define (decode . vals)
  (let rec ([fst        (car vals)]
            [val        0]
            [rst        (cdr vals)]
            [continue?  (< 0 (bitwise-and (car vals) 128))]
            [result     '()])

    ;;; some error checking...
    (when (and continue? (null? rst))
      (error "incomplete sequence"))

    )))


;;; (if (< 0 (bitwise-and val 128))
;;;           (cons
;;;             (bitwise-ior
;;;               (bitwise-and val 127)
;;;               (if (pair? lst)
;;;                   (arithmetic-shift (car lst) 7)
;;;                   0))
;;;             (if (null? lst)
;;;                 lst
;;;                 (cdr lst)))
;;;           (cons val lst))
