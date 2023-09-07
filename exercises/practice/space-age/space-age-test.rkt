#lang racket

(require "space-age.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
      "space-age tests"

      (test-= "age on Earth"
              (on-earth 1000000000)
              31.69
              0.01)

      (test-= "age on Mercury"
              (on-mercury 2134835688)
              280.88
              0.01)

      (test-= "age on Venus"
              (on-venus 189839836)
              9.78
              0.01)

      (test-= "age on Mars"
              (on-mars 2129871239)
              35.88
              0.01)

     (test-= "age on Jupiter"
             (on-jupiter 901876382)
             2.41
             0.01)

     (test-= "age on Saturn"
             (on-saturn 2000000000)
             2.15
             0.01)

     (test-= "age on Uranus"
             (on-uranus 1210123456)
             0.46
             0.01)

     (test-= "age on Neptune"
             (on-neptune 1821023456)
             0.35
             0.01)))

 (run-tests suite))
