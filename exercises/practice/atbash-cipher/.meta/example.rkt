#lang racket

(provide (contract-out
          [encode (string? . -> . string?)]
          [decode (string? . -> . string?)]))

(define (prepare-string m)
  (filter (λ(s)
            (or (char-numeric? s)
                (char-alphabetic? s)))
          (string->list
           (string-downcase m))))

(define (atbash-char c)
  (if (char-numeric? c)
      c
      (integer->char
       (+ (char->integer #\a)
          (- (char->integer #\z) (char->integer c))))))

(define (group v chunk-size)
  (let loop ([v v]
             [N (length v)]
             [answer '()])
    (if (<= N chunk-size)
        (string-join (reverse (cons (list->string v) answer)))
        (let-values ([(h t) (split-at v chunk-size)])
          (loop t (- N chunk-size) (cons (list->string h) answer))))))

(define (encode m)
  (group (map atbash-char (prepare-string m)) 5))

(define (decode m)
  (list->string (map atbash-char (prepare-string m))))
