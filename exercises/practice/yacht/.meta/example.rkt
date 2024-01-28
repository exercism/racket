#lang racket

(provide yacht)

(define (sum-of-dice value dice)
  (* value (count (λ (d) (= d value)) dice)))

(define (sorted-groups dice)
  (sort (group-by identity dice)
	(λ (x y) (> (length x) (length y)))))

(define (full-house dice)
  (let ([groups (sorted-groups dice)])
    (if (and (= (length groups) 2)
	     (= (length (car groups)) 3))
      (apply + dice)
      0)))

(define (four-of-a-kind dice)
  (let ([groups (sorted-groups dice)])
    (if (or (and (= (length groups) 2)
	         (= (length (car groups)) 4))
	    (= (length groups) 1))
      (* 4 (caar groups))
      0)))

(define (straight start dice)
  (let ([groups (sorted-groups dice)])
    (if (and (= (length groups) 5)
	     (= (apply min dice) start)
	     (= (apply max dice) (+ start 4)))
      30
      0)))

(define (five-of-a-kind dice)
  (if (= (length (sorted-groups dice)) 1) 50 0))

(define (yacht dice category)
  (cond [(string=? category "ones") (sum-of-dice 1 dice)]
	[(string=? category "twos") (sum-of-dice 2 dice)]
	[(string=? category "threes") (sum-of-dice 3 dice)]
	[(string=? category "fours") (sum-of-dice 4 dice)]
	[(string=? category "fives") (sum-of-dice 5 dice)]
	[(string=? category "sixes") (sum-of-dice 6 dice)]
	[(string=? category "full house") (full-house dice)]
	[(string=? category "four of a kind") (four-of-a-kind dice)]
	[(string=? category "little straight") (straight 1 dice)]
	[(string=? category "big straight") (straight 2 dice)]
	[(string=? category "choice") (apply + dice)]
	[(string=? category "yacht") (five-of-a-kind dice)]
	[else (error "unknown category")]))

