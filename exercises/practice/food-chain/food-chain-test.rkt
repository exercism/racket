#lang racket/base

(require "food-chain.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite "food chain tests"

      (test-equal? "fly"
        (recite 1 1)
        '("I know an old lady who swallowed a fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."))

      (test-equal? "spider"
        (recite 2 2)
        '("I know an old lady who swallowed a spider."
          "It wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."))

      (test-equal? "bird"
        (recite 3 3)
        '("I know an old lady who swallowed a bird."
          "How absurd to swallow a bird!"
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."))

      (test-equal? "cat"
        (recite 4 4)
        '("I know an old lady who swallowed a cat."
          "Imagine that, to swallow a cat!"
          "She swallowed the cat to catch the bird."
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."))

      (test-equal? "dog"
        (recite 5 5)
        '("I know an old lady who swallowed a dog."
          "What a hog, to swallow a dog!"
          "She swallowed the dog to catch the cat."
          "She swallowed the cat to catch the bird."
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."))

      (test-equal? "goat"
        (recite 6 6)
        '("I know an old lady who swallowed a goat."
          "Just opened her throat and swallowed a goat!"
          "She swallowed the goat to catch the dog."
          "She swallowed the dog to catch the cat."
          "She swallowed the cat to catch the bird."
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."))

      (test-equal? "cow"
        (recite 7 7)
        '("I know an old lady who swallowed a cow."
          "I don't know how she swallowed a cow!"
          "She swallowed the cow to catch the goat."
          "She swallowed the goat to catch the dog."
          "She swallowed the dog to catch the cat."
          "She swallowed the cat to catch the bird."
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."))

      (test-equal? "horse"
        (recite 8 8)
        '("I know an old lady who swallowed a horse."
          "She's dead, of course!"))
  
      (test-equal? "multiple verses"
        (recite 1 3)
        '("I know an old lady who swallowed a fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."
          ""
          "I know an old lady who swallowed a spider."
          "It wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."
          ""
          "I know an old lady who swallowed a bird."
          "How absurd to swallow a bird!"
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."))

      (test-equal? "full song"
        (recite 1 8)
        '("I know an old lady who swallowed a fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."
          ""
          "I know an old lady who swallowed a spider."
          "It wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."
          ""
          "I know an old lady who swallowed a bird."
          "How absurd to swallow a bird!"
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."
          ""
          "I know an old lady who swallowed a cat."
          "Imagine that, to swallow a cat!"
          "She swallowed the cat to catch the bird."
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."
          ""
          "I know an old lady who swallowed a dog."
          "What a hog, to swallow a dog!"
          "She swallowed the dog to catch the cat."
          "She swallowed the cat to catch the bird."
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."
          ""
          "I know an old lady who swallowed a goat."
          "Just opened her throat and swallowed a goat!"
          "She swallowed the goat to catch the dog."
          "She swallowed the dog to catch the cat."
          "She swallowed the cat to catch the bird."
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."
          ""
          "I know an old lady who swallowed a cow."
          "I don't know how she swallowed a cow!"
          "She swallowed the cow to catch the goat."
          "She swallowed the goat to catch the dog."
          "She swallowed the dog to catch the cat."
          "She swallowed the cat to catch the bird."
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
          "She swallowed the spider to catch the fly."
          "I don't know why she swallowed the fly. Perhaps she'll die."
          ""
          "I know an old lady who swallowed a horse."
          "She's dead, of course!"))))

  (run-tests suite))
