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
                                  "I did drop some coins though.")
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

(define (paste-new-response-img)
  (define new-code (p:frame (p:code
                             (define new-npc1-response
                               (list (list "It's Jordan! Did you forget again?"
                                           "Maybe you should write it down.")
                                     (list "Nope. I'm just practicing my lightsaber skills!"
                                           "Thanks again for finding it.")
                                     (list "Not right now. You've done enough for me."
                                           "Thank you!")))
                             code:blank
                             (define new-npc1-response-sprites
                               (dialog->response-sprites new-npc1-response
                                                         #:game-width WIDTH
                                                         #:animated #t
                                                         #:speed 4))) #:color "red"))                    
  (define the-code (p:code
                    (define npc1-response
                      (list (list "Oh, hello! My name is Jordan!"
                                  "You must be new around here."
                                  "Make sure to explore the area.")
                            (list "Nope. I'm just out for a walk."
                                  "I did drop some coins though.")
                            (list "Yes, I lost my lightsaber."
                                  "Can you help me find it?")
                            ))
                    code:blank
                    #,new-code
                    
                    code:blank
                    
                    (define npc1-response-sprites
                      (dialog->response-sprites npc1-response
                                                #:game-width WIDTH
                                                #:animated #t
                                                #:speed 4))
                    ))
  (code+hints the-code
              (list new-code
                    (hint (p:text "PASTE NEW CODE HERE")))))

(define (npc-response-img)
  (define new-code (p:frame (p:code
                             #:new-response-dialog   new-npc1-response-sprites) #:color "red"))
  (define the-code (p:code
                    (define (npc1-entity)
                      (create-npc #:sprite npc1-sprite
                                  #:name        "Jordan"
                                  #:position    (posn 300 200)
                                  #:active-tile (random 0 TOTAL-TILES)
                                  #:dialog      npc1-response-sprites
                                  #:mode        'pace
                                  #:components  (quest #:rule                  (in-backpack? "Lightsaber")
                                                       #:quest-complete-dialog quest-complete-dialog
                                                       #,new-code
                                                       code:blank
                                                       )))))
  (code+hints the-code
              (list new-code
                    (hint (p:text "TYPE NEW CODE HERE")))))

(define (score-entity-img)
  (define new-code (p:frame (p:code
                             (define (score-entity)
                               (sprite->entity (text "Gold: 0" 24 "yellow")
                                               #:name       "score"
                                               #:position   (posn 100 20)
                                               #:components (static)
                                               (counter 0)
                                               (detect-collide "player" "item" (do-many (change-counter-by 10)
                                                                                        (draw-counter "Gold: " 24 "yellow")))
                                               )) ) #:color "red"))
  
  (define new-code2 (p:frame (p:code
                              (score-entity)) #:color "red"))
  
  (define the-code (p:code
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
                    code:blank
                    #,new-code
                    code:blank
                    (code:comment " === RUN THE GAME ===")
                    (start-game (instructions-entity)
                                 #,new-code2
                                 (wood-house (posn 325 120)
                                             #:tile 3))
                                 ))
  
  (code+hints the-code
              (list new-code
                    (hint (p:text "PASTE NEW CODE HERE")))
              (list new-code2
                    (hint (p:text "TYPE NEW CODE HERE")))))

(define (quest-reward-img)
  (define new-code (p:frame (p:code
                             (quest-reward #:quest-giver "Jordan"
                                           #:quest-item  "Lightsaber"
                                           #:reward      200)) #:color "red"))
  (define the-code (p:code
                    (define (score-entity)
                      (sprite->entity (text "Gold: 0" 24 "yellow")
                                      #:name       "score"
                                      #:position   (posn 100 20)
                                      #:components (static)
                                      (counter 0)
                                      (detect-collide "player" "item" (do-many (change-counter-by 10)
                                                                               (draw-counter "Gold: " 24 "yellow")))
                                      #,new-code
                                      code:blank
                                      ))))
  (code+hints the-code
              (list new-code
                    (hint (p:text "TYPE NEW CODE HERE")))))

; === DEFINE IMAGE FILES ===
(define-image-file quest-giver-code    images (p:scale (give-quest-code-img) 1))
(define-image-file paste-quest-dialog  images (p:scale (paste-quest-dialog-img) 1))
(define-image-file npc-quest-code      images (p:scale (npc-quest-img) 1))
(define-image-file modify-quest-dialog images (p:scale (modify-quest-dialog-img) 1))
(define-image-file paste-new-response  images (p:scale (paste-new-response-img) 1))
(define-image-file npc-response        images (p:scale (npc-response-img) 1))
(define-image-file score-entity        images (p:scale (score-entity-img) 1))
(define-image-file quest-reward        images (p:scale (quest-reward-img) 1))

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
                               (instruction-basic "Launch the image to see where to paste the code")
                               (instruction-goal "your new code in your project"))
                         (launcher-img paste-new-response)))

;(with-award 1 add-score-entity)
(define (add-response-npc)
  (activity-instructions "Add Reponse to NPC"
                         '()
                         (list (instruction-basic "Launch the image to see where to type the code")
                               (instruction-goal "your new code in your project"))
                         (launcher-img npc-response)))

;(with-award 1 add-score-entity)
(define (add-score-entity)
   (activity-instructions "Add Score Entity"
                        '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (codify "tsgd_score")))
                               (instruction-basic "Launch the image to see where to paste the code")
                               (instruction-basic (text-with-image "Add this in start-game:" (p:scale (p:code (score-entity)) 2.5)))
                               (instruction-goal "your new code in your project"))
                         (launcher-img score-entity)))

; (with-award 1 add-quest-reward)
(define (add-quest-reward)
   (activity-instructions "Add Quest Reward"
                        '()
                         (list (instruction-basic "Launch the image to see where to type the code.")
                               (instruction-basic "Test your game and complete the game quest.")
                               (instruction-goal "the quest completed in game"))
                         (launcher-img quest-reward)))


(define day7-2dgame
  (list
   (with-award 1 (add-quest-giver))
   (with-award 1 (add-quest-complete-dialog))
   (with-award 1 (add-npc-quest-component))
   (with-award 1 (test-quest-system))
   (with-award 1 (change-quest-dialog))
   (with-award 0 (add-new-response))
   (with-award 1 (add-response-npc))
   (choose "any"
           (list
            (with-award 1 (add-score-entity))
            (with-award 1 (add-quest-reward))
            ))
   ))

(define (quest-cards)
  (map shrink
       (make-picts "red" "Q7-" day7-2dgame (settings (bg (local-bitmap "bg-arcade.png")) SAMUS SAMUS-BONUS SAMUS-BONUS))))

(define (quest7)
   (quest-cards))

(module+ test
  (quest7))
