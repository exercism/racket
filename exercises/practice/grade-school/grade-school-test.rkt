#lang racket/base

(require racket/class)
(require "grade-school.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite "grade school tests"
      (test-case "Roster is empty when no student is added"
	(define school (new school%))
        (check-equal? (send school roster) '()))

      (test-case "Add a student"
	(define school (new school%))
        (check-true (send school add "Aimee" 2)))

      (test-case "Student is added to the roster"
	(define school (new school%))
        (check-true (send school add "Aimee" 2))
	(check-equal?
          (send school roster)
	  '((2 "Aimee"))))

      (test-case "Adding multiple students in the same grade in the roster"
	(define school (new school%))
        (check-true (send school add "Blair" 2))
        (check-true (send school add "James" 2))
        (check-true (send school add "Paul" 2)))

      (test-case "Multiple students in the same grade are added to the roster"
	(define school (new school%))
        (check-true (send school add "Blair" 2))
        (check-true (send school add "James" 2))
        (check-true (send school add "Paul" 2))
        (check-equal?
	  (send school roster)
	  '((2 "Blair" "James" "Paul"))))

      (test-case "Cannot add student to same grade in the roster more than once"
	(define school (new school%))
        (check-true (send school add "Blair" 2))
        (check-true (send school add "James" 2))
        (check-false (send school add "James" 2))
        (check-true (send school add "Paul" 2)))

      (test-case "Student not added to same grade in the roster more than once"
	(define school (new school%))
        (check-true (send school add "Blair" 2))
        (check-true (send school add "James" 2))
        (check-false (send school add "James" 2))
        (check-true (send school add "Paul" 2))
        (check-equal?
	 (send school roster)
	 '((2 "Blair" "James" "Paul"))))

      (test-case "Adding students in multiple grades"
	(define school (new school%))
        (check-true (send school add "Chelsea" 3))
        (check-true (send school add "Logan" 7)))

      (test-case "Students in multiple grades are added to the roster"
	(define school (new school%))
        (check-true (send school add "Chelsea" 3))
        (check-true (send school add "Logan" 7))
        (check-equal?
	 (send school roster)
	 '((3 "Chelsea") (7 "Logan"))))

      (test-case "Cannot add same student to multiple grades in the roster"
	(define school (new school%))
        (check-true (send school add "Blair" 2))
        (check-true (send school add "James" 2))
        (check-false (send school add "James" 3))
        (check-true (send school add "Paul" 3)))

      (test-case "Student not added to multiple grades in the roster"
	(define school (new school%))
        (check-true (send school add "Blair" 2))
        (check-true (send school add "James" 2))
        (check-false(send school add "James" 3))
        (check-true (send school add "Paul" 3))
        (check-equal?
	 (send school roster)
	 '((2 "Blair" "James") (3 "Paul"))))

      (test-case "Students are sorted by grades in the roster"
	(define school (new school%))
        (check-true (send school add "Jim" 3))
        (check-true (send school add "Peter" 2))
        (check-true (send school add "Anna" 1))
        (check-equal?
	 (send school roster)
	 '((1 "Anna") (2 "Peter") (3 "Jim"))))

      (test-case "Students are sorted by name in the roster"
	(define school (new school%))
        (check-true (send school add "Peter" 2))
        (check-true (send school add "Zoe" 2))
        (check-true (send school add "Alex" 2))
        (check-equal?
          (send school roster)
          '((2 "Alex" "Peter" "Zoe"))))

      (test-case "Students are sorted by grades and then by name in the roster"
	(define school (new school%))
        (check-true (send school add "Peter" 2))
        (check-true (send school add "Anna" 1))
        (check-true (send school add "Barb" 1))
        (check-true (send school add "Zoe" 2))
        (check-true (send school add "Alex" 2))
        (check-true (send school add "Jim" 3))
        (check-true (send school add "Charlie" 1))
        (check-equal?
	 (send school roster)
	 '((1 "Anna" "Barb" "Charlie") (2 "Alex" "Peter" "Zoe") (3 "Jim"))))

      (test-case "Grade is empty if no students in the roster"
	(define school (new school%))
        (check-equal? (send school grade 1) '()))

      (test-case "Grade is empty if no students in that grade"
	(define school (new school%))
        (check-true (send school add "Peter" 2))
        (check-true (send school add "Zoe" 2))
        (check-true (send school add "Alex" 2))
        (check-true (send school add "Jim" 3))
        (check-equal? (send school grade 1) '()))

      (test-case "Student not added to same grade more than once"
	(define school (new school%))
        (check-true (send school add "Blair" 2))
        (check-true (send school add "James" 2))
        (check-false (send school add "James" 2))
        (check-true (send school add "Paul" 2))
        (check-equal?
	 (send school grade 2)
         '("Blair" "James" "Paul")))

      (test-case "Student not added to multiple grades"
	(define school (new school%))
        (check-true (send school add "Blair" 2))
        (check-true (send school add "James" 2))
        (check-false (send school add "James" 3))
        (check-true (send school add "Paul" 3))
        (check-equal?
	 (send school grade 2)
         '("Blair" "James")))

      (test-case "Student not added to other grade for multiple grades"
	(define school (new school%))
        (check-true (send school add "Blair" 2))
        (check-true (send school add "James" 2))
        (check-false (send school add "James" 3))
        (check-true (send school add "Paul" 3))
        (check-equal?
	 (send school grade 3)
         '("Paul")))

      (test-case "Students are sorted by name in a grade"
	(define school (new school%))
        (check-true (send school add "Franklin" 5))
        (check-true (send school add "Bradley" 5))
        (check-true (send school add "Jeff" 1))
        (check-equal?
	 (send school grade 5)
         '("Bradley" "Franklin")))))

  (run-tests suite))
