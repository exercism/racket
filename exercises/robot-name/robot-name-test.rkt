#lang racket

(define (check-robot-name n)
  (regexp-match #px"\\p{Lu}{2}\\p{Nd}{4}" n))