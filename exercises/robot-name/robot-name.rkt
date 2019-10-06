#lang racket
(require racket/class)

(define (random-digit-char)
  (integer->char
   (random (char->integer #\0)
           (add1 (char->integer #\9)))))

(define (random-letter-char)
  (integer->char
   (random (char->integer #\A)
           (add1 (char->integer #\Z)))))

(define (generate-valid-name)
  (let ([all-robot-names (set)])
    (list->string
     (let loop ([index 0])
       (cond [(< index 2) (cons (random-letter-char) (loop (add1 index)))]
             [(< index 6) (cons (random-digit-char) (loop (add1 index)))]
             [else empty])))))

(define generate-unique-name
  (let ([all-robot-names (mutable-set)])
    (lambda ()
      (let ([name (generate-valid-name)])
        (cond [(set-member? all-robot-names name)
               (generate-unique-name)]
              [else
               (set-add! all-robot-names name)
               name])))))

; https://docs.racket-lang.org/guide/classes.html
(define robot%
  (class object%
    (super-new)
    (define name (generate-unique-name))
    (define/public (get-name)
      name)
    (define/public (reset)
      (set! name (generate-unique-name)))))