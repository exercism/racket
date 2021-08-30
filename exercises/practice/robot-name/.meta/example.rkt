#lang racket/base

(provide make-robot
         name
         reset!
         reset-name-cache!)

;;; Public
(define (make-robot)
  (let ([name (name-generator 'get)])
    (λ (msg)
      (case msg
        [(name) name]
        [(reset!) (set! name (name-generator 'get))]
        [else (error 'robot "invalid message" msg)]))))

(define (name robot)
  (robot 'name))

(define (reset! robot)
  (robot 'reset!))

(define (reset-name-cache!)
  (name-generator 'clear!))

;;; Private
(define max-names (* 26 26 10 10 10))

(define generate-valid-name
  (let ([random-digit
         (let ([zero (char->integer #\0)])
           (λ () (integer->char (+ zero (random 10)))))]
        [random-capital-letter
         (let ([A (char->integer #\A)])
           (λ () (integer->char (+ A (random 26)))))])
    (λ ()
      (string (random-capital-letter)
              (random-capital-letter)
              (random-digit)
              (random-digit)
              (random-digit)))))

(define name-generator
  (let* ([name-cache (make-hash)]
         [handle
          (λ (name)
            (if (hash-has-key? name-cache name)
                (name-generator 'get)
                (begin (hash-set! name-cache name #t)
                       name)))])
    (λ (msg)
      (case msg
        [(get)
         (if (< (hash-count name-cache) max-names)
             (handle (generate-valid-name))
             (error 'name-generator "name-cache is full"))]
        [(clear!) (hash-clear! name-cache)]
        [else
         (error 'name-generator "invalid message passed" msg)]))))
