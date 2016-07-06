#lang racket

(provide to-roman)

(define (to-roman num)
    (cond ((>= num 1000) (string-append "M" (to-roman (- num 1000))))
        ((>= num 900) (string-append "CM" (to-roman (- num 900))))
        ((>= num 500) (string-append "D" (to-roman (- num 500))))
        ((>= num 400) (string-append "CD" (to-roman (- num 400))))
        ((>= num 100) (string-append "C" (to-roman (- num 100))))
        ((>= num 90) (string-append "XC" (to-roman (- num 90))))
        ((>= num 50) (string-append "L" (to-roman (- num 50))))
        ((>= num 40) (string-append "XL" (to-roman (- num 40))))
        ((>= num 10) (string-append "X" (to-roman (- num 10))))
        ((>= num 9) (string-append "IX" (to-roman (- num 9))))
        ((>= num 5) (string-append "V" (to-roman (- num 5))))
        ((>= num 4) (string-append "IV" (to-roman (- num 4))))
        ((>= num 1) (string-append "I" (to-roman (- num 1))))
        (else ""))) 