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
  (define p  (code-blank 150))
  (define b  (code-blank 150))
  
  (define code 
    (p:code (#,house-type
             #,p
             #:components
             #,b)))

   (code+hints code
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
  (define full (code-blank 170 150))
  
  (define code 
    (p:code #,full))

   (code+hints code
               (list full
                     (hint
                      (p:vl-append 10
                                   (p:text "All the code for your house, e.g.")
                                   (p:code (wood-house
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
                                        (p:text "All the code for your house...")
                                        (p:text "(Can you do it without looking?)"))))))

(define (it-makes-a-village-worksheets)
  (define sheets
    (list
     (p:vl-append 20
                  (p:hc-append 20
                               (p:scale house-img 0.75)
                               (p:scale (p:text "It Makes a Village!") 2)
                               (p:scale house-img 0.75))
                  (p:text "First house")
                  (house-placer-worksheet-1)
                  (p:text "Second house")
                  (house-placer-worksheet-2))
     (p:vl-append 20
                  (p:text "Third house")
                  (house-placer-worksheet-3)
                  (p:text "Fourth house")
                  (house-placer-worksheet-4))
     (p:vl-append 20
                  (p:text "Fifth house")
                  (house-placer-worksheet-4)
                  (p:text "Sixth house")
                  (house-placer-worksheet-4))))

  (map p:frame
       (map (curryr p:scale 2)
            sheets)))


;TODO: Change this.  It's copied from quest4...
(define day6-2dgame
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
       (make-picts "red" "Q2-" day6-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))

(define (quest6)
  (append (quest-cards)
          (it-makes-a-village-worksheets)
          )
  )


