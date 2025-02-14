#lang racket/base

(require "pythagorean-triplets.rkt")

(module+ test

  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
      "Return Pythagorean triplets with given perimeter"

      (test-equal? "triplets whose sum is 12"
        (triplets-with-sum 12) '((3 4 5)))

      (test-equal? "triplets whose sum is 108"
        (triplets-with-sum 108) '((27 36 45)))

      (test-equal? "triplets whose sum is 1000"
        (triplets-with-sum 1000) '((200 375 425)))

      (test-equal? "no matching triplets for 1001"
        (triplets-with-sum 1001) '())

      (test-equal? "returns all matching triplets"
        (triplets-with-sum 90) '((9 40 41) (15 36 39)))

      (test-equal? "several matching triplets"
        (triplets-with-sum 840)
        '((40 399 401) (56 390 394) (105 360 375) (120 350 370)
          (140 336 364) (168 315 357) (210 280 350) (240 252 348)))

      (test-equal? "triplets for large number"
        (triplets-with-sum 30000)
        '((1200 14375 14425) (1875 14000 14125) (5000 12000 13000)
          (6000 11250 12750) (7500 10000 12500)))))

  (run-tests suite))
