#lang racket/base

(require "example.rkt")

(define (line-smasher . lines)
  (let rec ([str (car lines)]
            [moar (cdr lines)])
    (if (null? moar)
        str
        (rec (format "~A~%~A" str (car moar))
             (cdr moar)))))

(module+ test

  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
      "Return specified verse or series of verses"

    (test-equal? "verse one - the house that Jack built"
      (house 1 1)
      "This is the house that Jack built.")

    (test-equal? "verse two - the malt that lay"
      (house 2 2)
      (line-smasher
        "This is the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse three - the rat that ate"
      (house 3 3)
      (line-smasher
        "This is the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse four - the cat that killed"
      (house 4 4)
      (line-smasher
        "This is the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse five - the dog that worried"
      (house 5 5)
      (line-smasher
        "This is the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse six - the cow with the crumpled horn"
      (house 6 6)
      (line-smasher
        "This is the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse seven - the maiden all forlorn"
      (house 7 7)
      (line-smasher
        "This is the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse eight - the man all tattered and torn"
      (house 8 8)
      (line-smasher
        "This is the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse nine - the priest all shaven and shorn"
      (house 9 9)
      (line-smasher
        "This is the priest all shaven and shorn"
        "that married the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse 10 - the rooster that crowed in the morn"
      (house 10 10)
      (line-smasher
        "This is the rooster that crowed in the morn"
        "that woke the priest all shaven and shorn"
        "that married the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse 11 - the farmer sowing his corn"
      (house 11 11)
      (line-smasher
        "This is the farmer sowing his corn"
        "that kept the rooster that crowed in the morn"
        "that woke the priest all shaven and shorn"
        "that married the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse 12 - the horse and the hound and the horn"
      (house 12 12)
      (line-smasher
        "This is the horse and the hound and the horn"
        "that belonged to the farmer sowing his corn"
        "that kept the rooster that crowed in the morn"
        "that woke the priest all shaven and shorn"
        "that married the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "multiple verses"
      (house 4 8)
      (line-smasher
        "This is the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))

    (test-equal? "verse 12 - the horse and the hound and the horn"
      (house)
      (line-smasher
        "This is the house that Jack built."
        ""
        "This is the malt"
        "that lay in the house that Jack built."
        ""
        "This is the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the priest all shaven and shorn"
        "that married the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the rooster that crowed in the morn"
        "that woke the priest all shaven and shorn"
        "that married the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the farmer sowing his corn"
        "that kept the rooster that crowed in the morn"
        "that woke the priest all shaven and shorn"
        "that married the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."
        ""
        "This is the horse and the hound and the horn"
        "that belonged to the farmer sowing his corn"
        "that kept the rooster that crowed in the morn"
        "that woke the priest all shaven and shorn"
        "that married the man all tattered and torn"
        "that kissed the maiden all forlorn"
        "that milked the cow with the crumpled horn"
        "that tossed the dog"
        "that worried the cat"
        "that killed the rat"
        "that ate the malt"
        "that lay in the house that Jack built."))
    ))

  (run-tests suite))
