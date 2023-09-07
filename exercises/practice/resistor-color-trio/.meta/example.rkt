#lang racket

(provide color-code)

(define resistor-colors
  '#("black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"))

(define (color-code colors)
  (match colors
    [(list first second third rest ...)
     (let* ([index-of (lambda (elem) (vector-member elem resistor-colors))]
            [tens (index-of first)]
            [ones (index-of second)]
            [pow  (index-of third)]
            [initial (+ (* tens 10) ones)]
            [value (* initial (expt 10 pow))]
            [magnitude (cond [(< value 1000)        0]
                             [(< value 1000000)     1]
                             [(< value 1000000000)  2]
                             [else                  3])]
            [prefix (vector-ref '#("" "kilo" "mega" "giga") magnitude)]
            [scaled-value (/ value (expt 10 (* magnitude 3)))])
       (format "~a ~aohms" scaled-value prefix))]
    [_ (error "Invalid colors argument")]))
