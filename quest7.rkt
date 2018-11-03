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
(define (give-quest-code)
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

; === DEFINE IMAGE FILES ===
(define-image-file quest-giver-code images (p:scale (give-quest-code) 2))

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
;   (with-award 1 (add-npc-quest-component))
;   (with-award 1 (test-quest))
;   (with-award 1 (change-quest-dialog))
;   (with-award 1 (add-new-response))

;            (add-score-entity)
;            (add-quest-reward-rule)
;            (add-quest-reward)


(define day7-2dgame
  (list
   (with-award 1 (add-quest-giver))
   ;(with-award 1 (add-quest-complete-dialog))
   ;(with-award 1 (add-npc-quest-component))
   ;(with-award 1 (test-quest))
   ;(with-award 1 (change-quest-dialog))
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
