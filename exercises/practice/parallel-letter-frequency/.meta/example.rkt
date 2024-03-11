#lang racket

(provide calculate-frequencies)

(require racket/hash)

(define (chunk texts)
  (let* ([all-text (string-downcase (string-join texts " "))]
         [chunk-size 64]
         [nchunk (ceiling (/ (string-length all-text) chunk-size))])
    (for/list ([i (in-range nchunk)])
      (let* ([start (* i chunk-size)]
             [size (min chunk-size (- (string-length all-text) start))]
             [stop (+ start size)])
        (substring all-text start stop)))))

(define (count-letters text)
  (let [(h (make-hash))]
    (for ([c (string->list text)]
          #:when (char-alphabetic? c))
      (hash-set! h c (add1 (hash-ref h c 0))))
    h))

(define (calculate-frequencies texts)
  (let ([pieces (chunk texts)]
        [counts (make-hash)])
    (for/async ([piece pieces])
      (hash-union! counts (count-letters piece)
                   #:combine/key (λ (k c1 c2) (+ c1 c2))))
    counts))
