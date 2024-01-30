#lang racket

(provide translate)

(define (leading-vowel? word)
  (regexp-match #px"^[aeiou]|^[xy][^aeiou]" word))

(define (leading-consonants word)
  (let ([head (if (string-prefix? word "y")
		"y"
		(car (string-split word #px"[aeiouy]")))])
    (if (and (string-suffix? head "q")
	     (string-prefix? (substring word (string-length head)) "u"))
      (string-append head "u")
      head)))

(define (translate-word word)
  (let* ([head (if (leading-vowel? word) "" (leading-consonants word))]
	 [tail (substring word (string-length head))])
      (string-append tail head "ay")))

(define (translate text)
  (string-join (map translate-word (string-split text))))
