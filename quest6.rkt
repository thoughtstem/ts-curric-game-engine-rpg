#lang racket

(provide quest6)

(require ts-curric-common)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))

(require "./common.rkt")


(define (code+hint full-code
                   hint-targets+hint-text)


  
  (define hint-targets (take hint-targets+hint-text
                             (sub1 (length hint-targets+hint-text))))
  

  (define hint-text   (last   hint-targets+hint-text))
  (define hint (p:text hint-text))

  (define combined
    (p:hc-append 50 full-code (p:colorize hint "red")))

  (define (render-arrow target)
   (p:pin-arrow-line 10
                     combined 
                     hint       p:lc-find
                     target     p:rc-find
                     #:line-width 3
                     #:color "red"  ))

  (define imgs
    (map render-arrow
         hint-targets))

  (apply p:cc-superimpose imgs))

(define (code+hints code . hints)
  (p:lc-superimpose
   (code+hint code
              (first hints))
   (code+hint code
              (second hints))
   )
  )

(define (code-blank (w 100))
  (p:colorize (p:rectangle w 20) "red"))


(define (house-placer-worksheet)
  (define house-type (code-blank))
  (define p-x  (code-blank))
  (define p-y  (code-blank))
  (define bg-n (code-blank))
  
  (define code 
    (p:code ( #,house-type
              (posn #,p-x #,p-y)
              #:component
              (active-on-bg #,bg-n))))

  (p:scale
   (code+hints code
               (list house-type "wood-house or stone-house")
               (list p-x p-y bg-n "number"))
   2))

(house-placer-worksheet)

;TODO: Change this.  It's copied from quest4...
(define day6-2dgame
  (list
   (with-award 0 open-file)
   (with-award 2 change-player-dialog)
   (with-award 2 change-npc-dialog)
   (with-award 2 add-new-dialog)
   (with-award 1 (make-npc "wander"))
   (with-award 1 (make-npc "still"))
   (choose "any"
           (list
            (with-award 1 (make-npc "follow"))
            (with-award 1 change-npc-speed)
            (with-award 2 draw-and-add-npc)))))

(define (quest6)
  (map shrink
       (make-picts "red" "Q2-" day6-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))