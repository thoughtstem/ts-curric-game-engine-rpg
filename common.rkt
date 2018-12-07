#lang slideshow

(provide shrink
         open-racket-only
         google-form
         draw-sprite-style
         export-from-piskel
         save-as
         replace-sheet
         local-bitmap
         draw-sprite
         open-file
         test-game
         import-to-piskel
         redesign-sprite
         change-player-position
         change-starting-tile
         animate
         export-sprite-sheet
         import-sprite-sheet
         change-player-dialog
         change-npc-dialog
         add-new-dialog
         make-npc
         change-npc-speed
         draw-and-add-npc
         add-builder
         remove-builder

         replace-sprite-video
         
         MARIO        
         MARIO-BONUS  
         PACMAN       
         PACMAN-BONUS
         G-MUSH       
         G-MUSH-BONUS 
         R-MUSH      
         R-MUSH-BONUS 
         STAR         
         STAR-BONUS  
         LINK       
         LINK-BONUS   
         SAMUS       
         SAMUS-BONUS
         PIKACHU          
         PIKACHU-BONUS   
         CHARMANDER     
         CHARMANDER-BONUS
         SQUIRTLE       
         SQUIRTLE-BONUS
         YOSHI        
         YOSHI-BONUS 
         SONIC      
         SONIC-BONUS)



(require pict/code)
(require ts-curric-common
         (only-in ts-racket x-out code+hints hint))

(require racket/runtime-path)
(define-runtime-path images "images")
(define-runtime-path starter-files "starter-files")
(define-runtime-path this-curriculum ".")

(define (local-avatar s)
  (avatar (~a (path->string images) "/" s)))

(define (local-bitmap s)
  (bitmap (~a (path->string images) "/" s)))


(define MARIO        (circlify "blue" (local-avatar "mario")))
(define MARIO-BONUS  (circlify "red" (local-avatar "mario")))
(define PACMAN       (circlify "blue" (local-avatar "pacman")))
(define PACMAN-BONUS (circlify "red" (local-avatar "pacman")))
(define G-MUSH       (circlify "blue" (local-avatar "greenMushroom")))
(define G-MUSH-BONUS (circlify "red" (local-avatar "greenMushroom")))
(define R-MUSH       (circlify "blue" (local-avatar "redMushroom")))
(define R-MUSH-BONUS (circlify "red" (local-avatar "redMushroom")))
(define STAR         (circlify "blue" (local-avatar "star")))
(define STAR-BONUS   (circlify "red" (local-avatar "star")))
(define LINK         (circlify "blue" (local-avatar "link")))
(define LINK-BONUS   (circlify "red" (local-avatar "link")))
(define SAMUS        (circlify "blue" (local-avatar "samus")))
(define SAMUS-BONUS  (circlify "red" (local-avatar "samus")))
(define PIKACHU          (circlify "blue" (local-avatar "pikachu")))
(define PIKACHU-BONUS    (circlify "red" (local-avatar "pikachu")))
(define CHARMANDER       (circlify "blue" (local-avatar "charmander")))
(define CHARMANDER-BONUS (circlify "red" (local-avatar "charmander")))
(define SQUIRTLE         (circlify "blue" (local-avatar "squirtle")))
(define SQUIRTLE-BONUS   (circlify "red" (local-avatar "squirtle")))
(define YOSHI         (circlify "blue" (local-avatar "yoshi")))
(define YOSHI-BONUS   (circlify "red" (local-avatar "yoshi")))
(define SONIC         (circlify "blue" (local-avatar "sonic")))
(define SONIC-BONUS   (circlify "red" (local-avatar "sonic")))

;==== starter file launch codes ====

(define-starter-code rpg1-starter
  starter-files
  "tsgd_style_1.rkt")

(define-starter-code rpg2-starter
  starter-files
  "tsgd_style_2.rkt")

(define-starter-code rpg3-starter
  starter-files
  "tsgd_style_3.rkt")

