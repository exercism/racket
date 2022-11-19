#lang racket

(provide house)

(define beginning "This is the")

(define this-is-the
  '(" house that Jack built."
    " malt~%that lay in the"
    " rat~%that ate the"
    " cat~%that killed the"
    " dog~%that worried the"
    " cow with the crumpled horn~%that tossed the"
    " maiden all forlorn~%that milked the"
    " man all tattered and torn~%that kissed the"
    " priest all shaven and shorn~%that married the"
    " rooster that crowed in the morn~%that woke the"
    " farmer sowing his corn~%that kept the"
    " horse and the hound and the horn~%that belonged to the"))

(define (house [start 1] [end 12])
  (let ([s (max 1  (min start end))]
        [e (min 12 (max start end))]
        [o (open-output-string)])
    (fprintf o beginning)
    (get-output-string
        (songer o s e))))

(define (singer out end)
  (fprintf out
           (list-ref this-is-the (sub1 end)))
  (if (= 1 end)
    out
    (singer out
            (sub1 end))))

(define (songer out start end)
  (if (= start end)
    (singer out end)
    (songer (lnln (singer out start))
            (add1 start)
            end)))

(define (lnln out)
  (fprintf out "~%~%~A" beginning)
  out)
