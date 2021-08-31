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
            [rst        (cdr vals)]
            [val        0]
            [result     '()])

    (let ([continue?  (< 0 (bitwise-and fst 128))])
      (cond
        ;;; error checking
        [(and continue? (null? rst))
          (error "incomplete sequence")]
        ;;; base case
        [(null? rst)
          (reverse (cons (do-bits fst val) result))]
        ;;; addition case
        [continue?
          (rec
            (car rst)
            (cdr rst)
            (do-bits fst val)
            result)]
        ;;; new number case
        [else
          (rec
            (car rst)
            (cdr rst)
            0
            (cons (do-bits fst val) result))]))))

(define (do-bits new-byte total)
  (bitwise-ior
    (bitwise-and new-byte 127)
    (arithmetic-shift total 7)))
