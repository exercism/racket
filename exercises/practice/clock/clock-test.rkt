#lang racket/base

(require "clock.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "clock tests"

     (test-equal? "Create a new clock with an initial time - on the hour"
                  (clock->string (clock 8 0))
                  "08:00")

     (test-equal? "Create a new clock with an initial time - past the hour"
                  (clock->string (clock 11 9))
                  "11:09")

     (test-equal? "Create a new clock with an initial time - midnight is zero hours"
                  (clock->string (clock 24 0))
                  "00:00")

     (test-equal? "Create a new clock with an initial time - hour rolls over"
                  (clock->string (clock 25 0))
                  "01:00")

     (test-equal? "Create a new clock with an initial time - hour rolls over continuously"
                  (clock->string (clock 100 0))
                  "04:00")

     (test-equal? "Create a new clock with an initial time - sixty minutes is next hour"
                  (clock->string (clock 1 60))
                  "02:00")

     (test-equal? "Create a new clock with an initial time - minutes roll over"
                  (clock->string (clock 0 160))
                  "02:40")

     (test-equal? "Create a new clock with an initial time - minutes roll over continuously"
                  (clock->string (clock 0 1723))
                  "04:43")

     (test-equal? "Create a new clock with an initial time - hour and minutes roll over"
                  (clock->string (clock 25 160))
                  "03:40")

     (test-equal? "Create a new clock with an initial time - hour and minutes roll over continuously"
                  (clock->string (clock 201 3001))
                  "11:01")

     (test-equal? "Create a new clock with an initial time - hour and minutes roll over to exactly midnight"
                  (clock->string (clock 72 8640))
                  "00:00")

     (test-equal? "Create a new clock with an initial time - negative hour"
                  (clock->string (clock -1 15))
                  "23:15")

     (test-equal? "Create a new clock with an initial time - negative hour rolls over"
                  (clock->string (clock -25 0))
                  "23:00")

     (test-equal? "Create a new clock with an initial time - negative hour rolls over continuously"
                  (clock->string (clock -91 0))
                  "05:00")

     (test-equal? "Create a new clock with an initial time - negative minutes"
                  (clock->string (clock 1 -40))
                  "00:20")

     (test-equal? "Create a new clock with an initial time - negative minutes roll over"
                  (clock->string (clock 1 -160))
                  "22:20")

     (test-equal? "Create a new clock with an initial time - negative minutes roll over continuously"
                  (clock->string (clock 1 -4820))
                  "16:40")

     (test-equal? "Create a new clock with an initial time - negative sixty minutes is previous hour"
                  (clock->string (clock 2 -60))
                  "01:00")

     (test-equal? "Create a new clock with an initial time - negative hour and minutes both roll over"
                  (clock->string (clock -25 -160))
                  "20:20")

     (test-equal? "Create a new clock with an initial time - negative hour and minutes both roll over continuously"
                  (clock->string (clock -121 -5810))
                  "22:10")

     (test-equal? "Add minutes - add minutes"
                  (clock->string (add (clock 10 0)
                                      3))
                  "10:03")

     (test-equal? "Add minutes - add no minutes"
                  (clock->string (add (clock 6 41)
                                      0))
                  "06:41")

     (test-equal? "Add minutes - add to next hour"
                  (clock->string (add (clock 0 45)
                                      40))
                  "01:25")

     (test-equal? "Add minutes - add more than one hour"
                  (clock->string (add (clock 10 0)
                                      61))
                  "11:01")

     (test-equal? "Add minutes - add more than two hours with carry"
                  (clock->string (add (clock 0 45)
                                      160))
                  "03:25")

     (test-equal? "Add minutes - add across midnight"
                  (clock->string (add (clock 23 59)
                                      2))
                  "00:01")

     (test-equal? "Add minutes - add more than one day (1500 min = 25 hrs)"
                  (clock->string (add (clock 5 32)
                                      1500))
                  "06:32")

     (test-equal? "Add minutes - add more than two days"
                  (clock->string (add (clock 1 1)
                                      3500))
                  "11:21")

     (test-equal? "Subtract minutes - subtract minutes"
                  (clock->string (subtract (clock 10 3)
                                           3))
                  "10:00")

     (test-equal? "Subtract minutes - subtract to previous hour"
                  (clock->string (subtract (clock 10 3)
                                           30))
                  "09:33")

     (test-equal? "Subtract minutes - subtract more than an hour"
                  (clock->string (subtract (clock 10 3)
                                           70))
                  "08:53")

     (test-equal? "Subtract minutes - subtract across midnight"
                  (clock->string (subtract (clock 0 3)
                                           4))
                  "23:59")

     (test-equal? "Subtract minutes - subtract more than two hours"
                  (clock->string (subtract (clock 0 0)
                                           160))
                  "21:20")

     (test-equal? "Subtract minutes - subtract more than two hours with borrow"
                  (clock->string (subtract (clock 6 15)
                                           160))
                  "03:35")

     (test-equal? "Subtract minutes - subtract more than one day (1500 min = 25 hrs)"
                  (clock->string (subtract (clock 5 32)
                                           1500))
                  "04:32")

     (test-equal? "Subtract minutes - subtract more than two days"
                  (clock->string (subtract (clock 2 20)
                                           3000))
                  "00:20")

     (test-equal? "Compare two clocks for equality - clocks with same time"
                  (clock 15 37)
                  (clock 15 37))

     (test-case "Compare two clocks for equality - clocks a minute apart"
                (check-not-equal? (clock 15 36)
                                  (clock 15 37)))

     (test-case "Compare two clocks for equality - clocks an hour apart"
                (check-not-equal? (clock 14 37)
                                  (clock 15 37)))

     (test-equal? "Compare two clocks for equality - clocks with hour overflow"
                  (clock 10 37)
                  (clock 34 37))

     (test-equal? "Compare two clocks for equality - clocks with hour overflow by several days"
                  (clock 3 11)
                  (clock 99 11))

     (test-equal? "Compare two clocks for equality - clocks with negative hour"
                  (clock 22 40)
                  (clock -2 40))

     (test-equal? "Compare two clocks for equality - clocks with negative hour that wraps"
                  (clock 17 3)
                  (clock -31 3))

     (test-equal? "Compare two clocks for equality - clocks with negative hour that wraps multiple times"
                  (clock 13 49)
                  (clock -83 49))

     (test-equal? "Compare two clocks for equality - clocks with minute overflow"
                  (clock 0 1)
                  (clock 0 1441))

     (test-equal? "Compare two clocks for equality - clocks with minute overflow by several days"
                  (clock 2 2)
                  (clock 2 4322))

     (test-equal? "Compare two clocks for equality - clocks with negative minute"
                  (clock 2 40)
                  (clock 3 -20))

     (test-equal? "Compare two clocks for equality - clocks with negative minute that wraps"
                  (clock 4 10)
                  (clock 5 -1490))

     (test-equal? "Compare two clocks for equality - clocks with negative minute that wraps multiple times"
                  (clock 6 15)
                  (clock 6 -4305))

     (test-equal? "Compare two clocks for equality - clocks with negative hours and minutes"
                  (clock 7 32)
                  (clock -12 -268))

     (test-equal? "Compare two clocks for equality - clocks with negative hours and minutes that wrap"
                  (clock 18 7)
                  (clock -54 -11513))

     (test-equal? "Compare two clocks for equality - full clock and zeroed clock"
                  (clock 24 0)
                  (clock 0 0))))

  (run-tests suite))
