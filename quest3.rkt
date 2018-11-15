#lang slideshow

(provide quest3)

(require ts-curric-common)
(require "./common.rkt")

(require racket/runtime-path)
(define-runtime-path this-curriculum ".")

;Animate your Collectible
(define day3-2dgame
  (list
   (with-award 0 (import-to-piskel "Collectible")) 
   (with-award 3 (animate "Collectible")) 
   (with-award 1 export-sprite-sheet)
   (with-award 0 open-file)
   (with-award 1 import-sprite-sheet) 
   (with-award 1  test-game)
   (choose "any"
           (list
            (with-award 3 (animate "Character")) 
            (with-award 0 export-sprite-sheet)
            (with-award 1 import-sprite-sheet)
            ))
   ))



(define (quest3)
  (map shrink
       (make-picts "red" "Q3-" day3-2dgame (settings (bg (local-bitmap "bg-arcade.png")) G-MUSH G-MUSH-BONUS G-MUSH-BONUS)))
  )

;(map slide (make-picts "red" "Q3-" day3-2dgame (settings (bg (local-bitmap "bg-arcade.png")) G-MUSH G-MUSH-BONUS G-MUSH-BONUS)))
