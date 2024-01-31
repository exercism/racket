#lang racket/base

(require "largest-series-product.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
      "largest series product tests"

      (test-equal? "finds the largest product if span equals length"
                   (largest-product "29" 2) 18)

      (test-equal? "can find the largest product of 2 with numbers in order"
                   (largest-product "0123456789" 2) 72)

      (test-equal? "can find the largest product of 2"
                   (largest-product "576802143" 2) 48)

      (test-equal? "can find the largest product of 3 with numbers in order"
                   (largest-product "0123456789" 3) 504)

      (test-equal? "can find the largest product of 3"
                   (largest-product "1027839564" 3) 270)

      (test-equal? "can find the largest product of 5 with numbers in order"
                   (largest-product "0123456789" 5) 15120)

      (test-equal? "can get the largest product of a big number"
                   (largest-product
                     "73167176531330624919225119674426574742355349194934"
                     6)
                   23520)

      (test-equal? "reports zero if the only digits are zero"
                   (largest-product "0000" 2) 0)

      (test-equal? "reports zero if all spans include zero"
                   (largest-product "99099" 3) 0)

      (test-exn "rejects span longer than string length"
                exn:fail?
                (λ () (largest-product "123" 4)))

      (test-equal? "reports 1 for empty string and empty product (0 span)"
                   (largest-product "" 0) 1)

      (test-equal? "reports 1 for nonempty string and empty product (0 span)"
                   (largest-product "123" 0) 1)

      (test-exn "rejects empty string and nonzero span"
                exn:fail?
               (λ () (largest-product "" 1)))

      (test-exn "rejects invalid character in digits"
                exn:fail?
                (λ () (largest-product "1234a5" 2)))

      (test-exn "rejects negative span"
                exn:fail?
                (λ () (largest-product "12345" -1)))))

  (run-tests suite))
