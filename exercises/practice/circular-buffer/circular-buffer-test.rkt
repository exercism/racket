#lang racket/base

(require racket/class)
(require "circular-buffer.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
      "circular buffer tests"

      (test-case "reading empty buffer should fail"
	(define buffer (new circular-buffer% [capacity 1]))
	(check-exn exn:fail?  (λ () (send buffer read))))

      (test-case "can read an item just written"
	(define buffer (new circular-buffer% [capacity 1]))
	(send buffer write 1)
	(check-equal? (send buffer read) 1))

      (test-case "each item may only be read once"
	(define buffer (new circular-buffer% [capacity 1]))
	(send buffer write 1)
	(check-equal? (send buffer read) 1)
	(check-exn exn:fail?  (λ () (send buffer read))))

      (test-case "items are read in the order they are written"
	(define buffer (new circular-buffer% [capacity 2]))
	(send buffer write 1)
	(send buffer write 2)
	(check-equal? (send buffer read) 1)
	(check-equal? (send buffer read) 2))

      (test-case "full buffer can't be written to"
	(define buffer (new circular-buffer% [capacity 1]))
	(send buffer write 1)
	(check-exn exn:fail?  (λ () (send buffer write 2))))

      (test-case "a read frees up capacity for another write"
	(define buffer (new circular-buffer% [capacity 1]))
	(send buffer write 1)
	(check-equal? (send buffer read) 1)
	(send buffer write 2)
	(check-equal? (send buffer read) 2))

      (test-case "read position is maintained even across multiple writes"
	(define buffer (new circular-buffer% [capacity 3]))
	(send buffer write 1)
	(send buffer write 2)
	(check-equal? (send buffer read) 1)
	(send buffer write 3)
	(check-equal? (send buffer read) 2)
	(check-equal? (send buffer read) 3))

      (test-case "items cleared out of buffer can't be read"
	(define buffer (new circular-buffer% [capacity 1]))
	(send buffer write 1)
	(send buffer clear)
	(check-exn exn:fail?  (λ () (send buffer read))))

      (test-case "clear frees up capacity for another write"
	(define buffer (new circular-buffer% [capacity 1]))
	(send buffer write 1)
	(send buffer clear)
	(send buffer write 2)
	(check-equal? (send buffer read) 2))

      (test-case "clear does nothing on empty buffer"
	(define buffer (new circular-buffer% [capacity 1]))
	(send buffer clear)
	(send buffer write 1)
	(check-equal? (send buffer read) 1))

      (test-case "overwrite acts like write on non-full buffer"
	(define buffer (new circular-buffer% [capacity 2]))
	(send buffer write 1)
	(send buffer overwrite 2)
	(check-equal? (send buffer read) 1)
	(check-equal? (send buffer read) 2))

      (test-case "overwrite replaces the oldest item on full buffer"
	(define buffer (new circular-buffer% [capacity 2]))
	(send buffer write 1)
	(send buffer write 2)
	(send buffer overwrite 3)
	(check-equal? (send buffer read) 2)
	(check-equal? (send buffer read) 3))

      (test-case "overwrite replaces the oldest item remaining in buffer following a read"
	(define buffer (new circular-buffer% [capacity 3]))
	(send buffer write 1)
	(send buffer write 2)
	(send buffer write 3)
	(check-equal? (send buffer read) 1)
	(send buffer write 4)
	(send buffer overwrite 5)
	(check-equal? (send buffer read) 3)
	(check-equal? (send buffer read) 4)
	(check-equal? (send buffer read) 5))

      (test-case "initial clear does not affect wrapping around"
	(define buffer (new circular-buffer% [capacity 2]))
	(send buffer clear)
	(send buffer write 1)
	(send buffer write 2)
	(send buffer overwrite 3)
	(send buffer overwrite 4)
	(check-equal? (send buffer read) 3)
	(check-equal? (send buffer read) 4)
	(check-exn exn:fail?  (λ () (send buffer read))))))

  (run-tests suite))
