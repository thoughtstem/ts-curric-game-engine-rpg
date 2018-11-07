#lang slideshow

(provide quest5)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)

(define-runtime-path images "images")

(require ts-curric-common)
(require "./common.rkt")
(require (except-in ts-racket
                    scale-to-fit))

;----- IMAGES
(define (backpack-img)
  (define new-code (p:frame (p:code
                             (backpack-system)) #:color "red"))
  (define the-code (p:code
                    (define (player-entity)
                      (sprite->entity player-sprite
                                      #:name       "player"
                                      #:position   (posn 100 100)
                                      #:components (direction 0)
                                      (rotation-style 'left-right)
                                      (sound-stream)
                                      (key-movement 10 #:rule all-dialog-closed?)
                                      (stop-on-edge)
                                      #,new-code
                                      (counter 0)
                                      (on-no-key-movement (stop-animation))
                                      (on-key-movement (start-animation))
                                      (on-key 'right (set-direction 0))
                                      (on-key 'left  (set-direction 180))
                                      (on-key "i" (open-dialog instructions-entity))
                                      (on-key 'enter #:rule player-dialog-open? (get-dialog-selection))
                                      (on-key 'space #:rule (ready-to-speak-and-near? "Jordan")
                                              (do-many (set-counter 0)
                                                       (open-dialog (dialog-list player-dialog
                                                                                 (posn (/ WIDTH 2) (/ HEIGHT 2))
                                                                                 #:sound BLIP-SOUND))
                                                       (play-sound OPEN-DIALOG-SOUND)))
                                      (player-edge-system)
                                      (on-collide "item" (do-many (spawn (item-entity (posn 0 0)) #:relative? #f)
                                                                  (play-sound PICKUP-SOUND)))
                                      ))))
  (code+hints the-code
              (list new-code
                    (hint (p:text "TYPE NEW CODE HERE")))))

(define (new-item-img)
  (define new-code (p:frame (p:code
                             (define (quest-item-entity)
                               (sprite->entity (sheet->sprite #,(local-bitmap "lightsabers.png")
                                                              #:rows       1
                                                              #:columns    2
                                                              #:row-number 1
                                                              #:speed      3)
                                               #:position   (posn 100 100)
                                               #:name       "Lightsaber"
                                               #:components (active-on-bg 1)
                                               (hidden)
                                               (storable)
                                               (on-start (do-many (respawn 'anywhere)
                                                                  show))))) #:color "red"))
  (define the-code (p:code
                    (define (item-entity p)
                      (sprite->entity item-sprite
                                      #:position   p
                                      #:name       "item"
                                      #:components (active-on-bg 0)
                                      (hidden)
                                      (on-start (do-many (active-on-random)
                                                         (respawn 'anywhere)
                                                         show))
                                      (on-collide "player" die)))
                    code:blank
                    #,new-code
                    code:blank
                    (define (instructions-entity)
                      (sprite->entity (draw-title (~a "Use ARROW KEYS to move.\n"
                                                      "Press SPACE BAR to interact.\n"
                                                      "Press ENTER to select or close dialog.\n"
                                                      "Press I to open these instructions."))
                                      #:position   (posn (/ WIDTH 2) (/ HEIGHT 2))
                                      #:name       "instructions"
                                      #:components (static)
                                      (on-key 'enter die)
                                      (on-key 'space die)
                                      (on-key "i" die)))
                    ))
  
  (code+hints the-code
              (list new-code
                    (hint (p:text "PASTE NEW CODE HERE")))))
  
(define (add-quest-item-entity-img)
  (define new-code (p:frame (p:code
                             (quest-item-entity)) #:color "red"))
  (define the-code (p:code
                    (code:comment " === RUN THE GAME ===")
                    (start-game (instructions-entity)
                                #,new-code
                                (item-entity (posn 200 200))
                                (npc1-entity)
                                (player-entity)
                                (bg-entity))
                    ))
  
  (code+hints the-code
              (list new-code
                    (hint (p:text "TYPE NEW CODE HERE")))))

(define (add-physics-to-item-img)
  (define new-code (p:frame (p:code
                             (physical-collider)
                             (stop-on-edge)) #:color "red"))
  (define the-code (p:code
                    (code:comment " ==== QUEST ITEM DEFINITION ====")
                     
                    (define (quest-item-entity)
                      (sprite->entity (sheet->sprite #,(local-bitmap "lightsabers.png")
                                                     #:rows       1
                                                     #:columns    2
                                                     #:row-number 1
                                                     #:speed      3)
                                      #:position   (posn 100 100)
                                      #:name       "Lightsaber"
                                      #:components (active-on-bg 1)
                                      (hidden)
                                      (storable)
                                      #,new-code
                                      (on-start (do-many (respawn 'anywhere)
                                                         show))))

                    ))
  
  (code+hints the-code
              (list new-code
                    (hint (p:text "TYPE NEW CODE HERE")))))

(define (item-different-tile-img)
  (define new-code (p:frame (p:code
                             (active-on-bg 1)) #:color "red"))
  (define the-code (p:code
                    (code:comment " ==== QUEST ITEM DEFINITION ====")
                     
                    (define (quest-item-entity)
                      (sprite->entity (sheet->sprite #,(local-bitmap "lightsabers.png")
                                                     #:rows       1
                                                     #:columns    2
                                                     #:row-number 1
                                                     #:speed      3)
                                      #:position   (posn 100 100)
                                      #:name       "Lightsaber"
                                      #:components #,new-code
                                      (hidden)
                                      (storable)
                                      (physical-collider)
                                      (stop-on-edge)
                                      (on-start (do-many (respawn 'anywhere)
                                                         show))))
                    ))
  
  (code+hints the-code
              (list new-code
                    (hint (p:text "CHANGE THIS NUMBER")))))

(define (item-random-tile-img)
  (define new-code (p:frame (p:code
                             (active-on-random)) #:color "red"))
  (define the-code (p:code
                    (code:comment " ==== QUEST ITEM DEFINITION ====")
                     
                    (define (quest-item-entity)
                      (sprite->entity (sheet->sprite #,(local-bitmap "lightsabers.png")
                                                     #:rows       1
                                                     #:columns    2
                                                     #:row-number 1
                                                     #:speed      3)
                                      #:position   (posn 100 100)
                                      #:name       "Lightsaber"
                                      #:components (active-on-bg 5)
                                      (hidden)
                                      (storable)
                                      (physical-collider)
                                      (stop-on-edge)
                                      (on-start (do-many (respawn 'anywhere)
                                                         #,new-code
                                                         show))))
                    ))
  
  (code+hints the-code
              (list new-code
                    (hint (p:text "TYPE NEW CODE HERE")))))

(define (change-item-sprite-img)
  (define new-code (p:frame (p:code
                             (sheet->sprite #,(local-bitmap "sword-sprite-sheet.png")
                                            #:rows       1
                                            #:columns    3
                                            #:row-number 1
                                            #:speed      3)) #:color "red"))
  (define the-code (p:code
  
                    (define (quest-item-entity)
                      (sprite->entity #,new-code
                                      #:position   (posn 100 100)
                                      #:name       "Lightsaber"
                                      #:components (active-on-bg 8)
                                      (hidden)
                                      (storable)
                                      (physical-collider)
                                      (stop-on-edge)
                                      (on-start (do-many (respawn 'anywhere)
                                                         (active-on-random)
                                                         show))))
                    ))
  
  (code+hints the-code
              (list new-code
                    (hint (p:text "INSERT IMAGE HERE")))))

(define (change-backpack-keys-img)
  (define new-code (p:frame (p:code
                             (backpack-system #:store-key   "e"
                                              #:drop-key    "q"
                                              #:backpackkey "r")) #:color "red"))
  (define the-code (p:code
                    (define (player-entity)
                      (sprite->entity player-sprite
                                      #:name       "player"
                                      #:position   (posn 100 100)
                                      #:components (direction 0)
                                      (rotation-style 'left-right)
                                      (sound-stream)
                                      (key-movement 10 #:rule all-dialog-closed?)
                                      (stop-on-edge)
                                      #,new-code
                                      (counter 0)
                                      (on-no-key-movement (stop-animation))
                                      (on-key-movement (start-animation))
                                      (on-key 'right (set-direction 0))
                                      (on-key 'left  (set-direction 180))
                                      (on-key "i" (open-dialog instructions-entity))
                                      (on-key 'enter #:rule player-dialog-open? (get-dialog-selection))
                                      (on-key 'space #:rule (ready-to-speak-and-near? "Jordan")
                                              (do-many (set-counter 0)
                                                       (open-dialog (dialog-list player-dialog
                                                                                 (posn (/ WIDTH 2) (/ HEIGHT 2))
                                                                                 #:sound BLIP-SOUND))
                                                       (play-sound OPEN-DIALOG-SOUND)))
                                      (player-edge-system)
                                      (on-collide "item" (do-many (spawn (item-entity (posn 0 0)) #:relative? #f)
                                                                  (play-sound PICKUP-SOUND)))
                                      ))
                    ))
  
  (code+hints the-code
              (list new-code
                    (hint (p:text "TYPE NEW CODE HERE")))))

; -- DEFINE IMAGE FILES
(define-image-file backpack-system      images (p:scale (backpack-img) 1.5))
(define-image-file new-item-code        images (p:scale (new-item-img) 1.5))
(define-image-file add-item-to-start    images (p:scale (add-quest-item-entity-img) 1.5))
(define-image-file add-physics-to-item  images (p:scale (add-physics-to-item-img) 1.5))
(define-image-file change-item-tile     images (p:scale (item-different-tile-img) 1.5))
(define-image-file random-item-tile     images (p:scale (item-random-tile-img) 1.5))
(define-image-file change-item-sprite   images (p:scale (change-item-sprite-img) 1.5))
(define-image-file change-backpack-keys images (p:scale (change-backpack-keys-img) 1.5))

;------ Start Quest 5 cards ---
(define add-backpack
  (activity-instructions "Add Backpack System"
                         '()
                         (list (instruction-basic "Scan the QR, add the new code to your player-entity")
                               (instruction-basic (text-with-image "Type: " (codify "(backpack-system)")))
                               (instruction-basic "AFTER (stop-on-edge)")
                               (instruction-goal "your new code in your project"))
                         (launcher-img backpack-system)))
  
(define add-item-code
  (activity-instructions "Add Item Code"
                         '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (scale (codify "tsgd_quest_item") 1.5)))
                               (instruction-basic "Copy/Paste the Code BEFORE (define (instructions-entity)")
                               (instruction-goal "your new code in your project"))
                         (launcher-img new-item-code)))
  
(define add-item-ent-to-start
  (activity-instructions "Add Item to start-game"
                         '()
                         (list (instruction-basic "Scan the QR, add the new code to start-game")
                               (instruction-basic (text-with-image "Type: " (codify "(quest-item-entity)")))
                               (instruction-basic "AFTER (instructions-entity)")
                               (instruction-goal "your new code in your project"))
                         (launcher-img add-item-to-start)))

(define test-backpack-system
  (activity-instructions "Test Backpack System"
                         '()
                         (list (instruction-basic "Run your code")     
                               (instruction-basic "Open/Close backpack with: b")
                               (instruction-basic "Store item with: z")
                               (instruction-basic "Drop item with: x")
                               (instruction-goal "your backpack system working in game"))
                         (scale-to-fit (local-bitmap "tsgd_backpack.png") 250 320 #:mode 'preserve))) ;TO-DO Change image

(define add-physics
  (activity-instructions "Add Physics to Item"
                         '()
                         (list (instruction-basic "Scan the QR, add the new code to (quest-item)")
                               (instruction-basic (text-with-image "Type: " (codify "(physical-collider)")))
                               (instruction-basic (text-with-image "Type: " (codify "(stop-on-edge)")))
                               (instruction-basic "AFTER (storable)")
                               (instruction-goal "your new code in your project"))
                         (launcher-img add-physics-to-item)))
  


(define change-spawn-tile
  (activity-instructions "Change Starting Tile"
                         '()
                         (list (instruction-basic "Scan the QR")
                               (instruction-basic "Edit the code in (quest-item)")
                               (instruction-basic "Change the 1 to a number between 0-8")
                               (instruction-basic (text-with-image "-> "(codify "(active-on-bg 1)")))
                               (instruction-goal "your new code in your project"))
                         (launcher-img change-item-tile)))

(define start-rand-tile
  (activity-instructions "Start on Random Tile"
                         '()
                         (list (instruction-basic "Scan the QR, add the new code to (quest-item)")
                               (instruction-basic (text-with-image "Type: " (codify "(active-on-random)")))
                               (instruction-basic "AFTER (respawn 'anywhere)")
                               (instruction-goal "your new code in your project"))
                         (launcher-img random-item-tile)))
  
(define change-item-image
  (activity-instructions "Change Item Sprite"
                         '()
                         (list (instruction-open "Piskel")
                               (instruction-basic "Paint your own Item")
                               (instruction-basic "Export and import your new item sprite.")
                               (instruction-goal "your completed texture."))
                         (launcher-img change-item-sprite)))
  
(define change-backpack-key-values
  (activity-instructions "Change Backpack Keys"
                         '()
                         (list (instruction-basic "Scan the QR, edit the (backpack-system) code")
                               (instruction-basic "You can change the keys to grab, drop an item, and open backpack.")
                               (instruction-goal "your new code in your project"))
                         (launcher-img change-backpack-keys)))

;------ End Quest 5 cards ---
(define day5-2dgame
  (list
   (with-award 0 add-backpack)
   (with-award 2 add-item-code)
   (with-award 1 add-item-ent-to-start)
   (with-award 1 test-backpack-system)   
   (with-award 2 add-physics)
   (choose "any"
           (list
            (with-award 1 change-spawn-tile)
            (with-award 1 start-rand-tile)
            (with-award 1 change-item-image)
            (with-award 1 change-backpack-key-values)
            ))
   ))

(define (quest5-full)
  (make-picts "red" "Q5-" day5-2dgame (settings (bg (local-bitmap "bg-arcade.png")) R-MUSH R-MUSH-BONUS R-MUSH-BONUS)))

(define (quest5)
  (map shrink
       (quest5-full)))

; ==== TEST 3x3 PNG for Printing ======
; includes inset and frame
#;(define large-3x3-png
    (cards->pages (map (curryr frame #:line-width 2)
                       (map (curryr inset 20)
                            (quest5-full)))))

;(save-out-materials "tsdg-quest5" (quest5-full))

;(map slide (make-picts "red" "Q5-" day5-2dgame (settings (bg (local-bitmap "bg-arcade.png")) R-MUSH R-MUSH-BONUS R-MUSH-BONUS)))



