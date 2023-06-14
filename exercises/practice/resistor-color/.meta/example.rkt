#lang racket

(provide color-code colors)

(define resistor-colors
  (vector 'black 'brown 'red 'orange 'yellow 'green 'blue 'violet 'grey 'white))

(define (color-code color)
  (vector-member color resistor-colors))

(define (colors)
  (vector->list resistor-colors))
