#lang slideshow

;High level goals:
#;(

   Title: Dialog and NPC Mode 

          Main goal: Edit the Player's and NPC Dialog
          * Change the Player's Dialog
          * Change the NPC's Dialog
          * Change the NPC's mode
      
          Stretch goals: Edit the NPC
          * Change the NPC's mode again
          * Change the NPC's speed
          * Re-design the NPC's sprite, and replace the new one in your code
      
          ======

          Quest-complete goals:  

          Mastery level 1:  TBD

          Mastery level 2:  TBD
      
          )

(provide quest4)

(require ts-curric-common)
(require ts-racket)

(require "./common.rkt")
(require (prefix-in p: pict/code))
(require (prefix-in p: pict))

(require (only-in game-engine draw-entity)
         (only-in game-engine-rpg player npc)  )

(require racket/runtime-path)
(define-runtime-path images "images")

(define player-sprite
  (draw-entity (player)))

(define npc-sprite
  (draw-entity (npc)))


(define (cards-1-4-a)
  (define card2  (p:frame (p:code "Hey, What's up?"
                                  "Are you lost or something?") #:color "red"))
  (define card4a (p:frame (p:code "New Dialog Option 1"
                                  "New Dialog Option 2") #:color "red"))
  
  (define code-a 
    (p:code (code:comment " === GAME DIALOG === ")
            (define player-dialog
              (list #,card2
                    #,card4a ))
            code:blank ))

  (code+hints #:settings hints-on-top code-a
              (list card4a
                    (hint (p:text "Card 4 - New Player Dialog")))
              (list card2
                    (hint (p:text "Card 2 - Custom Player Dialog")))
              ))

(define (cards-1-4-b)
  (define card3 (p:frame (p:code (list "Oh, not much! I'm Jordan by the way."
                                       "You must be the new guy in town."
                                       "Take some time and look around!")
                                 (list "No, I'm just out for a jog."
                                       "I did drop dome rare gold coins.\nPlease find them for me."))
                         #:color "red"))
  
  (define card4b (p:frame (p:code (list "NEW RESPONSE 1"
                                        "NEXT PAGE")
                                  (list "NEW RESPONSE 2"
                                        "NEXT PAGE"
                                        "NEXT PAGE"))
                          #:color "red"))
  
  (define code-b
    (p:code
     code:blank
     (code:comment " Responses must have the same number of lists as items in the player-dialog")
     (define npc1-response
       (list #,card3
             #,card4b))))
  
  (code+hints #:settings hints-on-bottom code-b
              (list card4b
                    (hint (p:text "Card 4 - New NPC Responses")))
              (list card3
                    (hint (p:text "Card 3 - Custom NPC Dialog")))
              ))

(define (cards-5-7)
  (define cards-5-6-7 (p:frame (p:code 'pace)
                               #:color "red"))
  
  (define card8 (p:frame (p:code #:speed        10)
                         #:color "red"))
  
  (define code (p:code (define (npc1-entity)
                         (create-npc #:sprite      npc1-sprite
                                     #:name        "Jordan"
                                     #:position    (posn 300 200)
                                     #:active-tile (random 0 TOTAL-TILES)
                                     #:dialog      npc1-response-sprites
                                     #,card8
                                     #:mode        #,cards-5-6-7))
                         ))
  
  (code+hints code #:settings hints-on-bottom
              (list card8
                    (hint (p:text "Card 8")))
              (list cards-5-6-7
                    (hint
                     (p:vl-append 10
                                  (p:text "Cards 5 - 7 Options:")
                                  (p:hc-append (p:code 'wander
                                                       'still
                                                       'follow)))))
              ))

(define (new-dialog-worksheet)
  (define sheet
    (p:vc-append 20
                 (p:hc-append 20
                              (p:scale player-sprite 1.5)
                              (p:scale (p:text "Dialog Hints Sheet") 2)
                              npc-sprite)
     
                 (inset-frame
                  (p:vc-append
                   (p:text "Cards 1 - 4 Completed")
                   (p:text "")
                   (cards-1-4-a)
                   (cards-1-4-b)))
                 
                 (inset-frame
                    (p:vc-append
                     30
                     (p:text "Cards 5 - 7 Completed")
                     (cards-5-7)
                     ))))
  (p:scale (p:inset sheet 20) 2))


;Change Dialog, Add Dialog, Change NPC Mode / Customize your npc
(define day4-2dgame
  (list
   (with-award 0 open-file)
   (with-award 2 change-player-dialog)
   (with-award 2 change-npc-dialog)
   (with-award 2 add-new-dialog)
   (with-award 1 (make-npc "wander"))
   (with-award 1 (make-npc "still"))
   (choose "any"
           (list
            (with-award 1 (make-npc "follow"))
            (with-award 1 change-npc-speed)
            (with-award 2 draw-and-add-npc)))))


(define (quest-cards)
  (map shrink
       (make-picts "red" "Q4-" day4-2dgame (settings (bg (local-bitmap "bg-arcade.png")) STAR STAR-BONUS STAR-BONUS)))
  )

(define (quest4)
  (append (quest-cards)
          (list (p:rb-superimpose
                 (new-dialog-worksheet)
                 (p:scale
                  (p:text "Quest 4")
                  3)))))

;(map slide ;(make-picts "red" "Q4-" day4-2dgame (settings (bg (local-bitmap "bg-arcade.png")) STAR STAR-BONUS STAR-BONUS)))
