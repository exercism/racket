#lang racket

(provide on-mercury
         on-venus
         on-earth
         on-mars
         on-jupiter
         on-saturn
         on-uranus
         on-neptune)

(define-values (earth-seconds) 31557600)

(define (get-local-age seconds ratio) (/ seconds (* earth-seconds ratio)))

(define (on-mercury seconds) (get-local-age seconds 0.2408467))

(define (on-venus seconds) (get-local-age seconds 0.61519726))

(define (on-earth seconds) (get-local-age seconds 1))

(define (on-mars seconds) (get-local-age seconds 1.8808158))

(define (on-jupiter seconds) (get-local-age seconds 11.862615))

(define (on-saturn seconds) (get-local-age seconds 29.447498))

(define (on-uranus seconds) (get-local-age seconds 84.016846))

(define (on-neptune seconds) (get-local-age seconds 164.79132))
