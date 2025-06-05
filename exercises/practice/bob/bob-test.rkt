#lang racket/base

(require "bob.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "bob tests"

     (test-equal? "stating something"
                  (response-for "To-may-to, tom-aaaah-to.")
                  "Whatever.")

     (test-equal? "shouting"
                  (response-for "WATCH OUT!")
                  "Whoa, chill out!")

     (test-equal? "shouting gibberish"
                  (response-for "FCECDFCAAB")
                  "Whoa, chill out!")

     (test-equal? "asking a question"
                  (response-for "Does this cryogenic chamber make me look fat?")
                  "Sure.")

     (test-equal? "asking a numeric question"
                  (response-for "You are, what, like 15?")
                  "Sure.")

     (test-equal? "asking gibberish"
                  (response-for "fffbbcbeab?")
                  "Sure.")

     (test-equal? "talking forcefully"
                  (response-for "Hi there!")
                  "Whatever.")

     (test-equal? "using acronyms in regular speech"
                  (response-for "It's OK if you don't want to go work for NASA.")
                  "Whatever.")

     (test-equal? "forceful question"
                  (response-for "WHAT'S GOING ON?")
                  "Calm down, I know what I'm doing!")

     (test-equal? "shouting numbers"
                  (response-for "1, 2, 3 GO!")
                  "Whoa, chill out!")

     (test-equal? "no letters"
                  (response-for "1, 2, 3")
                  "Whatever.")

     (test-equal? "question with no letters"
                  (response-for "4?")
                  "Sure.")

     (test-equal? "shouting with special characters"
                  (response-for "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")
                  "Whoa, chill out!")

     (test-equal? "shouting with no exclamation mark"
                  (response-for "I HATE THE DENTIST")
                  "Whoa, chill out!")

     (test-equal? "statement containing question mark"
                  (response-for "Ending with ? means a question.")
                  "Whatever.")

     (test-equal? "non-letters with question"
                  (response-for ":) ?")
                  "Sure.")

     (test-equal? "prattling on"
                  (response-for "Wait! Hang on. Are you going to be OK?")
                  "Sure.")

     (test-equal? "silence"
                  (response-for "")
                  "Fine. Be that way!")

     (test-equal? "prolonged silence"
                  (response-for "          ")
                  "Fine. Be that way!")

     (test-equal? "alternate silence"
                  (response-for "\t\t\t\t\t\t\t\t\t\t")
                  "Fine. Be that way!")

     (test-equal? "multiple line question"
                  (response-for "\nDoes this cryogenic chamber make\n me look fat?")
                  "Sure.")

     (test-equal? "starting with whitespace"
                  (response-for "         hmmmmmmm...")
                  "Whatever.")

     (test-equal? "ending with whitespace"
                  (response-for "Okay if like my  spacebar  quite a bit?   ")
                  "Sure.")
    
     (test-equal? "other whitespace"
                  (response-for "\n\r \t")
                  "Fine. Be that way!")

     (test-equal? "non-question ending with whitespace"
                  (response-for "This is a statement ending with whitespace      ")
                  "Whatever.")))

  (run-tests suite))
