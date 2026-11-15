#lang racket/base

(require "meetup.rkt")

(module+ test
  (require rackunit
           rackunit/text-ui
           racket/date)

  (define (make-date year month day)
    (seconds->date (find-seconds 0 0 0 day month year #f) #f))

  (define suite
    (test-suite "meetup tests"
      (test-equal? "when teenth Monday is the 13th, the first day of the teenth week"
                   (meetup-day 2013 5 'Monday 'teenth)
                   (make-date 2013 5 13))

      (test-equal? "when teenth Monday is the 19th, the last day of the teenth week"
                   (meetup-day 2013 8 'Monday 'teenth)
                   (make-date 2013 8 19))

      (test-equal? "when teenth Monday is some day in the middle of the teenth week"
                   (meetup-day 2013 9 'Monday 'teenth)
                   (make-date 2013 9 16))

      (test-equal? "when teenth Tuesday is the 19th, the last day of the teenth week"
                   (meetup-day 2013 3 'Tuesday 'teenth)
                   (make-date 2013 3 19))

      (test-equal? "when teenth Tuesday is some day in the middle of the teenth week"
                   (meetup-day 2013 4 'Tuesday 'teenth)
                   (make-date 2013 4 16))

      (test-equal? "when teenth Tuesday is the 13th, the first day of the teenth week"
                   (meetup-day 2013 8 'Tuesday 'teenth)
                   (make-date 2013 8 13))

      (test-equal? "when teenth Wednesday is some day in the middle of the teenth week"
                   (meetup-day 2013 1 'Wednesday 'teenth)
                   (make-date 2013 1 16))

      (test-equal? "when teenth Wednesday is the 13th, the first day of the teenth week"
                   (meetup-day 2013 2 'Wednesday 'teenth)
                   (make-date 2013 2 13))

      (test-equal? "when teenth Wednesday is the 19th, the last day of the teenth week"
                   (meetup-day 2013 6 'Wednesday 'teenth)
                   (make-date 2013 6 19))

      (test-equal? "when teenth Thursday is some day in the middle of the teenth week"
                   (meetup-day 2013 5 'Thursday 'teenth)
                   (make-date 2013 5 16))

      (test-equal? "when teenth Thursday is the 13th, the first day of the teenth week"
                   (meetup-day 2013 6 'Thursday 'teenth)
                   (make-date 2013 6 13))

      (test-equal? "when teenth Thursday is the 19th, the last day of the teenth week"
                   (meetup-day 2013 9 'Thursday 'teenth)
                   (make-date 2013 9 19))

      (test-equal? "when teenth Friday is the 19th, the last day of the teenth week"
                   (meetup-day 2013 4 'Friday 'teenth)
                   (make-date 2013 4 19))

      (test-equal? "when teenth Friday is some day in the middle of the teenth week"
                   (meetup-day 2013 8 'Friday 'teenth)
                   (make-date 2013 8 16))

      (test-equal? "when teenth Friday is the 13th, the first day of the teenth week"
                   (meetup-day 2013 9 'Friday 'teenth)
                   (make-date 2013 9 13))

      (test-equal? "when teenth Saturday is some day in the middle of the teenth week"
                   (meetup-day 2013 2 'Saturday 'teenth)
                   (make-date 2013 2 16))

      (test-equal? "when teenth Saturday is the 13th, the first day of the teenth week"
                   (meetup-day 2013 4 'Saturday 'teenth)
                   (make-date 2013 4 13))

      (test-equal? "when teenth Saturday is the 19th, the last day of the teenth week"
                   (meetup-day 2013 10 'Saturday 'teenth)
                   (make-date 2013 10 19))

      (test-equal? "when teenth Sunday is the 19th, the last day of the teenth week"
                   (meetup-day 2013 5 'Sunday 'teenth)
                   (make-date 2013 5 19))

      (test-equal? "when teenth Sunday is some day in the middle of the teenth week"
                   (meetup-day 2013 6 'Sunday 'teenth)
                   (make-date 2013 6 16))

      (test-equal? "when teenth Sunday is the 13th, the first day of the teenth week"
                   (meetup-day 2013 10 'Sunday 'teenth)
                   (make-date 2013 10 13))

      (test-equal? "when first Monday is some day in the middle of the first week"
                   (meetup-day 2013 3 'Monday 'first)
                   (make-date 2013 3 4))

      (test-equal? "when first Monday is the 1st, the first day of the first week"
                   (meetup-day 2013 4 'Monday 'first)
                   (make-date 2013 4 1))

      (test-equal? "when first Tuesday is the 7th, the last day of the first week"
                   (meetup-day 2013 5 'Tuesday 'first)
                   (make-date 2013 5 7))

      (test-equal? "when first Tuesday is some day in the middle of the first week"
                   (meetup-day 2013 6 'Tuesday 'first)
                   (make-date 2013 6 4))

      (test-equal? "when first Wednesday is some day in the middle of the first week"
                   (meetup-day 2013 7 'Wednesday 'first)
                   (make-date 2013 7 3))

      (test-equal? "when first Wednesday is the 7th, the last day of the first week"
                   (meetup-day 2013 8 'Wednesday 'first)
                   (make-date 2013 8 7))

      (test-equal? "when first Thursday is some day in the middle of the first week"
                   (meetup-day 2013 9 'Thursday 'first)
                   (make-date 2013 9 5))

      (test-equal? "when first Thursday is another day in the middle of the first week"
                   (meetup-day 2013 10 'Thursday 'first)
                   (make-date 2013 10 3))

      (test-equal? "when first Friday is the 1st, the first day of the first week"
                   (meetup-day 2013 11 'Friday 'first)
                   (make-date 2013 11 1))

      (test-equal? "when first Friday is some day in the middle of the first week"
                   (meetup-day 2013 12 'Friday 'first)
                   (make-date 2013 12 6))

      (test-equal? "when first Saturday is some day in the middle of the first week"
                   (meetup-day 2013 1 'Saturday 'first)
                   (make-date 2013 1 5))

      (test-equal? "when first Saturday is another day in the middle of the first week"
                   (meetup-day 2013 2 'Saturday 'first)
                   (make-date 2013 2 2))

      (test-equal? "when first Sunday is some day in the middle of the first week"
                   (meetup-day 2013 3 'Sunday 'first)
                   (make-date 2013 3 3))

      (test-equal? "when first Sunday is the 7th, the last day of the first week"
                   (meetup-day 2013 4 'Sunday 'first)
                   (make-date 2013 4 7))

      (test-equal? "when second Monday is some day in the middle of the second week"
                   (meetup-day 2013 3 'Monday 'second)
                   (make-date 2013 3 11))

      (test-equal? "when second Monday is the 8th, the first day of the second week"
                   (meetup-day 2013 4 'Monday 'second)
                   (make-date 2013 4 8))

      (test-equal? "when second Tuesday is the 14th, the last day of the second week"
                   (meetup-day 2013 5 'Tuesday 'second)
                   (make-date 2013 5 14))

      (test-equal? "when second Tuesday is some day in the middle of the second week"
                   (meetup-day 2013 6 'Tuesday 'second)
                   (make-date 2013 6 11))

      (test-equal? "when second Wednesday is some day in the middle of the second week"
                   (meetup-day 2013 7 'Wednesday 'second)
                   (make-date 2013 7 10))

      (test-equal? "when second Wednesday is the 14th, the last day of the second week"
                   (meetup-day 2013 8 'Wednesday 'second)
                   (make-date 2013 8 14))

      (test-equal? "when second Thursday is some day in the middle of the second week"
                   (meetup-day 2013 9 'Thursday 'second)
                   (make-date 2013 9 12))

      (test-equal? "when second Thursday is another day in the middle of the second week"
                   (meetup-day 2013 10 'Thursday 'second)
                   (make-date 2013 10 10))

      (test-equal? "when second Friday is the 8th, the first day of the second week"
                   (meetup-day 2013 11 'Friday 'second)
                   (make-date 2013 11 8))

      (test-equal? "when second Friday is some day in the middle of the second week"
                   (meetup-day 2013 12 'Friday 'second)
                   (make-date 2013 12 13))

      (test-equal? "when second Saturday is some day in the middle of the second week"
                   (meetup-day 2013 1 'Saturday 'second)
                   (make-date 2013 1 12))

      (test-equal? "when second Saturday is another day in the middle of the second week"
                   (meetup-day 2013 2 'Saturday 'second)
                   (make-date 2013 2 9))

      (test-equal? "when second Sunday is some day in the middle of the second week"
                   (meetup-day 2013 3 'Sunday 'second)
                   (make-date 2013 3 10))

      (test-equal? "when second Sunday is the 14th, the last day of the second week"
                   (meetup-day 2013 4 'Sunday 'second)
                   (make-date 2013 4 14))

      (test-equal? "when third Monday is some day in the middle of the third week"
                   (meetup-day 2013 3 'Monday 'third)
                   (make-date 2013 3 18))

      (test-equal? "when third Monday is the 15th, the first day of the third week"
                   (meetup-day 2013 4 'Monday 'third)
                   (make-date 2013 4 15))

      (test-equal? "when third Tuesday is the 21st, the last day of the third week"
                   (meetup-day 2013 5 'Tuesday 'third)
                   (make-date 2013 5 21))

      (test-equal? "when third Tuesday is some day in the middle of the third week"
                   (meetup-day 2013 6 'Tuesday 'third)
                   (make-date 2013 6 18))

      (test-equal? "when third Wednesday is some day in the middle of the third week"
                   (meetup-day 2013 7 'Wednesday 'third)
                   (make-date 2013 7 17))

      (test-equal? "when third Wednesday is the 21st, the last day of the third week"
                   (meetup-day 2013 8 'Wednesday 'third)
                   (make-date 2013 8 21))

      (test-equal? "when third Thursday is some day in the middle of the third week"
                   (meetup-day 2013 9 'Thursday 'third)
                   (make-date 2013 9 19))

      (test-equal? "when third Thursday is another day in the middle of the third week"
                   (meetup-day 2013 10 'Thursday 'third)
                   (make-date 2013 10 17))

      (test-equal? "when third Friday is the 15th, the first day of the third week"
                   (meetup-day 2013 11 'Friday 'third)
                   (make-date 2013 11 15))

      (test-equal? "when third Friday is some day in the middle of the third week"
                   (meetup-day 2013 12 'Friday 'third)
                   (make-date 2013 12 20))

      (test-equal? "when third Saturday is some day in the middle of the third week"
                   (meetup-day 2013 1 'Saturday 'third)
                   (make-date 2013 1 19))

      (test-equal? "when third Saturday is another day in the middle of the third week"
                   (meetup-day 2013 2 'Saturday 'third)
                   (make-date 2013 2 16))

      (test-equal? "when third Sunday is some day in the middle of the third week"
                   (meetup-day 2013 3 'Sunday 'third)
                   (make-date 2013 3 17))

      (test-equal? "when third Sunday is the 21st, the last day of the third week"
                   (meetup-day 2013 4 'Sunday 'third)
                   (make-date 2013 4 21))

      (test-equal? "when fourth Monday is some day in the middle of the fourth week"
                   (meetup-day 2013 3 'Monday 'fourth)
                   (make-date 2013 3 25))

      (test-equal? "when fourth Monday is the 22nd, the first day of the fourth week"
                   (meetup-day 2013 4 'Monday 'fourth)
                   (make-date 2013 4 22))

      (test-equal? "when fourth Tuesday is the 28th, the last day of the fourth week"
                   (meetup-day 2013 5 'Tuesday 'fourth)
                   (make-date 2013 5 28))

      (test-equal? "when fourth Tuesday is some day in the middle of the fourth week"
                   (meetup-day 2013 6 'Tuesday 'fourth)
                   (make-date 2013 6 25))

      (test-equal? "when fourth Wednesday is some day in the middle of the fourth week"
                   (meetup-day 2013 7 'Wednesday 'fourth)
                   (make-date 2013 7 24))

      (test-equal? "when fourth Wednesday is the 28th, the last day of the fourth week"
                   (meetup-day 2013 8 'Wednesday 'fourth)
                   (make-date 2013 8 28))

      (test-equal? "when fourth Thursday is some day in the middle of the fourth week"
                   (meetup-day 2013 9 'Thursday 'fourth)
                   (make-date 2013 9 26))

      (test-equal? "when fourth Thursday is another day in the middle of the fourth week"
                   (meetup-day 2013 10 'Thursday 'fourth)
                   (make-date 2013 10 24))

      (test-equal? "when fourth Friday is the 22nd, the first day of the fourth week"
                   (meetup-day 2013 11 'Friday 'fourth)
                   (make-date 2013 11 22))

      (test-equal? "when fourth Friday is some day in the middle of the fourth week"
                   (meetup-day 2013 12 'Friday 'fourth)
                   (make-date 2013 12 27))

      (test-equal? "when fourth Saturday is some day in the middle of the fourth week"
                   (meetup-day 2013 1 'Saturday 'fourth)
                   (make-date 2013 1 26))

      (test-equal? "when fourth Saturday is another day in the middle of the fourth week"
                   (meetup-day 2013 2 'Saturday 'fourth)
                   (make-date 2013 2 23))

      (test-equal? "when fourth Sunday is some day in the middle of the fourth week"
                   (meetup-day 2013 3 'Sunday 'fourth)
                   (make-date 2013 3 24))

      (test-equal? "when fourth Sunday is the 28th, the last day of the fourth week"
                   (meetup-day 2013 4 'Sunday 'fourth)
                   (make-date 2013 4 28))

      (test-equal? "last Monday in a month with four Mondays"
                   (meetup-day 2013 3 'Monday 'last)
                   (make-date 2013 3 25))

      (test-equal? "last Monday in a month with five Mondays"
                   (meetup-day 2013 4 'Monday 'last)
                   (make-date 2013 4 29))

      (test-equal? "last Tuesday in a month with four Tuesdays"
                   (meetup-day 2013 5 'Tuesday 'last)
                   (make-date 2013 5 28))

      (test-equal? "last Tuesday in another month with four Tuesdays"
                   (meetup-day 2013 6 'Tuesday 'last)
                   (make-date 2013 6 25))

      (test-equal? "last Wednesday in a month with five Wednesdays"
                   (meetup-day 2013 7 'Wednesday 'last)
                   (make-date 2013 7 31))

      (test-equal? "last Wednesday in a month with four Wednesdays"
                   (meetup-day 2013 8 'Wednesday 'last)
                   (make-date 2013 8 28))

      (test-equal? "last Thursday in a month with four Thursdays"
                   (meetup-day 2013 9 'Thursday 'last)
                   (make-date 2013 9 26))

      (test-equal? "last Thursday in a month with five Thursdays"
                   (meetup-day 2013 10 'Thursday 'last)
                   (make-date 2013 10 31))

      (test-equal? "last Friday in a month with five Fridays"
                   (meetup-day 2013 11 'Friday 'last)
                   (make-date 2013 11 29))

      (test-equal? "last Friday in a month with four Fridays"
                   (meetup-day 2013 12 'Friday 'last)
                   (make-date 2013 12 27))

      (test-equal? "last Saturday in a month with four Saturdays"
                   (meetup-day 2013 1 'Saturday 'last)
                   (make-date 2013 1 26))

      (test-equal? "last Saturday in another month with four Saturdays"
                   (meetup-day 2013 2 'Saturday 'last)
                   (make-date 2013 2 23))

      (test-equal? "last Sunday in a month with five Sundays"
                   (meetup-day 2013 3 'Sunday 'last)
                   (make-date 2013 3 31))

      (test-equal? "last Sunday in a month with four Sundays"
                   (meetup-day 2013 4 'Sunday 'last)
                   (make-date 2013 4 28))

      (test-equal? "when last Wednesday in February in a leap year is the 29th"
                   (meetup-day 2012 2 'Wednesday 'last)
                   (make-date 2012 2 29))

      (test-equal? "last Wednesday in December that is also the last day of the year"
                   (meetup-day 2014 12 'Wednesday 'last)
                   (make-date 2014 12 31))

      (test-equal? "when last Sunday in February in a non-leap year is not the 29th"
                   (meetup-day 2015 2 'Sunday 'last)
                   (make-date 2015 2 22))

      (test-equal? "when first Friday is the 7th, the last day of the first week"
                   (meetup-day 2012 12 'Friday 'first)
                   (make-date 2012 12 7))))


  (run-tests suite))
