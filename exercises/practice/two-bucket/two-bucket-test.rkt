#lang racket/base

(require "two-bucket.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
      "two bucket tests"
      (test-equal? "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one"
		   (measure 3 5 1 'one)
		   '(4 one 5))

      (test-equal? "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two"
		   (measure 3 5 1 'two)
		   '(8 two 3))

      (test-equal? "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one"
		   (measure 7 11 2 'one)
		   '(14 one 11))

      (test-equal? "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two"
		   (measure 7 11 2 'two)
		   '(18 two 7))

      (test-equal? "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two"
		   (measure 1 3 3 'two)
		   '(1 two 0))

      (test-equal? "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two"
		   (measure 2 3 3 'one)
		   '(2 two 2))

      (test-exn "Not possible to reach the goal"
		exn:fail?
		(λ () (measure 6 15 5 'two)))

      (test-equal? "With the same buckets but a different goal, then it is possible"
		   (measure 6 15 9 'one)
		   '(10 two 0))

      (test-exn "Goal larger than both buckets is impossible"
		exn:fail?
		(λ () (measure 5 7 8 'one)))))

  (run-tests suite))
