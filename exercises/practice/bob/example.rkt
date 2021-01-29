#lang racket

(provide response-for)

(define (response-for phrase)
  (cond
    [(silent? phrase) "Fine. Be that way!"]
    [(and (shouting? phrase)
          (question? phrase)) "Calm down, I know what I'm doing!"]
    [(shouting? phrase) "Whoa, chill out!"]
    [(question? phrase) "Sure."]
    [else "Whatever."]))

(define (silent? phrase)
  (or (null? phrase)
      (equal? (string-normalize-spaces phrase) "")))

(define (shouting? phrase)
  (and (equal? (string-upcase phrase) phrase)
       (ormap (lambda (x) (char-alphabetic? x)) (string->list phrase))))

(define (question? phrase)
  (char=? #\?
          (string-ref phrase
                      (- (string-length phrase) 1))))
