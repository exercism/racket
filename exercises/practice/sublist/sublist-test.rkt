#lang racket

(require "sublist.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define million (range 1000000))
  (define million+1 (range 1 1000001))
  (define million1s (make-list 1000000 1))

  (define suite
    (test-suite "sublist tests"
                (test-eqv? "empty lists"
                  (sublist? '() '()) 'equal)

                (test-eqv? "empty within non empty list"
                  (sublist? '() '(1 2 3)) 'sublist)

                (test-eqv? "non empty list contains empty list"
                  (sublist? '(1 2 3) '()) 'superlist)

                (test-eqv? "list equals itself"
                  (sublist? '(1 2 3) '(1 2 3)) 'equal)

                (test-eqv? "different lists"
                  (sublist? '(1 2 3) '(2 3 4)) 'unequal)

                (test-eqv? "false start"
                  (sublist? '(1 2 5) '(0 1 2 3 1 2 5 6)) 'sublist)
              
                (test-eqv? "consecutive"
                  (sublist? '(1 1 2) '(0 1 1 1 2 1 2)) 'sublist)

                (test-eqv? "sublist at start"
                  (sublist? '(0 1 2) '(0 1 2 3 4 5)) 'sublist)

                (test-eqv? "sublist at middle"
                  (sublist? '(2 3 4) '(0 1 2 3 4 5)) 'sublist)

                (test-eqv? "sublist at end"
                (sublist? '(3 4 5) '(0 1 2 3 4 5)) 'sublist)

                ; superlist at start, middle, end
                (test-eqv? "at start of superlist"
                  (sublist? '(0 1 2 3 4 5) '(0 1 2)) 'superlist)

                (test-eqv? "in middle of superlist"
                  (sublist? '(0 1 2 3 4 5) '(2 3)) 'superlist)

                (test-eqv? "at end of superlist"
                  (sublist? '(0 1 2 3 4 5) '(3 4 5)) 'superlist)

                (test-eqv? "first list missing element from second list"
                  (sublist? '(1 3) '(1 2 3)) 'unequal)

                (test-eqv?  "second list missing element from first list"
                  (sublist? '(1 2 3) '(1 3)) 'unequal)

                (test-eqv? "first list missing additional digits from second list"
                  (sublist? '(1 2) '(1 22)) 'unequal)

                (test-eqv? "order matters to a list"
                  (sublist? '(1 2 3) '(3 2 1)) 'unequal)
                  
                (test-eqv?  "same digits but different numbers"
                  (sublist? '(1 0 1) '(10 1)) 'unequal)))
                  
  (run-tests suite))
