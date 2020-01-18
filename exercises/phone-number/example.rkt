#lang racket

(provide nanp-clean)

;; public
(define (nanp-clean s)
  (let* ([input-number (extract-numbers s)]
         [cleaned-number (trim-leading-one input-number)])
    (check-area-code-or-exchange (substring cleaned-number 0 3))
    (check-area-code-or-exchange (substring cleaned-number 3 6))
    cleaned-number))

;; private
(define (valid-character c)
  (or (char=? #\( c)
      (char=? #\) c)
      (char=? #\- c)
      (char=? #\. c)
      (char=? #\+ c)
      (char-numeric? c)
      (char-whitespace? c)))

(define (check-area-code-or-exchange s)
  (let ([first-char (string-ref s 0)])
    (when (or (char=? #\0 first-char)
              (char=? #\1 first-char))
      (error 'nanp-clean "invalid exchange or area code"))))

(define (extract-numbers s)
  (unless (andmap valid-character (string->list s))
    (error 'nanp-clean "invalid punctuation"))
  (list->string
   (filter (λ (c)
             (char-numeric? c)) (string->list s))))

(define (trim-leading-one s)
  (let ([s-length (string-length s)])
    (cond [(= 10 s-length) s]
          [(and (= 11 s-length)
                (char=? #\1 (string-ref s 0)))
           (substring s 1)]
          [else (error 'nanp-clean "bad number")])))