(define-starter-code rpg4-starter
  starter-files
  "tsgd_style_4.rkt")

;==== complete file launch codes ====

(define-starter-code q1-complete
  starter-files
  "tsgd_style_1.rkt")

(define-starter-code q2-complete
  starter-files
  "tsgd_style_1.rkt")

(define-starter-code q3-complete
  starter-files
  "tsgd_style_1.rkt")

(define-starter-code q4-complete
  starter-files
  "tsgd_adventure_quest4_complete.rkt")

(define-starter-code q5-complete
  starter-files
  "tsgd_adventure_quest5_complete.rkt")

(define-starter-code q6-complete
  starter-files
  "tsgd_adventure_quest6_complete.rkt")

(define-starter-code q7-complete
  starter-files
  "tsgd_adventure_quest7_complete.rkt")


(define (scan-badge num)
  (activity-instructions (++ "Quest " num ": Scan Your Badge")
                         '()
                         (list (instruction-open "Learn")
                               (instruction-basic "Scan your badge.")
                               (instruction-goal "the welcome page."))
                         (video-qr "http://bit.ly/2BAMXvY")))

(define start-folders
  (activity-instructions "Check SAVE_MY_WORK"
                         '()
                         (list
                          (instruction-open "File Manager")
                          (instruction-basic "Create all the folders that you don't have from the list:")
                          (instruction-folder "Desktop/SAVE_MY_WORK/"))
                         (video-qr "http://bit.ly/2CoFWPL")))

(define-webpage racket-basics-video
  this-curriculum
  "http://bit.ly/2HV5yHn")

(define-webpage replace-sprite-video
  this-curriculum
  "http://bit.ly/2FTnKD7")

(define open-racket-only
  (activity-instructions "DrRacket Basics"
                         '()
                         (list (instruction-basic "Load the video to learn the simple tools in DrRacket.")
                               (instruction-goal "the blank file in DrRacket."))
                         (launcher-img racket-basics-video)))

(define (open-racket action)
  (activity-instructions (cond
                           [(eq? action "save") "Open DrRacket and Save File"]
                           [(eq? action "load") "Open DrRacket and Open File"])
                         '()
                         (list (instruction-open "DrRacket")
                               (cond
                                 [(eq? action "save") (instruction-basic "Save your blank file, make sure to add '.rkt' at the end.")]
                                 [(eq? action "load") (instruction-basic "Open your racket file from:")])
                               (instruction-folder "Desktop/SAVE_MY_WORK")
                               (instruction-goal "your racket file opened."))
                         (video-qr "http://bit.ly/2HV5yHn")))

(define-webpage open-file-video
  this-curriculum
  "https://bit.ly/2Pnv27J")

