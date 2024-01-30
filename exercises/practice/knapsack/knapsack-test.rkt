#lang racket/base

(require "knapsack.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
     "knapsack tests"

     (test-equal? "no items"
                  (maximum-value 100 '())
                  0)

     (test-equal? "one item, too heavy"
                  (maximum-value 10 (list (item 100 1)))
                  0)

     (test-equal? "five items (cannot be greedy by weight)"
                  (maximum-value 10
                                 (list (item 2 5)
                                       (item 2 5)
                                       (item 2 5)
                                       (item 2 5)
                                       (item 10 21)))
                  21)

     (test-equal? "five items (cannot be greedy by value)"
                  (maximum-value 10
                                 (list (item 2 20)
                                       (item 2 20)
                                       (item 2 20)
                                       (item 2 20)
                                       (item 10 50)))
                  80)

     (test-equal? "example knapsack"
                  (maximum-value 10
                                 (list (item 5 10)
                                       (item 4 40)
                                       (item 6 30)
                                       (item 4 50)))
                  90)

     (test-equal? "8 items"
                  (maximum-value 104
                                 (list (item 25 350)
                                       (item 35 400)
                                       (item 45 450)
                                       (item 5 20)
                                       (item 25 70)
                                       (item 3 8)
                                       (item 2 5)
                                       (item 2 5)))
                  900)

     (test-equal? "15 items"
                  (maximum-value 750
                                 (list (item 70 135)
                                       (item 73 139)
                                       (item 77 149)
                                       (item 80 150)
                                       (item 82 156)
                                       (item 87 163)
                                       (item 90 173)
                                       (item 94 184)
                                       (item 98 192)
                                       (item 106 201)
                                       (item 110 210)
                                       (item 113 214)
                                       (item 115 221)
                                       (item 118 229)
                                       (item 120 240)))
                  1458)))

  (run-tests suite))
