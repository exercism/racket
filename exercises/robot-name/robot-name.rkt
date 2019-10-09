#lang racket
(require racket/class)

(provide make-robot
         name
         reset!
         reset-name-cache!)

;;; Public
(define (make-robot)
  (new robot%))

(define (name robot)
  (send robot get-name))

(define (reset! robot)
  (send robot reset!))

(define (reset-name-cache!)
  (name-generator 'clear!))

;;; Private

(define max-names (* 26 26 10 10 10))

(define generate-valid-name
  (let ((random-digit
         (let ((zero (char->integer #\0)))
           (λ () (integer->char (+ zero (random 10))))))
        (random-capital-letter
         (let ((A (char->integer #\A)))
           (λ () (integer->char (+ A (random 26)))))))
    (λ ()
      (string (random-capital-letter)
              (random-capital-letter)
              (random-digit)
              (random-digit)
              (random-digit)))))

(define name-generator
  (let* (;; cache to keep track of names in use
         (name-cache (make-hash))
         ;; add name to cache and return the name
         (register
          (λ (name)
            (begin (hash-set! name-cache name #t)
                   name)))
         ;; ensure a unique name is produced
         (handle
          (λ (name)
            (if (hash-has-key? name-cache name)
                (name-generator 'get)
                (register name)))))
    (λ (msg)
      (case msg
        ((get) (if (< (hash-count name-cache) max-names)
                   (handle (generate-valid-name))
                   (error 'name-generator "name-cache is full")))
        ((clear!) (hash-clear! name-cache))
        (else
         (error 'name-generator "invalid message passed" msg))))))

; https://docs.racket-lang.org/guide/classes.html
(define robot%
  (class object%
    (super-new)
    (define name (name-generator 'get))
    (define/public (get-name)
      name)
    (define/public (reset!)
      (set! name (name-generator 'get)))))
