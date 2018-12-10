#lang racket

;High level goals:
#;(

   Title: 

          Main goal: Add Environment Elements
          * Add the element to start game
          * Use the builder to place the element in a tile
          * Get the posn and code the element
     
          Stretch goals:
          * Add Mini Map
          * Add more elements
          
          ======

          Quest-complete goals:  

          Mastery level 1:  TBD

          Mastery level 2:  TBD
      
          )


(provide quest8)

(require ts-racket)
(require ts-curric-common)

(require (only-in game-engine draw-entity)
         (except-in game-engine-rpg room) )

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)

(define-runtime-path images "images")


(require "./common.rkt")


(define (blank-builder-code)
  (define c (code-blank))

  (define b (p:frame (p:code
                      (builder (posn 200 200) #,c)) #:color "red"))
  
  (define the-code (p:code
                    (start-game (instructions-entity)
                                #,b
                                (item-entity (posn 200 200))
                                (npc1-entity)
                                (player-entity)
                                (bg-entity))))

  (code+hints the-code
              (list c
                    (hint
                     (p:vc-append
                      (p:text "Type the name of your")
                      (p:text "chosen element here."))))))

(define (mini-map-code)
  (define m (p:frame (p:code
                      (on-key "m" (open-mini-map #:close-key 'o))) #:color "red"))
  
  (define the-code (p:code
                    (define (bg-entity)
                      (sprite->entity (render-tile (snow-backdrop))
                                      #:name     "bg"
                                      #:position   (posn 0 0)
                                      #:components (static)
                                                   #,m
                                                   (snow-backdrop)))))
  (code+hints the-code
              (list m
                    (hint
                     (p:vc-append
                      (p:text "Add this line to the")
                      (p:text "components of your bg-entity.")
                      (p:text "Mind the parentheses!"))))))

(define (asset-list)

  (define a (inset-frame (draw-entity (round-tree))))
  (define b (inset-frame (draw-entity (pine-tree))))
  (define c (inset-frame (draw-entity (cat))))
  (define d (inset-frame (draw-entity (bat))))
  (define e (inset-frame (draw-entity (slime))))
  (define f (inset-frame (draw-entity (snake))))
  (define g (inset-frame (draw-entity (apples))))
  
  (p:inset
   (p:vl-append
    (code+hints a
                (list a
                      (hint
                       (p:code round-tree))))
    (code+hints b
                (list b
                      (hint
                       (p:code pine-tree))))
    (code+hints g
                (list g
                      (hint
                       (p:code apples))))
    (code+hints c
                (list c
                      (hint
                       (p:vl-append
                        (p:code cat)
                        (p:text "Also try:")
                        (text-with-image (p:code white-cat) (p:text " or ") (p:code black-cat))))))
    (code+hints d
                (list d
                      (hint
                       (p:code bat))))
    (code+hints e
                (list e
                      (hint
                       (p:code slime))))
    (code+hints f
                (list f
                      (hint
                       (p:code snake))))) 10
  ))


(define (game-with-new-entity)
  (define r (p:frame (p:code (round-tree (posn 300 300)
                                         #:tile 0 #:hue 5 #:size 1)) #:color "red"))
  
  (define the-code (p:code
                    (start-game (instructions-entity)
                                (builder (posn 200 200) random-npc)
                                ;need a way to frame this larger bit that include the code hint portion
                                #,r
                                (item-entity (posn 200 200))
                                (npc1-entity)
                                (player-entity)
                                (bg-entity))))

  (code+hints the-code
              (list r
                    (hint
                     (p:text "Example added element.")))))

;some of these are awfully wide to be in the vertical interactions window.
;maybe make the hints optional to go side or bottom?
(define-image-file element-list    images (asset-list))
(define-image-file map-code        images (mini-map-code))
(define-image-file my-builder-code images (blank-builder-code))

(define-image-file your-own-code   images (game-with-new-entity))


(define mini-map
  (activity-instructions "Add Mini Map!"
                         '()
                         (list (instruction-basic "Use the launcher to see the code.")
                               (instruction-basic (text-with-image "Add the line of code to the " (codify "bg-entity")))
                               (instruction-basic "Test your game! Which key on your keyboard will open the mini map? Close it?")
                               (instruction-goal "your mini-map in game!"))
                         (launcher-img map-code)))


(define get-elements
  (activity-instructions "Pick an Environment Element"
                         '()
                         (list (instruction-basic "Use the launcher to see all environmental elements to add to your game.")
                               (instruction-basic "Pick which you would like to add to your game! (Just one! You can add more later)")
                               (instruction-goal "which element you chose."))
                         (launcher-img element-list)))

(define try-builder
  (activity-instructions "Use the Builder"
                         '()
                         (list (instruction-basic "Run your game.")
                               (instruction-basic "Use the z key to create.")
                               (instruction-basic "Use the x key to place.")
                               (instruction-basic "Use the bracket keys to change size (upper left of keyboard!).")
                               (instruction-basic "Use the p key to change hue.")
                               (instruction-goal "your builder working in game!"))
                         (p:scale (local-bitmap "q6-houses.png") .3)))



(define note-relevant-data
  (activity-instructions "Jot down element data"
                         '()
                         (list (instruction-basic "Jot down the position.")
                               (instruction-basic "Jot down the tile.")
                               (instruction-basic "Jot down the hue.")
                               (instruction-basic "Jot down the size.")
                               (instruction-goal "your relevant data jotted down"))
                         (p:scale
                          (local-bitmap "placed-entity.png")
                          1.2)))



(define your-own-entity
  (activity-instructions "Code your Element"
                         '()
                         (list (instruction-basic "Add your element to the game")
                               (instruction-basic "Use the launch code to see an example")
                               (instruction-goal "your game with custom entities!"))
                         (launcher-img your-own-code)))


(define repeat-1-6
  (activity-instructions "Code More Elements!"
                         '()
                         (list (instruction-basic "Add more elements to your game.")
                               (instruction-basic "Repeat cards 1-6 with a new element.")
                               (instruction-basic "(Yes, you get $$ each time.)")
                               (instruction-goal "your game with custom entities!"))
                         (p:vc-append
                          (p:hc-append
                           (draw-entity (round-tree #:hue 250))
                           (draw-entity (round-tree #:hue 180)))
                          (p:hc-append
                           (draw-entity (cat #:hue 250 #:size 3))
                           (draw-entity (cat #:hue 180 #:size 3))))))


(define day8-2dgame
  (list
   ;card 1 -- Generate list of assets
   (with-award 0 get-elements)
   ;card 2 -- add builder for favorite asset
   (with-award 1 (add-builder "Element" my-builder-code))
   ;3 -- try builder
   (with-award 1 try-builder)
   ;4 -- note posn, tile, (optional: size and hue)
   (with-award 1 note-relevant-data)
   
   ;5 -- add to code (need sample code with size and hue)
   (with-award 2 your-own-entity)
   
   ;6 -- remove builder
   (with-award 0 remove-builder)
   
   ;bonus cards
   (choose "any"
           (list
            ;7 -- option 1: add mini map
            (with-award 1 mini-map)
            ;8 -- option 2: Repeat cards 1-6 and earn money for each time 
            (with-award 0 repeat-1-6)
            ))))

(define (quest-cards)
  (map shrink
       (make-picts "red" "Q8-" day8-2dgame (settings (bg (local-bitmap "bg-arcade.png")) PIKACHU PIKACHU-BONUS PIKACHU-BONUS)))
  )


(define (quest8)
  (quest-cards))

(module+ test
  (quest8))
