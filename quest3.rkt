#lang racket

(provide quest3)

(require ts-curric-common)
(require "./common.rkt")

;Animate your Collectible
(define day3-2dgame
  (list
   ;(with-award 1 (scan-badge "6"))
   (with-award 0 (import-to-piskel "Collectible")) ;1. Import Collectible
   (with-award 3 (animate "Collectible")) ;2. Duplicate and Edit Collectible -- change color/bounce/sparkle  (Video)
   (with-award 1 export-sprite-sheet) ;3. Export a Sprite Sheet (set rows and columns)  (Video)
   (with-award 0 open-file)
   (with-award 1 import-sprite-sheet) ;5. Insert Sprite Sheet - Change rows and columns to match sprite sheet (Video)
   (with-award 1  test-game)
   ;(with-award 1 redesign-sprite-sheet)
   (choose "any"
           (list
            (with-award 3 (animate "Character")) ;7. BONUS -- Animate the main character
            (with-award 0 export-sprite-sheet)
            (with-award 1 import-sprite-sheet)
            ;(with-award 2 (animate-more "Character"))
            ;(with-award 2 (animate-more "Background"))
            ))
   ))



(define (quest3)
  (map shrink
       (make-picts "red" "Q2-" day3-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))
