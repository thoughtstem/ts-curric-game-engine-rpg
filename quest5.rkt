#lang slideshow

(provide quest5)

(require ts-curric-common)
(require "./common.rkt")
(require (except-in ts-racket
                    scale-to-fit))

;------ Start Quest 5 cards ---
(define add-backpack
  (activity-instructions "Add Backpack System"
                         '()
                         (list (instruction-basic "Scan the QR, add the new code to your player-entity")
                               (instruction-basic (text-with-image "Type: " (codify "(backpack-system)")))
                               (instruction-basic "AFTER (stop-on-edge)")
                               (instruction-goal "your new code in your project"))
                         (image-qr "http://bit.ly/2RKLtZ9")))
  
(define add-item-code
   (activity-instructions "Add Item Code"
                        '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (scale (codify "tsgd_quest_item") 1.5)))
                               (instruction-basic "Copy/Paste the Code BEFORE (define (instructions-entity)")
                               (instruction-goal "your new code in your project"))
                         (image-qr "http://bit.ly/2RMSsRw")))
  
(define add-item-to-start
   (activity-instructions "Add Item to start-game"
                        '()
                         (list (instruction-basic "Scan the QR, add the new code to start-game")
                               (instruction-basic (text-with-image "Type: " (codify "(quest-item-entity)")))
                               (instruction-basic "AFTER (instructions-entity)")
                               (instruction-goal "your new code in your project"))
                         (image-qr "http://bit.ly/2EkDvDl")))

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
                         (image-qr "http://bit.ly/2ITyiky")))
  


(define change-spawn-tile
   (activity-instructions "Change Starting Tile"
                         '()
                         (list (instruction-basic "Scan the QR")
                               (instruction-basic "Edit the code in (quest-item)")
                               (instruction-basic "Change the 0 to a number between 0-8")
                               (instruction-basic (text-with-image "-> "(codify "(active-on-bg 0)")))
                               (instruction-goal "your new code in your project"))
                         (image-qr "http://bit.ly/2CcSSuT")))

(define start-rand-tile
   (activity-instructions "Start on Random Tile"
                         '()
                         (list (instruction-basic "Scan the QR, add the new code to (quest-item)")
                               (instruction-basic (text-with-image "Type: " (codify "(active-on-random)")))
                               (instruction-basic "AFTER (respawn 'anywhere)")
                               (instruction-goal "your new code in your project"))
                         (image-qr "http://bit.ly/2NFgpGO")))
  
(define change-item-image
   (activity-instructions "Change Item Sprite"
                         '()
                         (list (instruction-open "Piskel")
                               (instruction-basic "Paint your own Item")
                               (instruction-basic "Export and import your new item sprite.")
                               (instruction-goal "your completed texture."))
                         (image-qr "http://bit.ly/2ywhonk")))
  
(define change-backpack-keys
   (activity-instructions "Change Backpack Keys"
                         '()
                         (list (instruction-basic "Scan the QR, edit the (backpack-system) code")
                               (instruction-basic "You can change the keys to grab, drop an item, and open backpack.")
                               (instruction-goal "your new code in your project"))
                         (image-qr "http://bit.ly/2PwBa9F")))

;------ End Quest 5 cards ---
(define day5-2dgame
  (list
   (with-award 0 add-backpack)
   (with-award 2 add-item-code)
   (with-award 1 add-item-to-start)
   (with-award 1 test-backpack-system)   
   (with-award 2 add-physics)
   ;(with-award 0 add-mini-map)
   (choose "any"
           (list
            (with-award 1 change-spawn-tile)
            (with-award 1 start-rand-tile)
            (with-award 1 change-item-image)
            (with-award 1 change-backpack-keys)
           ))
   ))

(define (quest5-full)
  (make-picts "red" "Q5-" day5-2dgame (settings (bg (local-bitmap "bg-arcade.png")) R-MUSH R-MUSH-BONUS R-MUSH-BONUS)))

(define (quest5)
  (map shrink
       (quest5-full)))

; ==== TEST 3x3 PNG for Printing ======
; includes inset and frame
(define large-3x3-png
  (cards->pages (map (curryr frame #:line-width 2)
                   (map (curryr inset 20)
                        (quest5-full)))))

;(save-out-materials "tsdg-quest5" (quest5-full))

;(map slide (make-picts "red" "Q5-" day5-2dgame (settings (bg (local-bitmap "bg-arcade.png")) R-MUSH R-MUSH-BONUS R-MUSH-BONUS)))