(define open-file
  (activity-instructions "Open Your File"
                         '()
                         (list (instruction-open "DrRacket")
                               (instruction-basic "Go to File > Open, navigate to SAVE_MY_WORK")
                               (instruction-basic "Double-click your .rkt file")
                               (instruction-goal "your file open in DrRacket."))
                         (scale-to-fit (local-bitmap "open-file.png") 250 250 #:mode 'preserve)))

(define (demo-code action version goal)
  (activity-instructions "Test the Game"
                         '()
                         (list (instruction-basic "Type in the following code:")
                               (instruction-basic (codify "#lang racket"))
                               (instruction-basic (codify "(require spaceship-game-demo)"))
                               (instruction-basic (codify (++ "(" action "-spaceship " version ")")))
                               (instruction-basic "Run the code.")
                               (instruction-goal  goal))
                         (scale-to-fit (local-bitmap "click_run.png") 250 250 #:mode 'preserve)))

(define (demo-code-more endGame imgStr)
  (activity-instructions (++ "Test Games 2 through " endGame)

                         '()
                         (list (instruction-basic "In the last line of your code, change '1' to '2'.")
                               (instruction-basic "Run the code and test game.")
                               (instruction-basic "Change the number '2' to a '3', and test that game.")
                               (instruction-basic (++ "Continue until number " endGame "."))
                               (instruction-goal  "your game window running."))
                         (scale-to-fit (local-bitmap imgStr) 250 250 #:mode 'preserve)))


(define (google-form webpage)
  (activity-instructions "Open the Game Review"
                         '()
                         (list (instruction-basic "Load the Game Review.")
                               (instruction-basic "Answer the questions about the demo games.")
                               (instruction-goal "your Google Form submitted."))
                         (launcher-img webpage)))

;(define open-piskel
;  (activity-instructions "Open Piskel"
;                         '()
;                         (list (instruction-open "Piskel")
;                               (instruction-goal "Piskel and demonstrate one tool."))
;                         (video-qr "http://bit.ly/2nqVGPc")))

(define (draw-sprite image sprite)
  (activity-instructions (++ "Draw Your " (string-titlecase sprite))
                         '()
                         (list (instruction-open "Piskel")
                               (instruction-basic (++ "Paint a " (string-downcase sprite) " for your game."))
                               (instruction-goal "your completed texture."))
                         (scale (local-bitmap image) 2.0)))

(define (draw-sprite-style image sprite)
  (activity-instructions (++ "Draw Your " (string-titlecase sprite))
                         '()
                         (list (instruction-open "Piskel")
                               (instruction-basic (++ "Paint a " (string-downcase sprite) " that matches your favorite style."))
                               (instruction-goal "your completed texture."))
                         (scale (local-bitmap image) 2.0)))

(define export-from-piskel
  (activity-instructions "Export the Texture"
                         '()
                         (list (instruction-basic "Export from Piskel to SAVE_MY_WORK.")
                               (instruction-basic "Make sure the file name ends in '.png'")
                               (instruction-goal "your exported file."))
                         (scale-to-fit (local-bitmap "piskel_export.png") 400 350 #:mode 'preserve)))


(define (import-to-piskel sprite)
  (activity-instructions (++ "Import Your " (string-titlecase sprite))
                         '()
                         (list
                          (instruction-open "Piskel")
                          (instruction-basic "Click on the Import icon.")
                          (instruction-basic (++ "Select 'Browse Images' and look for your image."))
                          (instruction-goal "your image imported into piskel."))
                        (scale (local-bitmap "piskel-import.png") 0.7)))

(define (open-browse-curriculum url module)
  (activity-instructions "Open the Curriculum Page"
                         '()
                         (list (instruction-basic "Scan the QR to open the page.")
                               (instruction-basic (++ "Click on " module))
                               (instruction-goal "the correct Module opened."))
                         (search-qr url)))

(define (download-image video)
  (activity-instructions "Choose an Image and Save It"
                         '()
                         (list
                          (instruction-basic "Choose an image.")
                          (instruction-basic "Right click the image and 'Save image as...'")
                          (instruction-basic "Save it in SAVE_MY_WORK.")
                          (instruction-goal "your image saved in the folder."))
                         (video-qr video)))

(define (copy-output-code video)
  (activity-instructions "Copy the Output Code"
                         '()
                         (list
                          (instruction-basic "Highlight the code from the output.")
                          (instruction-basic "Delete everything in your file, and paste it.")
                          (instruction-basic "Save your file.")
                          (instruction-goal "your new code in the file."))
                         (video-qr video)))

(define (insert-image video old-code)
  (activity-instructions "Insert Your Sprite"
                         '()
                         (list
                          (instruction-basic "Delete the part that says: ")
                          (instruction-basic (codify old-code))
                          (instruction-basic "Go to 'Insert' menu and select 'Insert Image...'")
                          (instruction-basic "Find your sprite image and select 'Open'")
                          (instruction-basic "Run your code!")
                          (instruction-goal "your sprite in the code."))
                         (video-qr video)))

(define test-game
  (activity-instructions "Test the Game"
                         '()
                         (list
                          (instruction-basic "Save your code.")
                          (instruction-basic "Click 'Run' to test the game.")
                          (instruction-goal "your new changes running in game."))
                        (scale-to-fit (local-bitmap "click_run.png") 250 250 #:mode 'preserve)))

(define (another-sprite url)
  (activity-instructions "Use Another Sprite"
                         '()
                         (list
                          (instruction-basic "Scan the QR to open a website.")
                          (instruction-basic "Choose an image and save it.")
                          (instruction-basic "Insert it in your code.")
                          (instruction-goal "your new changes running in game."))
                        (search-qr url)))

(define (redesign-sprite webpage)
  (activity-instructions "Re-design Your Sprite"
                         '()
                         (list
                          (instruction-basic "Change the colors, add more to it!")
                          (instruction-basic "Export it from Piskel and insert this new image in your code.")
                          (instruction-goal "your new changes running in game."))
                        (launcher-img webpage)))

(define (replace-sprite url)
  (activity-instructions "Replace Your Sprite"
                         '()
                         (list
                          (instruction-basic "In the code look for the old image and delete it.")
                          (instruction-basic "Go to 'Insert' menu and select 'Insert Image...'")
                          (instruction-basic "Find your sprite image and select 'Open'")
                          (instruction-goal "your sprite in the code."))
                        (video-qr url)))

(define (replace-sheet webpage)
  (activity-instructions "Replace Your Sprite"
                         '()
                         (list
                          (instruction-basic "Find and delete the old sprite.")
                          (instruction-basic "Go to 'Insert' menu and select 'Insert Image...'")
                          (instruction-basic "Find your image and select 'Open'")
                          (instruction-basic "Change rows, columns, and row-number to 1")
                          (instruction-goal "your sprite in the code."))
                        (launcher-img webpage)))


(define-webpage magic-load
  this-curriculum
  "http://bit.ly/2Q2yKAh")

(define-starter-code style1-starter
  starter-files
  "tsgd_style_1.rkt")

(define-starter-code style2-starter
  starter-files
  "tsgd_style_2.rkt")

(define-starter-code style3-starter
  starter-files
  "tsgd_style_3.rkt")

(define-starter-code style4-starter
  starter-files
  "tsgd_style_4.rkt")

(define-starter-code quest-item
  starter-files
  "tsgd_quest_item.rkt")

(define-starter-code complete-dialog
  starter-files
  "tsgd_quest_complete_dialog.rkt")

(define-starter-code new-response
  starter-files
  "tsgd_new_response.rkt")

(define-starter-code score
  starter-files
  "tsgd_score.rkt")


(define (load-code-more endGame imgStr)
  (activity-instructions (++ "Test Games 2 Through " endGame)
                         '()
                         (list (instruction-basic "Click the TS Magic Loader again.")
                               (instruction-basic (text-with-image "In the text field, type:" (codify "tsgd_style_2")))
                               (instruction-basic "Run the code and test game.")
                               (instruction-basic (++ "Continue until demo " endGame "."))
                               (instruction-goal  "your game window running."))
                         (scale-to-fit (local-bitmap imgStr) 250 250 #:mode 'preserve)))

(define-webpage save-file-as
  this-curriculum
  "http://bit.ly/2ImsLCl")

(define save-as
  (activity-instructions "Save the File"
                         '()
                         (list (instruction-basic "Click 'File' and select 'Save Definitions As'")
                               (instruction-basic "Rename the file, make sure to keep the '.rkt' at the end!")
                               (instruction-goal  "your renamed and saved file."))
                         (launcher-img save-file-as)))

(define (change-position url)
  (activity-instructions "Change the Start Position"
                         '()
                         (list                        
                          (instruction-basic "Find your collectible's posn values at the bottom.")
                          (instruction-basic "Make your collectible start far away.")
                          (instruction-basic "TIP: (posn 0 0) is the top left corner.")
                          (instruction-goal "your collectible starting far away in game."))
                        (video-qr url)))

(define (change-player-position)
  (activity-instructions "Change the Player Position"
                         '()
                         (list                        
                          (instruction-basic "Find the player's posn values in the player-entity definition.")
                          (instruction-basic "Make the player start in the middle of the screen.")
                          (instruction-basic "TIP: (posn 0 0) is the top left corner.")
                          (instruction-goal "the player starting in the center."))
                        (scale-to-fit (local-bitmap "tsgd_posn.png") 300 300 #:mode 'preserve)))

(define (change-starting-tile)
  (activity-instructions "Change the Starting Tile"
                         '()
                         (list                        
                          (instruction-basic "Find the backdrop component at the top.")
                          (instruction-basic "Change start-tile to the center tile.")
                          (instruction-basic "TIP: tiles are numbered 0 - 8 from top left to bottom right.")
                          (instruction-goal "your player starting on the center tile."))
                        (scale-to-fit (local-bitmap "tsgd_tiles.png") 300 300 #:mode 'preserve)))

(define (add-more-collectibles url)
  (activity-instructions "Add More Collectibles"
                         '()
                         (list                        
                          (instruction-basic "Find the item-entity code inside start-game")
                          (instruction-basic "Select and copy it with CTRL+C.")
                          (instruction-basic "Make a new line and paste it with CTRL+V.")
                          (instruction-basic "The position and tile will be random.")
                          (instruction-goal "your game with multiple collectibles."))
                        (video-qr url)))

(define-webpage animate-sprite
  this-curriculum
  "http://bit.ly/2DLfNKP")

(define (animate sprite)
  (activity-instructions (++ "Animate Your " (string-titlecase sprite))
                         '()
                         (list (instruction-basic (++ "Duplicate and change frames in Piskel to animate your " (string-downcase sprite)))
                               (instruction-goal (++ "your animated " (string-downcase sprite) " in Piskel.")))
                         (launcher-img animate-sprite)))

(define-webpage piskel-export-sheet
  this-curriculum
  "http://bit.ly/2HSkJQN")

(define export-sprite-sheet
  (activity-instructions "Export Your Sprite Sheet"
                         '()
                         (list (instruction-basic "Click Export and PNG")
                               (instruction-basic "Change the number of COLUMNS to match the number of frames you have.")
                               (instruction-basic "Export the image to your SAVE_MY_WORK folder.")
                               (instruction-goal "your Sprite Sheet in your SAVE_MY_WORK folder."))
                         (launcher-img piskel-export-sheet)))

(define-webpage piskel-import-sheet
  this-curriculum
  "http://bit.ly/2G35zr6")

(define import-sprite-sheet
  (activity-instructions "Import Your Sprite Sheet"
                         '()
                         (list (instruction-basic "Find the sprite you want to replace.")
                               (instruction-basic "Delete the image and insert your new Sprite Sheet.")
                               (instruction-basic "Change the ROWS and COLUMNS to match.")
                               (instruction-goal "your code with the new Sprite Sheet."))
                         (launcher-img piskel-import-sheet)))

; === ADVENTURE GAME TASKS ===

;(with-award 0 open-file)
;(with-award 2 change-player-dialog)
(define change-player-dialog
  (activity-instructions "Change the Player Dialog"
                         '()
                         (list
                          (instruction-basic "Find the player dialog.")
                          (instruction-basic "Change the dialog and make it your own.")
                          (instruction-basic "Keep each question short.")
                          (instruction-goal "your new player dialog"))
                         (scale-to-fit (local-bitmap "tsgd_player_dialog.png") 250 320 #:mode 'preserve))) ;VIDEO?

;(with-award 2 change-npc-dialog)
(define change-npc-dialog
  (activity-instructions "Change the NPC Dialog"
                         '()
                         (list
                          (instruction-basic "Find the npc (non-player character) dialog.")
                          (instruction-basic "Change each response and make it your own.")
                          (instruction-basic "Each list should match a question and each quote gets it's own 'page'.")
                          (instruction-goal "your new NPC dialog"))
                         (scale-to-fit (local-bitmap "tsgd_npc_dialog.png") 250 320 #:mode 'preserve))) ;VIDEO?

;(with-award 2 add-new-dialog)
(define add-new-dialog
  (activity-instructions "Add New Dialog"
                         '()
                         (list
                          (instruction-basic "Add two more player dialog options. Make sure to make a new line and use quotes.")
                          (instruction-basic "Add two more npc responses, one for each player dialog option.")
                          (instruction-goal "your new dialog options and responses."))
                         (scale-to-fit (local-bitmap "tsgd_add_dialog.png") 250 320 #:mode 'preserve))) ;VIDEO?

;(with-award 1 make-npc-wander)
(define (make-npc mode)
  (activity-instructions (~a "Make the NPC " (string-titlecase mode))
                         '()
                         (list
                          (instruction-basic "Find (define (npc1-entity) ...)")
                          (instruction-basic (text-with-image "Change the mode to: "
                                                              (scale (codify (~a "'" mode)) 1.5)))
                          (instruction-goal "your npc in-game"))
                         (scale-to-fit (local-bitmap "tsgd_npc_mode.png") 250 320 #:mode 'preserve)))

;(with-award 1 make-npc-still)
;with-award 1 make-npc-follow)

;(with-award 1 change-npc-speed)
(define change-npc-speed
  (activity-instructions "Change the NPC speed"
                         '()
                         (list
                          (instruction-basic "Find (define (npc1-entity) ...)")
                          (instruction-basic "Make a new line after: ")
                          (instruction-basic (codify "npc1-response-sprites"))
                          (instruction-basic (text-with-image "Type: " (codify "#:speed 10")))
                          (instruction-goal "your npc moving faster or slower"))
                         (scale-to-fit (local-bitmap "tsgd_npc_speed.png") 250 320 #:mode 'preserve)))

;(with-award 2 (draw-sprite "betty.png" "NPC Character")))
(define draw-and-add-npc
  (activity-instructions "Draw Your Own NPC"
                         '()
                         (list (instruction-open "Piskel")
                               (instruction-basic "Open Piskel.")
                               (instruction-basic "Paint your own NPC (Non Player Character)")
                               (instruction-basic "Export and replace the old sprite")
                               (instruction-goal "your completed texture."))
                         (scale-to-fit (local-bitmap "leia-avatar.png") 250 320 #:mode 'preserve)))

(define (add-builder t launch)
  (activity-instructions (~a "Add " (string-titlecase t) " Builder Code")
                         '()
                         (list (instruction-basic "Use the launcher to see the code.")
                               (instruction-basic "Add the new code to the start-game function.")
                               (instruction-goal "the new code in your file."))
                         (launcher-img launch)
                         ))



(define (shrink i)
  (reusable-material
   (scale i 0.5)))




(define (remove-builder-code)

  (define b (frame (code
                      (builder (posn 200 200) wood-house)) #:color "red"))
  (define xb (x-out b))
  
  (define the-code (code
                    (start-game (instructions-entity)
                                #,xb
                                (wood-house (posn 325 120)
                                            #:tile 1)
                                (wood-house (posn 80 10)
                                            #:tile 1)
                                (wood-house (posn 300 200)
                                            #:tile 0)
                                (wood-house (posn 50 180)
                                            #:tile 0)
                                (item-entity (posn 200 200))
                                (npc1-entity)
                                (player-entity)
                                (bg-entity))))

  (code+hints the-code
              (list b
                    (hint
                     (vc-append
                      (text "Delete this code.")
                      (text "Mind the parentheses!"))))))

(define-image-file delete-builder     images (remove-builder-code))

(define remove-builder
  (activity-instructions "Remove Builder Code"
                         '()
                         (list (instruction-basic "Delete the builder code from start-game.")
                               (instruction-basic "Use the launcher to see sample code.")
                               (instruction-goal "your updated start-game code."))
                         (launcher-img delete-builder)))

