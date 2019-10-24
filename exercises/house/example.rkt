#lang racket

(provide house)

(define framework "This is the~a house that Jack built.")

(define this-is-the
  '(("" "")
    ("malt"                             "lay in the")
    ("rat"                              "ate the")
    ("cat"                              "killed the")
    ("dog"                              "worried the")
    ("cow with the crumpled horn"       "tossed the")
    ("maiden all forlorn"               "milked the")
    ("man all tattered and torn"        "kissed the")
    ("priest all shaven and shorn"      "married the")
    ("rooster that crowed in the morn"  "woke the")
    ("farmer sowing his corn"           "kept the")
    ("horse and the hound and the horn" "belonged to the")))

(define (house [start 1] [end 12])
  (let [(s (max 1  (min start end)))
        (e (min 12 (max start end)))]
    (singer s e)))

(define (singer start end)
  )
