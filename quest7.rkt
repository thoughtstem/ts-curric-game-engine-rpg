#lang racket

(provide quest7)

(require ts-racket)
(require ts-curric-common)

(require (only-in game-engine draw-entity)
         (only-in game-engine-rpg wood-house stone-house)  )

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)

(define-runtime-path images "images")


(require "./common.rkt")

; ===== QUEST 7 CARDS =====
(define (give-quest-code-img)
  (define player-dialog (p:frame (p:code
                                  "Do you have any quests for me?") #:color "red"))
  (define npc-dialog (p:frame (p:code
                               (list "Yes, I lost my lightsaber."
                                     "Can you help me find it?" )) #:color "red"))
  (define the-code (p:code
                    (define player-dialog
                      (list "Hello. What's your name?"
                            "Are you lost?"
                            #,player-dialog
                            code:blank
                            ))
                    
                    code:blank
                    (define npc1-response
                      (list (list "Oh, hello! My name is Jordan!"
                                  "You must be new around here."
                                  "Make sure to explore the area.")
                            (list "Nope. I'm just out for a walk."
                                  "I did drop some coins though.\nPlease keep an eye out for them.")
                            #,npc-dialog
                            code:blank
                            ))))
  (code+hints the-code
              (list player-dialog
                    (hint (p:text "NEW")))
              (list npc-dialog
                    (hint (p:text "NEW")))))

(define (paste-quest-dialog-img)
  (define new-code (p:frame (p:code
                             (define quest-complete-dialog
                               (dialog->sprites (list "You found my lightsaber!"
                                                      "Thank you!"
                                                      "Here's 200 gold!")
                                                #:game-width WIDTH
                                                #:speed 4))) #:color "red"))                    
  (define the-code (p:code
                    (define npc1-response-sprites
                      (dialog->response-sprites npc1-response
                                                #:game-width WIDTH
                                                #:animated #t
                                                #:speed 4))
                    code:blank
                    #,new-code
                    
                    code:blank
                    (code:comment " === ENTITY DEFINITIONS ===")
                    ))
  (code+hints the-code
              (list new-code
                    (hint (p:text "PASTE NEW CODE HERE")))))

(define (npc-quest-img)
  (define new-code (p:frame (p:code
                             #:components  (quest #:rule                  (in-backpack? "Lightsaber")
                                                  #:quest-complete-dialog quest-complete-dialog
                                                  )) #:color "red"))
  (define the-code (p:code
                    (define (npc1-entity)
                      (create-npc #:sprite npc1-sprite
                                  #:name        "Jordan"
                                  #:position    (posn 300 200)
                                  #:active-tile (random 0 TOTAL-TILES)
                                  #:dialog      npc1-response-sprites
                                  #:mode        'pace
                                  #,new-code
                                  code:blank
                                  ))))
  (code+hints the-code
              (list new-code
                    (hint (p:text "TYPE NEW CODE HERE")))))

(define (modify-quest-dialog-img)
  (define player-dialog (p:frame (p:code
                                  "Do you have any quests for me?") #:color "red"))
  (define npc-dialog (p:frame (p:code
                               (list "Yes, I lost my lightsaber."
                                     "Can you help me find it?" )) #:color "red"))
  (define quest-dialog (p:frame (p:code
                                 (list "You found my lightsaber!"
                                       "Thank you!"
                                       "Here's 200 gold!")) #:color "red"))
  (define the-code (p:code
                    (code:comment " === GAME DIALOG ===")
                    (define player-dialog
                      (list "Hello. What's your name?"
                            "Are you lost?"
                            #,player-dialog
                            code:blank
                            ))
                    
                    code:blank
                    (define npc1-response
                      (list (list "Oh, hello! My name is Jordan!"
                                  "You must be new around here."
                                  "Make sure to explore the area.")
                            (list "Nope. I'm just out for a walk."
                                  "I did drop some coins though.")
                            #,npc-dialog
                            code:blank
                            ))
                    
                    code:blank
                    (define quest-complete-dialog
                      (dialog->sprites #,quest-dialog
                                       #:game-width WIDTH
                                       #:speed 4))))
  (code+hints the-code
              (list player-dialog (hint (p:text "MODIFY THIS")))
              (list npc-dialog    (hint (p:text "MODIFY THIS")))
              (list quest-dialog (hint (p:text "MODIFY THIS")))))

; === DEFINE IMAGE FILES ===
(define-image-file quest-giver-code    images (p:scale (give-quest-code-img) 1.5))
(define-image-file paste-quest-dialog  images (p:scale (paste-quest-dialog-img) 1.5))
(define-image-file npc-quest-code      images (p:scale (npc-quest-img) 1.5))
(define-image-file modify-quest-dialog images (p:scale (modify-quest-dialog-img) 1.5))

;(with-award 1 (add-quest-giver))
(define (add-quest-giver)
  (activity-instructions (~a "Add Quest Dialog")
                         '()
                         (list (instruction-basic "Use the launcher to see the code.")
                               (instruction-basic "Add the new lines to both player-dialog and npc1-response.")
                               (instruction-goal "the new code in your file."))
                         (launcher-img quest-giver-code)
                         ))

;   (with-award 1 (add-quest-complete-dialog))

(define (add-quest-complete-dialog)
   (activity-instructions "Add Quest Complete Dialog"
                        '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (codify "tsgd_quest_complete_dialog")))
                               (instruction-basic "Copy/Paste the Code BEFORE the entity definitions")
                               (instruction-goal "your new code in your project"))
                         (launcher-img paste-quest-dialog)))

;   (with-award 1 (add-npc-quest-component))
(define (add-npc-quest-component)
   (activity-instructions "Add NPC Quest Component"
                        '()
                         (list (instruction-basic "Find (define (npc1-entity) ...")
                               (instruction-basic "Use the launcher and type the new code.")
                               (instruction-goal "your new code in your project"))
                         (launcher-img npc-quest-code)))

;   (with-award 1 (test-quest))
(define (test-quest-system)
   (activity-instructions "Test Quest System"
                         '()
                         (list (instruction-basic "Run your code.")     
                               (instruction-basic "Talk to the quest giver to get the quest.")
                               (instruction-basic "Find the Lightsaber and drop it in front of the npc to complete the quest.")
                               (instruction-goal "your quest system working in game"))
                         (p:scale-to-fit (local-bitmap "quest7_test.png") 250 320 #:mode 'preserve)))

;   (with-award 1 (change-quest-dialog))
(define (change-quest-dialog)
  (activity-instructions "Change the Quest Dialog"
                         '()
                         (list (instruction-basic "Find the quest dialog and modify the words to make them your own.")
                               (instruction-basic "Be creative and make sure the dialog fits your game style.")
                               (instruction-goal  "your customized quest dialog."))
                         (launcher-img modify-quest-dialog)))

;   (with-award 1 (add-new-response))
(define (add-new-response)
   (activity-instructions "Add New Reponse Dialog"
                        '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (codify "tsgd_new_response")))
                               (instruction-basic "Copy/Paste the Code BEFORE ...")
                               (instruction-goal "your new code in your project"))
                         (launcher-img paste-quest-dialog)))

;            (add-score-entity)
;            (add-quest-reward-rule)
;            (add-quest-reward)


(define day7-2dgame
  (list
   (with-award 1 (add-quest-giver))
   (with-award 1 (add-quest-complete-dialog))
   (with-award 1 (add-npc-quest-component))
   (with-award 1 (test-quest-system))
   (with-award 1 (change-quest-dialog))
   ;(with-award 1 (add-new-response))
   (choose "any"
           (list
   ;         (add-score-entity)
   ;         (add-quest-reward-rule)
   ;         (add-quest-reward)
            ))
   ))

(define (quest-cards)
  (map shrink
       (make-picts "red" "Q7-" day7-2dgame (settings (bg (local-bitmap "bg-arcade.png")) SAMUS SAMUS-BONUS SAMUS-BONUS))))

(define (quest7)
   (quest-cards))

(module+ test
  (quest7))
