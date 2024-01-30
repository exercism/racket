#lang racket/base

(require "pig-latin.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
     "Pig Latin tests"

          (test-equal? "word beginning with a"
                       (translate "apple") "appleay")

          (test-equal? "word beginning with e"
                       (translate "ear") "earay")

          (test-equal? "word beginning with i"
                       (translate "igloo") "iglooay")

          (test-equal? "word beginning with o"
                       (translate "object") "objectay")

          (test-equal? "word beginning with u"
                       (translate "under") "underay")

          (test-equal? "word beginning with a vowel and followed by a qu"
                       (translate "equal") "equalay")

          (test-equal? "word beginning with p"
                       (translate "pig") "igpay")

          (test-equal? "word beginning with k"
                       (translate "koala") "oalakay")

          (test-equal? "word beginning with x"
                       (translate "xenon") "enonxay")

          (test-equal? "word beginning with q without a following u"
                       (translate "qat") "atqay")

          (test-equal? "word beginning with ch"
                       (translate "chair") "airchay")

          (test-equal? "word beginning with qu"
                       (translate "queen") "eenquay")

          (test-equal? "word beginning with qu and a preceding consonant"
                       (translate "square") "aresquay")

          (test-equal? "word beginning with th"
                       (translate "therapy") "erapythay")

          (test-equal? "word beginning with thr"
                       (translate "thrush") "ushthray")

          (test-equal? "word beginning with sch"
                       (translate "school") "oolschay")

          (test-equal? "word beginning with yt"
                       (translate "yttria") "yttriaay")

          (test-equal? "word beginning with xr"
                       (translate "xray") "xrayay")

          (test-equal? "y is treated like a consonant at the beginning of a word"
                       (translate "yellow") "ellowyay")

          (test-equal? "y is treated like a vowel at the end of a consonant cluster"
                       (translate "rhythm") "ythmrhay")

          (test-equal? "y as second letter in two letter word"
                       (translate "my") "ymay")

          (test-equal? "a whole phrase"
                       (translate "quick fast run") "ickquay astfay unray")))

  (run-tests suite))
