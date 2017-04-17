#lang racket

(require math/number-theory
         racket/date)

(define (leap-year? year)
  (or (and (divides? 4 year)
           (not (divides? 100 year)))
      (divides? 400 year)))

(define (days-in-month year month)
  (case month
    [(1 3 5 7 8 10 12) 31]
    [(4 6 9 11) 30]
    [(2) (if (leap-year? year) 29 28)]))

(define (make-date year month day)
  (seconds->date (find-seconds 0 0 0 day month year #f)))

(define (meetup-day year month weekday week)
  (let ([first-of-week
          (case week
            [(first) 1]
            [(second) 8]
            [(teenth) 13]
            [(third) 15]
            [(fourth) 22]
            [(last) (- (days-in-month year month) 6)]
            [else (raise-argument-error 'meetup-day "week" 3 year month weekday week)])]
        [weekday
          (case weekday
            [(Sunday) 0]
            [(Monday) 1]
            [(Tuesday) 2]
            [(Wednesday) 3]
            [(Thursday) 4]
            [(Friday) 5]
            [(Saturday) 6]
            [else (raise-argument-error 'meetup-day "weekday" 3 year month weekday week)])])
    (make-date year month
               (+ first-of-week
                    (modulo
                      (- weekday
                       (date-week-day (make-date year month first-of-week))) 7)
                 ))))

(provide meetup-day)
