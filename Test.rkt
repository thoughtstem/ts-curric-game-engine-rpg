#lang slideshow

(require (prefix-in h: 2htdp/image))

(require ts-curric-common)
(require racket/runtime-path)

(define-runtime-path images "images")

(define i (circle 50))
(define i2 (h:circle 50 'solid 'red))


(define-image-file my-circ  images i)

(define test
  (with-award 1
    (activity-instructions "Test"
                           '()
                           (list (instruction-basic "Scan the card to open the Game Review.")
                                 (instruction-basic "Answer the questions about the demo games.")
                                 (instruction-goal "your Google Form submitted."))
                           (launcher-img my-circ  ))))


(make-picts "red" "Q2-" test
            (settings (bg i) i i i))
