#lang slideshow

(provide quest1)

(require ts-curric-common)
(require "./common.rkt")



(define day1-2dgame
  (list
   (with-award 0 open-racket-only)
   (with-award 2 (load-code "tsgd_style_1"))
   (with-award 1 (load-code-more "4" "load_style.png"))
   (with-award 3 (google-form "http://bit.ly/2NizLFU"))
   (with-award 2 (draw-sprite-style "betty_single.png" "Character"))
   (with-award 0 export-from-piskel)
   (choose "any"
           (list
            (with-award 0 reload-fave)
            (with-award 1 save-as)
            (with-award 1 (replace-sheet "http://bit.ly/2FTnKD7"))
            ))))



(define (quest1)
  (map shrink
       (make-picts "red" "Q1-" day1-2dgame (settings (bg (local-bitmap "bg-arcade.png")) PACMAN PACMAN-BONUS PACMAN-BONUS))))

;(map slide (make-picts "red" "Q1-" day1-2dgame (settings (bg (local-bitmap "bg-arcade.png")) PACMAN PACMAN-BONUS PACMAN-BONUS)))
