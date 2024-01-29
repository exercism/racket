#lang racket/base

(require "yacht.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
      "yacht tests"

      (test-equal? "Yacht"
		   (yacht '(5 5 5 5 5) "yacht") 50)

      (test-equal? "Not Yacht"
		   (yacht '(1 3 3 2 5) "yacht") 0)

      (test-equal? "Ones"
		   (yacht '(1 1 1 3 5) "ones") 3)

      (test-equal? "Ones, out of order"
		   (yacht '(3 1 1 5 1) "ones") 3)

      (test-equal? "No Ones"
		   (yacht '(4 3 6 5 5) "ones") 0)

      (test-equal? "Twos"
		   (yacht '(2 3 4 5 6) "twos") 2)

      (test-equal? "Fours"
		   (yacht '(1 4 1 4 1) "fours") 8)

      (test-equal? "Yacht counted as Threes"
		   (yacht '(3 3 3 3 3) "threes") 15)

      (test-equal? "Yacht of 3s counted as Fives"
		   (yacht '(3 3 3 3 3) "fives") 0)

      (test-equal? "Fives"
		   (yacht '(1 5 3 5 3) "fives") 10)

      (test-equal? "Sixes"
		   (yacht '(2 3 4 5 6) "sixes") 6)

      (test-equal? "Full House two small, three big"
		   (yacht '(2 2 4 4 4) "full house") 16)

      (test-equal? "Full House three small, two big"
		   (yacht '(5 3 3 5 3) "full house") 19)

      (test-equal? "Two pair is not a Full House"
		   (yacht '(2 2 4 4 5) "full house") 0)

      (test-equal? "Four of a kind is not a Full House"
		   (yacht '(1 4 4 4 4) "full house") 0)

      (test-equal? "Yacht is not a Full House"
		   (yacht '(2 2 2 2 2) "full house") 0)

      (test-equal? "Four of a Kind"
		   (yacht '(6 6 4 6 6) "four of a kind") 24)

      (test-equal? "Yacht can be scored as Four of a Kind"
		   (yacht '(3 3 3 3 3) "four of a kind") 12)

      (test-equal? "Full House is not Four of a Kind"
		   (yacht '(3 3 3 5 5) "four of a kind") 0)

      (test-equal? "Little Straight"
		   (yacht '(3 5 4 1 2) "little straight") 30)

      (test-equal? "Little Straight as Big Straight"
		   (yacht '(1 2 3 4 5) "big straight") 0)

      (test-equal? "Four in order but not a Little Straight"
		   (yacht '(1 1 2 3 4) "little straight") 0)

      (test-equal? "No pairs but not a Little Straight"
		   (yacht '(1 2 3 4 6) "little straight") 0)

      (test-equal? "Minimum is 1, maximum is 5, but not a Little Straight"
		   (yacht '(1 1 3 4 5) "little straight") 0)

      (test-equal? "Big Straight"
		   (yacht '(4 6 2 5 3) "big straight") 30)

      (test-equal? "Big Straight as Little Straight"
		   (yacht '(6 5 4 3 2) "little straight") 0)

      (test-equal? "No pairs but not a Big Straight"
		   (yacht '(6 5 4 3 1) "big straight") 0)

      (test-equal? "Choice"
		   (yacht '(3 3 5 6 6) "choice") 23)

      (test-equal? "Yacht as Choice"
		   (yacht '(2 2 2 2 2) "choice") 10)))

  (run-tests suite))
