#lang racket/base

(require "flower-field.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
     "flower field tests"
     (test-equal? "no rows"
                  (annotate '())
                  '())

     (test-equal? "no columns"
                  (annotate '(""))
                  '(""))

     (test-equal? "no flowers"
                  (annotate
                   '("   "
                     "   "
                     "   "))
                  '("   "
                    "   "
                    "   "))

     (test-equal? "garden full of flowers"
                  (annotate
                   '("***"
                     "***"
                     "***"))
                  '("***"
                    "***"
                    "***"))

     (test-equal? "flower surrounded by spaces"
                  (annotate
                   '("   "
                     " * "
                     "   "))
                  '("111"
                    "1*1"
                    "111"))

     (test-equal? "space surrounded by flowers"
                  (annotate
                   '("***"
                     "* *"
                     "***"))
                  '("***"
                    "*8*"
                    "***"))

     (test-equal? "horizontal line"
                  (annotate '(" * * "))
                  '("1*2*1"))

     (test-equal? "horizontal line, flowers at edges"
                  (annotate '("*   *"))
                  '("*1 1*"))

     (test-equal? "vertical line"
                  (annotate
                   '(" "
                     "*"
                     " "
                     "*"
                     " "))
                  '("1"
                    "*"
                    "2"
                    "*"
                    "1"))

     (test-equal? "vertical line, flowers at edges"
                  (annotate
                   '("*"
                     " "
                     " "
                     " "
                     "*"))
                  '("*"
                    "1"
                    " "
                    "1"
                    "*"))

     (test-equal? "cross"
                  (annotate
                   '("  *  "
                     "  *  "
                     "*****"
                     "  *  "
                     "  *  "))
                  '(" 2*2 "
                    "25*52"
                    "*****"
                    "25*52"
                    " 2*2 "))

     (test-equal? "large garden"
                  (annotate
                   '(" *  * "
                     "  *   "
                     "    * "
                     "   * *"
                     " *  * "
                     "      "))
                  '("1*22*1"
                    "12*322"
                    " 123*2"
                    "112*4*"
                    "1*22*2"
                    "111111"))))

  (run-tests suite))
