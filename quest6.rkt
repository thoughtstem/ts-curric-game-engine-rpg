#lang racket

(provide quest6)

(require ts-racket)
(require ts-curric-common)

(require (only-in game-engine draw-entity)
         (only-in game-engine-rpg wood-house stone-house)  )

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))


(require "./common.rkt")

(define house-img
  (draw-entity (wood-house)))

(define stone-house-img
  (draw-entity (stone-house)))

(define (pretty-frame i)
  (p:frame
   (p:inset i 10)))


(define (house-placer-worksheet-1)
  (define house-type (code-blank))
  (define p-x  (code-blank))
  (define p-y  (code-blank))
  (define bg-n (code-blank))
  
  (define code 
    (p:code (#,house-type
             (posn #,p-x
                   #,p-y)
              #:components
              (active-on-bg #,bg-n))))

   (code+hints code
               (list house-type
                     (hint
                      (p:vl-append 10
                                   (p:text "house type, e.g.")
                                   (p:hc-append 10
                                    (p:scale house-img 0.2)
                                    (p:code wood-house))
                                   (p:text "or")
                                   (p:hc-append 10
                                    (p:scale stone-house-img 0.2)
                                    (p:code stone-house))  )))
               (list p-x p-y
                     (hint
                      (p:hb-append 10
                                   (p:text "location, e.g.")
                                   (p:code 100))))
               (list bg-n
                     (hint 
                      (p:hb-append 10
                                   (p:text "tile number, e.g.")
                                   (p:code 1))))))


(define (house-placer-worksheet-2)
  (define house-type (code-blank))
  (define p  (code-blank))
  (define p2 (code-blank))
  (define b  (code-blank 200))
  
  (define code 
    (p:code (#,house-type
             (posn #,p
                   #,p2)
             #:components
             (#,b))))

  code
  
  ;no hints needed on the same page
   #;(code+hints code
               (list house-type
                     (hint "house type"))
               
               (list p
                     (hint
                      (p:hb-append 10
                                   (p:text "location, e.g.")
                                   (p:code (posn 100 200)))))
               
               (list b
                     (hint 
                      (p:hb-append 10
                                   (p:text "active-on-bg component, e.g.")
                                   (p:code (active-on-bg 3)))))))

(define (house-placer-worksheet-3)
  ;(define full (code-blank 170 150))
  (define house-type (code-blank))
  (define p  (code-blank 150))
  (define p2 (code-blank))
  (define c  (code-blank))
  (define b  (code-blank 200))
  
  (define code 
    (p:code (#,house-type
             (#,p
                     #,p2)
             #: #,c
             (#,b))))

  code

   #;(code+hints code
               (list full
                     (hint
                      (p:vl-append 10
                                   (p:text "All the code for your house here!")
                                   #;(p:code (wood-house
                                            (posn 200 50)
                                            #:components
                                            (active-on-bg 4))))))))

(define (house-placer-worksheet-4)
  (define full (code-blank 170 150))
  
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
     
                 (p:hc-append
                  (pretty-frame
                   (p:vc-append
                    (p:text "First house")
                    (house-placer-worksheet-1)))
                  (pretty-frame
                   (p:vc-append
                    44
                    (p:text "Second house")
                    (house-placer-worksheet-2)
                    (p:ghost (p:rectangle 1 1)))))
                             
                 (p:hc-append
                  (pretty-frame
                   (p:vc-append
                    35
                    (p:text "Third house")
                    (house-placer-worksheet-3)))
                  (pretty-frame
                   (p:vc-append
                    11
                    (p:text "Fourth house")
                    (house-placer-worksheet-4))))))
  (p:scale (p:inset sheet 20) 2))


#;(p:vl-append 20
               (p:text "Fifth house")
               (house-placer-worksheet-4)
               (p:text "Sixth house")
               (house-placer-worksheet-4))


(define (add-builder t)
  (activity-instructions (~a "Add " (string-titlecase t) " Builder Code")
                         '()
                         (list (instruction-basic "Scan the QR to see the code.")
                               (instruction-basic "Add the new code to the start-game function.")
                               (instruction-goal "the new code in your file."))
                         (image-qr "http://www.google.com"
                          ;add image of start-game and builder code
                          ;make image a parameter?
                          )))

(define (try-builder t)
  (define extra-instructions
    (if (eq? t "house")
        (list (instruction-basic "Go back to the code and change:")
              (instruction-basic (text-with-image (codify "wood-house") " to " (codify "stone-house"))))
        '()))
  (activity-instructions "Try the Builder"
                         '()
                         (append
                          (list (instruction-basic "Run your game.")
                                (instruction-basic (~a "Use the z key to create a " (string-downcase t)))
                                (instruction-basic (~a "Use the x key to place the " (string-downcase t))))
                          extra-instructions
                          (list (instruction-goal "your builder working in game!")))
                         (image-qr "http://www.google.com"
                          ;image of houses in game?
                          )))

(define use-worksheet
  (activity-instructions "Create Your Village"
                         '()
                         (list (instruction-basic "Place a house where you want it permanently.")
                               (instruction-basic "Use the information printed out in the interactions window to fill out the First House on your worksheet")
                               (instruction-basic "Place and note the locations of three additional houses.")
                               (instruction-goal "your completed worksheet."))
                         (video-qr "https://www.google.com"
                                   ;video here? Or image showing where in the interactions window is?
                                   )))

(define code-first-house
  (activity-instructions "Code your First House"
                         '()
                         (list (instruction-basic "Scan the QR to see example code.")
                               (instruction-basic "Add the code for your First House on your worksheet to start-game.")
                               (instruction-basic "Test your game!")
                               (instruction-goal "your house code in start-game."))
                         (video-qr "https://www.google.com"
                                   ;add image of first house code in start game
                                   )))

(define day6-2dgame
  (list
   ;card 1 -- add builder
   (with-award 2 (add-builder "House"))
   ;card 2 -- try builder (try with other house)
   (with-award 0 (try-builder "house"))
   ;card 3 -- worksheet
   (with-award 2 use-worksheet)
   ;4 -- put 1st in start-game
   (with-award 1 code-first-house)
   ;5 -- put rest in start-game
   ;6 -- remove builder??
   ;bonus cards
   ;6 -- add mini map
   ;7 -- add npc builder
   ;8 -- use builder to not loc of new npc
   ;9 -- add to start-game
   #;(choose "any"
           (list
            (with-award 1 (make-npc "follow"))
            (with-award 1 change-npc-speed)
            (with-award 2 draw-and-add-npc)))))

(define (quest-cards)
  (map shrink
       (make-picts "red" "Q6-" day6-2dgame (settings (bg (local-bitmap "bg-arcade.png")) LINK LINK-BONUS LINK-BONUS))))

(quest-cards)

(define (quest6)
  (append (quest-cards)
          (it-makes-a-village-worksheet)
          )
  )


