#lang racket

(define (random-digit-char)
  (integer->char
   (random (char->integer #\0)
           (add1 (char->integer #\9)))))

(define (random-letter-char)
  (integer->char
   (random (char->integer #\A)
           (add1 (char->integer #\Z)))))

(define (generate-robot-name)
  (list->string
   (let loop ([index 0])
     (cond [(< index 2) (cons (random-letter-char) (loop (add1 index)))]
           [(< index 6) (cons (random-digit-char) (loop (add1 index)))]
           [else empty]))))