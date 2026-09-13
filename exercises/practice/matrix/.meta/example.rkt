#lang racket

(require racket/string)

(provide row column)

(define (parse matrix)
  (map (lambda (line)
         (map string->number (string-split line)))
       (string-split matrix "\n")))

(define (row matrix index)
  (list-ref (parse matrix) (sub1 index)))

(define (column matrix index)
  (map (lambda (current-row)
         (list-ref current-row (sub1 index)))
       (parse matrix)))
