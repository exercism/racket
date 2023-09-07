#lang racket

(provide color-code)

(define resistor-colors
  '#("black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"))

(define (color-code colors)
  (match colors
    [(list first second _ ...)
     (let* ([tens (vector-member first resistor-colors)]
            [ones (vector-member second resistor-colors)]
            [value (+ (* tens 10) ones)])
       value)]
    [ _ (error "Invalid colors argument")]))
