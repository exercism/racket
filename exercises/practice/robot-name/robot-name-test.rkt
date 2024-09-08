#lang racket/base

; There were no canonical tests to perform.
(require "robot-name.rkt")

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define max-names (* 26 26 10 10 10))

  (define proper-robot-name #px"^\\p{Lu}{2}\\p{Nd}{3}$")

  (define (check-proper-robot-name r)
    (check-regexp-match proper-robot-name (name r)))

  (define robot-name-suite
    (test-suite
     "Check proper operation of 'robots'"

     (test-case
      "Check that robot names conforms to the expected standard."
      (check-proper-robot-name (make-robot)))

     (test-case
      "Check that resetting a robot name also gives a proper name."
      (let* ([robby (make-robot)]
             [name1 (name robby)]
             [_ (reset! robby)]
             [name2 (name robby)])
        (check-regexp-match proper-robot-name name1)
        (check-regexp-match proper-robot-name name2)
        (check-not-equal? name1 name2)))

     ;; reset cache in order to generate all the names
     (test-case
      "Check that robots are created with unique names."
      (let ([count (/ max-names 4)])
        (reset-name-cache!)
        (check-equal?
         (let ([names (make-hash)])
           (for ((_ (in-range count)))
             (hash-set! names (name (make-robot)) #t))
           (hash-count names))
         count)))))

  (run-tests robot-name-suite))
