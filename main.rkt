#lang slideshow

(provide quests)

(require "./quest1.rkt"
         "./quest2.rkt"
         "./quest3.rkt"
         "./quest4.rkt"
         "./quest5.rkt")

(define (quests)
  (list quest1
        quest2
        quest3
        quest4
        quest5
        quest6))
