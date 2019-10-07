#lang racket
(require racket/class
         "robot-name.rkt")

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define proper-robot-name #px"\\p{Lu}{2}\\p{Nd}{4}")
  
  (define (check-proper-robot-name r)
    (check-regexp-match proper-robot-name (send r get-name)))
  
  (define robot-name-suite 
    (test-suite
     "Check proper operation of 'robots'"
     
     (test-case
      "Check that robot names conforms to the expected standard."
      (check-proper-robot-name (new robot%)))

     (test-case
      "Check that resetting a robot name also gives a proper name."
      (let ([robby (new robot%)])
        (check-regexp-match proper-robot-name (send robby get-name))
        (send robby reset)
        (check-regexp-match proper-robot-name (send robby get-name))))

     (test-case
      "Check that robots are created with unique names."
      (check-eq?
       (set-count
        (list->set
         (for/list ([i (in-range 10)])
           (send (new robot%) get-name))))
       10))))

    (run-tests robot-name-suite))