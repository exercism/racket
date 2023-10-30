#lang racket/base

(require "strain.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "strain tests"

     (test-equal? "keep on empty list returns empty list"
                  (keep '() (lambda (x) #t))
                  '())

     (test-equal? "keeps everything"
                  (keep '(1 3 5) (lambda (x) #t))
                  '(1 3 5))

     (test-equal? "keeps nothing"
                  (keep '(1 3 5) (lambda (x) #f))
                  '())

     (test-equal? "keeps first and last"
                  (keep '(1 2 3) odd?)
                  '(1 3))

     (test-equal? "keeps neither first nor last"
                  (keep '(1 2 3) even?)
                  '(2))

     (test-equal? "keeps strings"
                  (keep '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot")
                        (lambda (x) (equal? (string-ref x 0) #\z)))
                  '("zebra" "zombies" "zealot"))

     (test-equal? "keeps lists"
                  (keep (list '(1 2 3) '(5 5 5) '(5 1 2) '(2 1 2) '(1 5 2) '(2 2 1) '(1 2 5))
                        (lambda (x) (if (member 5 x) #t #f)))
                  (list '(5 5 5) '(5 1 2) '(1 5 2) '(1 2 5)))

     (test-equal? "discard on empty list returns empty list"
                  (discard '() (lambda (x) #t))
                  '())

     (test-equal? "discards everything"
                  (discard '(1 3 5) (lambda (x) #t))
                  '())

     (test-equal? "discards nothing"
                  (discard '(1 3 5) (lambda (x) #f))
                  '(1 3 5))

     (test-equal? "discards first and last"
                  (discard '(1 2 3) odd?)
                  '(2))

     (test-equal? "discards neither first nor last"
                  (discard '(1 2 3) even?)
                  '(1 3))

     (test-equal? "discards strings"
                  (discard '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot")
                           (lambda (x) (equal? (string-ref x 0) #\z)))
                  '("apple" "banana" "cherimoya"))

     (test-equal? "discards lists"
                  (discard (list '(1 2 3) '(5 5 5) '(5 1 2) '(2 1 2) '(1 5 2) '(2 2 1) '(1 2 5))
                           (lambda (x) (if (member 5 x) #t #f)))
                  (list '(1 2 3) '(2 1 2) '(2 2 1)))))

  (run-tests suite))
