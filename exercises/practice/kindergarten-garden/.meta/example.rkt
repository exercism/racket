#lang racket

(provide plants)

(define plant-abbrev
  (hash #\C "clover" #\G "grass" #\R "radishes" #\V "violets"))

(define (plant-name row ix)
  (hash-ref plant-abbrev (string-ref row ix)))

(define (name->index name)
  (- (char->integer (string-ref name 0)) (char->integer #\A)))

(define (plants diagram student)
  (let* ([rows (string-split diagram "\n")]
         [s (name->index student)]
         [i1 (* 2 s)]
         [i2 (add1 i1)]
         [p1 (plant-name (car rows) i1)]
         [p2 (plant-name (car rows) i2)]
         [p3 (plant-name (cadr rows) i1)]
         [p4 (plant-name (cadr rows) i2)])
    (list p1 p2 p3 p4)))
