#lang slideshow

;High level goals:
#;(

   Title: Game Starters 

   Main goal: Open and run starter games, think critically about differences
      * Load and play starters
      * Fill out game review
      * Draw player

   Stretch goals:
      * Rename favorite starter 
      * Replace player with own
      
   ======

   Quest-complete goals:  
      * Suggestions (since today's concepts are not easily repeated)
         * Investigate starter code, find x many things you can change to alter gameplay
         * Look at documentation, learn more about functions being used
         * Discuss with other students a more in-depth perspective on games, what liked/disliked
         * If suspected/known that the student didn't go into much detail with
         Game Review or player design, do again.

   Mastery level 1:  TBD

   Mastery level 2:  TBD
      
   )

(provide quest1)

(require ts-curric-common)
(require "./common.rkt")

(require racket/runtime-path)
(define-runtime-path this-curriculum ".")

(define load-code 
  (activity-instructions "Load the Starter Code"
                         '()
                         (list (instruction-basic "Use the launch code to open the game.")
                               (instruction-basic "Run the game.")
                               (instruction-goal  "The demo game running in DrRacket"))
                         (launcher-img style1-starter)))

(define (load-code-more endGame)
  (activity-instructions (++ "Test Games 2 Through " endGame)
                         '()
                         (list (instruction-basic "Use the launch code to open the next game.")
                               (instruction-basic "Run the game.")
                               (instruction-basic (~a "Launch all demos through " endGame "."))
                               (instruction-goal  (~a "demo " endGame " running.")))
                         (launcher-img style2-starter)))

(define reload-fave
  (activity-instructions "Reload Your Favorite Style"
                         '()
                         (list (instruction-basic "Reload the game with your favorite style.")
                               (instruction-basic "This will become your game file.")
                               (instruction-goal  "your favorite game style open."))
                         (launcher-img style1-starter)))

(define-webpage game-review
    this-curriculum
    "http://bit.ly/2NizLFU")

(define day1-2dgame
  (list
   ;(with-award 0 open-racket-only)
   (with-award 1 (how-to-use-launcher-card))
   (with-award 2 load-code)
   (with-award 1 (load-code-more "4"))
   (with-award 3 (google-form game-review))
   (with-award 2 (draw-sprite-style "betty_single.png" "Character"))
   (with-award 0 export-from-piskel)
   (choose "any"
           (list
            (with-award 0 reload-fave)
            (with-award 1 save-as)
            (with-award 1 (replace-sheet replace-sprite-video))
            ))))



(define (quest1)
  (map shrink
       (make-picts "red" "Q1-" day1-2dgame (settings (bg (local-bitmap "bg-arcade.png")) PACMAN PACMAN-BONUS PACMAN-BONUS)))
  )

;(map slide (make-picts "red" "Q1-" day1-2dgame (settings (bg (local-bitmap "bg-arcade.png")) PACMAN PACMAN-BONUS PACMAN-BONUS)))
