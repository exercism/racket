#lang racket

(provide rotate)

(define (rotate text key)
  (list->string
    (map (lambda (char) (rotate-char char key))
     (string->list text))))

(define (rotate-char char key)
  (cond
    [(char-alphabetic? char)
     (let* ([alphabet-length 26]
            [offset (if (char-upper-case? char) (char->integer #\A) (char->integer #\a))]
            [calc-rel-position (lambda () (modulo (+ (- (char->integer char) offset) key) alphabet-length))]
            [calc-new-position (lambda () (+ offset (calc-rel-position)))])
           (integer->char (calc-new-position)))]
    [else char]))
