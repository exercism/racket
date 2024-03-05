#lang racket/base

(require "diamond.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite "diamond tests"

      (test-equal? "Degenerate case with a single 'A' row"
        (rows #\A)
        '(
          "A"
        ))
    
      (test-equal? "Degenerate case with no row containing 3 distinct groups of spaces"
        (rows #\B)
        '(
          " A "
          "B B"
          " A "
        ))
    
      (test-equal? "Smallest non-degenerate case with odd diamond side length"
        (rows #\C)
        '(
          "  A  "
          " B B "
          "C   C"
          " B B "
          "  A  "
        ))
    
      (test-equal? "Smallest non-degenerate case with even diamond side length"
        (rows #\D)
        '(
          "   A   "
          "  B B  "
          " C   C "
          "D     D"
          " C   C "
          "  B B  "
          "   A   "
        ))
    
      (test-equal? "Largest possible diamond"
        (rows #\Z)
        '(
          "                         A                         "
          "                        B B                        "
          "                       C   C                       "
          "                      D     D                      "
          "                     E       E                     "
          "                    F         F                    "
          "                   G           G                   "
          "                  H             H                  "
          "                 I               I                 "
          "                J                 J                "
          "               K                   K               "
          "              L                     L              "
          "             M                       M             "
          "            N                         N            "
          "           O                           O           "
          "          P                             P          "
          "         Q                               Q         "
          "        R                                 R        "
          "       S                                   S       "
          "      T                                     T      "
          "     U                                       U     "
          "    V                                         V    "
          "   W                                           W   "
          "  X                                             X  "
          " Y                                               Y "
          "Z                                                 Z"
          " Y                                               Y "
          "  X                                             X  "
          "   W                                           W   "
          "    V                                         V    "
          "     U                                       U     "
          "      T                                     T      "
          "       S                                   S       "
          "        R                                 R        "
          "         Q                               Q         "
          "          P                             P          "
          "           O                           O           "
          "            N                         N            "
          "             M                       M             "
          "              L                     L              "
          "               K                   K               "
          "                J                 J                "
          "                 I               I                 "
          "                  H             H                  "
          "                   G           G                   "
          "                    F         F                    "
          "                     E       E                     "
          "                      D     D                      "
          "                       C   C                       "
          "                        B B                        "
          "                         A                         "
      ))))
  (run-tests suite))
