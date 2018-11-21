#lang racket

;High level goals:
#;(

   Title: Builder Code

          Main goal: Add houses to your game tiles
          * Add a builder chest to spawn houses
          * Run the game, create a house, and place it in a tile
          * Write down the posn of the house
          * Use that posn to type the house code
     
          
          Stretch goals: Add NPCs to game tiles
          * Modify the builder code
          * Run the game, create an NPC, and place it in a tile
          * Get the posn and use it to code the NPC
      
          ======

          Quest-complete goals:  

          Mastery level 1:  TBD

          Mastery level 2:  TBD
      
          )

(provide quest6)

(require ts-racket)
(require ts-curric-common)

(require (only-in game-engine draw-entity)
         (only-in game-engine-rpg wood-house stone-house)  )

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)

(define-runtime-path images "images")


(require "./common.rkt")

(define house-img
  (draw-entity (wood-house)))

(define stone-house-img
  (draw-entity (stone-house)))

(define (house-placer-worksheet-1)
  (define house-type (code-blank))
  (define p-x  (code-blank 50))
  (define p-y  (code-blank 50))
  (define bg-n (code-blank 50))
  
  (define code 
    (p:code (#,house-type (posn #,p-x #,p-y)
                          #:tile #,bg-n)))

   (code+hints code
               (list house-type
                     (hint
                      (p:vl-append 10
                                   (p:text "house type:")
                                   (p:hc-append (p:code wood-house)
                                                (p:text ", ")
                                                (p:code brick-house))
                                   (p:hc-append 10
                                     (p:text "or")
                                     (p:code stone-house)))))
               (list p-x p-y
                     (hint
                      (p:hb-append 10
                                   (p:text "X and Y coordinates, ex.")
                                   (p:code 100 200))))
               (list bg-n
                     (hint 
                      (p:hb-append 10
                                   (p:text "tile number, e.g.")
                                   (p:code 1))))))


(define (house-placer-worksheet-2)
  (define house-type (code-blank))
  (define p  (code-blank 50))
  (define p2 (code-blank 50))
  (define b  (code-blank 100))
  (define b2 (code-blank 50))
  
  (define code 
    (p:code (#,house-type (posn #,p #,p2)
                          #: #,b  #,b2)))

  code)

(define (house-placer-worksheet-3)
  ;(define full (code-blank 170 150))
  (define house-type (code-blank))
  (define p  (code-blank 50))
  (define p2 (code-blank 50))
  (define p3 (code-blank 50))
  (define c  (code-blank 100))
  (define b  (code-blank 50))
  
  (define code 
    (p:code (#,house-type (#,p #,p2 #,p3)
                          #: #,c #,b)))

  code)

(define (house-placer-worksheet-4)
  (define full (code-blank 300 100))
  
  (define code 
    (p:code #,full))

   (code+hints code
               (list full
                     (hint (p:vl-append 10
                                        (p:text "Can you write all the")
                                        (p:text "code for this house?")
                                        #;(p:text "(Can you do it without looking?)"))))))

(define (it-makes-a-village-worksheet)
  (define sheet
    (p:vc-append 20
                 (p:hc-append 20
                              (p:scale house-img 0.75)
                              (p:scale (p:text "It Makes a Village!") 2)
                              (p:scale house-img 0.75))
     
                 ;(p:hc-append
                  (inset-frame
                   (p:vc-append
                    (p:text "First house")
                    (house-placer-worksheet-1)))
                  (inset-frame
                   (p:vc-append
                    30
                    (p:text "Second house")
                    (house-placer-worksheet-2)
                    #;(p:ghost (p:rectangle 1 1))))
                             
                 ;(p:hc-append
                  (inset-frame
                   (p:vc-append
                    30
                    (p:text "Third house")
                    (house-placer-worksheet-3)))
                  (inset-frame
                   (p:vc-append
                    30
                    (p:text "Fourth house")
                    (house-placer-worksheet-4)))))
  (p:scale (p:inset sheet 20) 2))


(define (add-builder-code t)
  (define type
    (cond [(string=? (string-downcase t) "house") (p:code wood-house)]
          [(string=? (string-downcase t) "npc")   (p:code random-npc)]
          [else (p:code stone-house)]))
  (define b (p:frame (p:code
                      (builder (posn 200 200) #,type)) #:color "red"))
  
  (define the-code (p:code
                    (start-game (instructions-entity)
                                #,b
                                (quest-item-entity)
                                (item-entity (posn 200 200))
                                (npc1-entity)
                                (player-entity)
                                (bg-entity))))

  (code+hints the-code
              (list b
                    (hint
                     (p:vc-append
                      (p:text "Add this code")
                      (p:text "inside start-game."))))))

(define (code-first-house-code)
  (define w (p:frame (p:code
                      (wood-house (posn 325 120)
                                  #:tile 1)) #:color "red"))
  
  (define the-code (p:code
                    (start-game (instructions-entity)
                                (builder (posn 200 200) wood-house)
                                #,w
                                (quest-item-entity)
                                (item-entity (posn 200 200))
                                (npc1-entity)
                                (player-entity)
                                (bg-entity))))

  (code+hints the-code
              (list w
                    (hint
                     (p:vc-append
                      (p:text "New Code!")
                      (p:text "Exactly as written on")
                      (p:text "your worksheet"))))))




(define (npc-code)

  (define k (p:frame (p:code
                      #:name "Mario"
                      #:mode 'pace) #:color "red"))

  (define r (p:frame (p:code (random-npc (posn 100 100)
                                          #:tile 5
                                          #,k)) #:color "red"))
  
  (define the-code (p:code
                    (start-game (instructions-entity)
                                (quest-item-entity)
                                (wood-house (posn 100 300)
                                            #:tile 5)
                                (builder (posn 200 200) random-npc)
                                ;need a way to frame this larger bit that include the code hint portion
                                #,r
                                (item-entity (posn 200 200))
                                (npc1-entity)
                                (player-entity)
                                (bg-entity))))

  (code+hints the-code
              (list k
                    (hint
                     (p:vc-append
                      (p:text "Optional keyword arguments")
                      (p:text "for name and movement mode."))))))


;some of these are awfully wide to be in the vertical interactions window.
;maybe make the hints optional to go side or bottom?

(define-image-file builder-code         images (add-builder-code "House")) ;We should change this.  Keeping it for now.
(define-image-file house-builder-code   images (add-builder-code "House")) ;replace above with this when old cards are out of circulation


(define-image-file npc-builder-code   images (add-builder-code "NPC"))
(define-image-file house-code         images (code-first-house-code))


(define-image-file random-npc-code    images (npc-code))



(define try-house-builder
  (activity-instructions "Try the Builder"
                         '()
                         (list (instruction-basic "Run your game.")
                               (instruction-basic "Use the z key to create a house.")
                               (instruction-basic "Use the x key to place the house." )
                               (instruction-basic "Go back to the code and change:")
                               (instruction-basic (text-with-image (codify "wood-house") " to " (codify "stone-house")))
                               (instruction-goal "your builder working in game!"))
                         (p:scale (local-bitmap "q6-houses.png") .3)))

(define use-worksheet
  (activity-instructions "Create Your Village"
                         '()
                         (list (instruction-basic "Place a house where you want it.")
                               (instruction-basic "Note the posn and tile number on your worksheet for the First House.")
                               (instruction-basic "Place and note the locations of three more houses.")
                               (instruction-goal "your completed worksheet."))
                         (p:frame (p:scale (it-makes-a-village-worksheet) .2))))

(define code-first-house
  (activity-instructions "Code your First House"
                         '()
                         (list (instruction-basic "Add the code for your First House on your worksheet to start-game.")
                               (instruction-basic "Use the launcher to see sample code.")
                               (instruction-basic "Test your game!")
                               (instruction-goal "your house code in start-game."))
                         (launcher-img house-code)))

(define code-houses
  (activity-instructions "Code your Village"
                         '()
                         (list (instruction-basic "Add the code for the rest of your houses to start-game.")
                               (instruction-basic "Be sure to test your game!")
                               (instruction-goal "all your new code in start-game."))
                         (p:scale (local-bitmap "q6-houses.png") .3)))



(define (use-builder t)
  (activity-instructions (~a "Place Your " (string-titlecase t))
                         '()
                         (list (instruction-basic (~a "Use the builder to place the " (string-downcase t) "."))
                               (instruction-basic (text-with-image "Note the " (codify "posn") " and tile."))
                               (instruction-basic "Hint: You can write it on the back of your worksheet!")
                               (instruction-goal (~a "your position notes for your " (string-downcase t) ".")))
                         (p:scale (local-bitmap "q6-npcs-everywhere.png") .4)))

(define (code-from-builder)
  (activity-instructions "Code Your NPCs"
                         '()
                         (list (instruction-basic "Use the launcher to see sample code.")
                               (instruction-basic "Add the code for your NPCs in start-game.")
                               (instruction-goal "the new code in start-game."))
                         (launcher-img random-npc-code)))

(define day6-2dgame
  (list
   ;card 1 -- add builder
   (with-award 1 (add-builder "House" house-builder-code))
   ;card 2 -- try builder (try with other house)
   (with-award 0 try-house-builder)
   ;card 3 -- worksheet
   (with-award 2 use-worksheet)
   ;4 -- put 1st in start-game
   (with-award 1 code-first-house)
   ;5 -- put rest in start-game
   (with-award 2 code-houses)
   ;6 -- remove builder
   (with-award 1 remove-builder)
   ;bonus cards
   (choose "any"
           (list
            ;7 -- add mini map
            ;(with-award 1 mini-map)
            ;7 -- add npc builder
            (with-award 1 (add-builder "NPC" npc-builder-code))
            ;8 -- use builder to note loc of new npc 
            (with-award 0 (use-builder "NPC"))
            ;9 -- add to start-game
            (with-award 2 (code-from-builder))
            ))))

(define (quest-cards)
  (map shrink
       (make-picts "red" "Q6-" day6-2dgame (settings (bg (local-bitmap "bg-arcade.png")) LINK LINK-BONUS LINK-BONUS)))
)


(define (quest6)
  (append (quest-cards)
          (list (p:rb-superimpose
                 (it-makes-a-village-worksheet)
                 (p:scale
                  (p:text "Quest 6")
                  3)))))

(module+ test
  (quest6))
