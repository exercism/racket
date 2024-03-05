#lang racket

(provide recite)

(define spider-action
  " wriggled and jiggled and tickled inside her")

(define verdict
  "I don't know why she swallowed the fly. Perhaps she'll die.")

(struct critter (name reaction extra))

(define critters
  (list
    (critter "horse" "She's dead, of course!" "")
    (critter "cow" "I don't know how she swallowed a cow!" "")
    (critter "goat" "Just opened her throat and swallowed a goat!" "")
    (critter "dog" "What a hog, to swallow a dog!" "")
    (critter "cat" "Imagine that, to swallow a cat!" "")
    (critter "bird" "How absurd to swallow a bird!" "")
    (critter "spider" (string-append "It" spider-action ".")
             (string-append " that" spider-action))
    (critter "fly" verdict "")))

(define (intro c)
  (list
    (string-append "I know an old lady who swallowed a "
                   (critter-name c) ".")
    (critter-reaction c)))

(define (reason previous c)
  (string-append "She swallowed the " previous " to catch the "
		 (critter-name c) (critter-extra c) "."))

(define (verse n)
  (let* ([cs (drop critters (- (length critters) n))]
         [start (intro (car cs))])
    (if (or (eq? cs critters) (null? (cdr cs)))
      start
      (for/fold
        ([v (reverse start)]
         [previous (critter-name (car cs))]
         #:result (reverse (cons verdict v)))
        ([c (cdr cs)])
        (values (cons (reason previous c) v) (critter-name c))))))

(define (recite start-verse end-verse)
  (for/fold
    ([song '()])
    ([i (in-inclusive-range start-verse end-verse)])
    (let ([v (if (= i start-verse) (verse i) (cons "" (verse i)))])
      (append song v))))
