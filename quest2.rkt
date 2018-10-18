#lang slideshow

(provide quest2)

(require ts-curric-common)
(require "./common.rkt")

;Design your own Collectible
(define day2-2dgame
  (list
   ;(with-award 1 (scan-badge "5"))
   (with-award 2 (draw-sprite "collectibles.png" "Collectible"))
   (with-award 0 export-from-piskel)
   (with-award 0 open-file)
   (with-award 3 (replace-sheet "http://bit.ly/2FTnKD7"))
   (with-award 1  test-game)
   (choose "any"
           (list
            (with-award 0 (import-to-piskel "Collectible"))
            (with-award 3 (redesign-sprite "http://bit.ly/2It8CdW"))
            (with-award 1 (change-player-position "http://bit.ly/2tTaFoi"))
            (with-award 1 (change-starting-tile))
            ;(with-award 1 (add-more-collectibles "https://bit.ly/2G9sIwr"))
            ))
   ))


(define (quest2)
  (map shrink
       (make-picts "red" "Q2-" day2-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))

;(map slide (make-picts "red" "Q2-" day2-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS)))
