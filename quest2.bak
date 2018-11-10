#lang slideshow

(provide quest2)

(require ts-curric-common)
(require "./common.rkt")

(require racket/runtime-path)
(define-runtime-path this-curriculum ".")

(define-webpage redesign-sprite-video
    this-curriculum
    "http://bit.ly/2It8CdW")

;Design your own Collectible
(define day2-2dgame
  (list
   ;(with-award 1 (scan-badge "5"))
   (with-award 2 (draw-sprite "collectibles.png" "Collectible"))
   (with-award 0 export-from-piskel)
   (with-award 0 open-file)
   (with-award 3 (replace-sheet replace-sprite-video))
   (with-award 1  test-game)
   (choose "any"
           (list
            (with-award 0 (import-to-piskel "Collectible"))
            (with-award 3 (redesign-sprite redesign-sprite-video))
            (with-award 1 (change-player-position))
            (with-award 1 (change-starting-tile))
            ;(with-award 1 (add-more-collectibles "https://bit.ly/2G9sIwr"))
            ))
   ))


(define (quest2)
  (map shrink
       (make-picts "red" "Q2-" day2-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))

;(map slide (make-picts "red" "Q2-" day2-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS)))
