#lang racket/base

(require "house.rkt")

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
      "This is the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse three - the rat that ate"
      (house 3 3)
      "This is the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse four - the cat that killed"
      (house 4 4)
      "This is the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse five - the dog that worried"
      (house 5 5)
      "This is the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse six - the cow with the crumpled horn"
      (house 6 6)
      "This is the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse seven - the maiden all forlorn"
      (house 7 7)
      "This is the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse eight - the man all tattered and torn"
      (house 8 8)
      "This is the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse nine - the priest all shaven and shorn"
      (house 9 9)
      "This is the priest all shaven and shorn\nthat married the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse 10 - the rooster
    that crowed in the morn"
      (house 10 10)
      "This is the rooster that crowed in the morn\nthat woke the priest all shaven and shorn\nthat married the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse 11 - the farmer sowing his corn"
      (house 11 11)
      "This is the farmer sowing his corn\nthat kept the rooster that crowed in the morn\nthat woke the priest all shaven and shorn\nthat married the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse 12 - the horse and the hound and the horn"
      (house 12 12)
      "This is the horse and the hound and the horn\nthat belonged to the farmer sowing his corn\nthat kept the rooster that crowed in the morn\nthat woke the priest all shaven and shorn\nthat married the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "multiple verses"
      (house 4 8)
      "This is the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")

    (test-equal? "verse 12 - the horse and the hound and the horn"
      (house)
      "This is the house that Jack built.\n\nThis is the malt\nthat lay in the house that Jack built.\n\nThis is the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the priest all shaven and shorn\nthat married the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the rooster that crowed in the morn\nthat woke the priest all shaven and shorn\nthat married the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the farmer sowing his corn\nthat kept the rooster that crowed in the morn\nthat woke the priest all shaven and shorn\nthat married the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.\n\nThis is the horse and the hound and the horn\nthat belonged to the farmer sowing his corn\nthat kept the rooster that crowed in the morn\nthat woke the priest all shaven and shorn\nthat married the man all tattered and torn\nthat kissed the maiden all forlorn\nthat milked the cow with the crumpled horn\nthat tossed the dog\nthat worried the cat\nthat killed the rat\nthat ate the malt\nthat lay in the house that Jack built.")
    ))

  (run-tests suite))
