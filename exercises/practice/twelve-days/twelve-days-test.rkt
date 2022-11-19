#lang racket/base

(require "twelve-days.rkt")

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
      "twelve-days tests"

    (test-equal? "first day a partridge in a pear tree"
      (twelve-days 1 1)
      "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.")

    (test-equal? "second day two turtle doves"
      (twelve-days 2 2)
      "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "third day three french hens"
      (twelve-days 3 3)
      "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "fourth day four calling birds"
      (twelve-days 4 4)
      "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "fifth day five gold rings"
      (twelve-days 5 5)
      "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "sixth day six geese-a-laying"
      (twelve-days 6 6)
      "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "seventh day seven swans-a-swimming"
      (twelve-days 7 7)
      "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "eighth day eight maids-a-milking"
      (twelve-days 8 8)
      "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "ninth day nine ladies dancing"
      (twelve-days 9 9)
      "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "tenth day ten lords-a-leaping"
      (twelve-days 10 10)
      "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "eleventh day eleven pipers piping"
      (twelve-days 11 11)
      "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-equal? "twelfth day twelve drummers drumming"
      (twelve-days 12 12)
      "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    ;;; a visual break for me
    (test-equal? "recites first three verses of the song"
      (twelve-days 1 3)
      (line-smasher
        "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
        ""
        "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))

    (test-equal? "recites three verses from the middle of the song"
      (twelve-days 4 6)
      (line-smasher
        "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))

    (test-equal? "recites the whole song"
      (twelve-days)
      (line-smasher
        "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
        ""
        "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
        ""
        "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
    ))

  (run-tests suite))
