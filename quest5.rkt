#lang racket

(provide quest5)

(require ts-curric-common)
(require "./common.rkt")

;TODO: Change this.  It's copied from quest4...
(define day5-2dgame
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

(define (quest5)
  (map shrink
       (make-picts "red" "Q2-" day5-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))
