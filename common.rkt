#lang slideshow

(provide shrink
         open-racket-only
         load-code
         load-code-more
         google-form
         draw-sprite-style
         export-from-piskel
         reload-fave
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
         SONIC-BONUS  )



(require pict/code)
(require ts-curric-common)

(require racket/runtime-path)
(define-runtime-path images "images")

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

(define open-racket-only
  (activity-instructions "Open DrRacket"
                         '()
                         (list (instruction-open "DrRacket")
                               (instruction-goal "the blank file in DrRacket."))
                         (video-qr "http://bit.ly/2HV5yHn")))

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

(define open-file
  (activity-instructions "Open Your File"
                         '()
                         (list (instruction-basic "Open your SAVE_MY_WORK folder")
                               (instruction-basic "Double-click your .rkt file")
                               (instruction-goal "your file open in DrRacket."))
                         (video-qr "http://bit.ly/2IvXVHJ")))

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

(define (google-form url)
  (activity-instructions "Open the Game Review"
                         '()
                         (list (instruction-basic "Scan the card to open the Game Review.")
                               (instruction-basic "Answer the questions about the demo games.")
                               (instruction-goal "your Google Form submitted."))
                         (code-qr url)))

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
                               (instruction-basic "Open Piskel.")
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
                               (instruction-basic "Make sure it ends in '.png' and name it whatever you want.")
                               (instruction-goal "your exported file."))
                         (video-qr "http://bit.ly/2Ark1Wv")))

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

(define (redesign-sprite url)
  (activity-instructions "Re-design Your Sprite"
                         '()
                         (list
                          (instruction-basic "Add more detail to your sprite.")                          
                          (instruction-basic "Insert it in your code.")
                          (instruction-basic "Scale down the image if it is too big.")
                          (instruction-goal "your new changes running in game."))
                        (video-qr url)))

(define (replace-sprite url)
  (activity-instructions "Replace Your Sprite"
                         '()
                         (list
                          (instruction-basic "In the code look for the old image and delete it.")
                          (instruction-basic "Go to 'Insert' menu and select 'Insert Image...'")
                          (instruction-basic "Find your sprite image and select 'Open'")
                          (instruction-goal "your sprite in the code."))
                        (video-qr url)))

(define (replace-sheet url)
  (activity-instructions "Replace Your Sprite"
                         '()
                         (list
                          (instruction-basic "Find and delete the old sprite.")
                          (instruction-basic "Go to 'Insert' menu and select 'Insert Image...'")
                          (instruction-basic "Find your image and select 'Open'")
                          (instruction-basic "Change rows, columns, and row-number to 1")
                          (instruction-goal "your sprite in the code."))
                        (video-qr url)))

(define (load-code demo-name)
  (activity-instructions "Load the Starter Code"
                         '()
                         (list (instruction-basic "Click on TS Magic Loader. In the text field, type:")
                               (instruction-basic (codify demo-name))
                               (instruction-basic "Click the Load button")
                               (instruction-basic "Run the code.")
                               (instruction-goal  "The demo code running in DrRacket"))
                         (video-qr "http://bit.ly/2Q2yKAh")))

(define (load-code-more endGame imgStr)
  (activity-instructions (++ "Test Games 2 Through " endGame)
                         '()
                         (list (instruction-basic "Click the TS Magic Loader again.")
                               (instruction-basic (text-with-image "In the text field, type:" (codify "tsgd_style_2")))
                               (instruction-basic "Run the code and test game.")
                               (instruction-basic (++ "Continue until demo " endGame "."))
                               (instruction-goal  "your game window running."))
                         (scale-to-fit (local-bitmap imgStr) 250 250 #:mode 'preserve)))

(define reload-fave
  (activity-instructions "Reload Your Favorite Style"
                         '()
                         (list (instruction-basic "Reload the game with your favorite style.")
                               (instruction-goal  "your favorite game."))
                         (video-qr "http://bit.ly/2Q2yKAh")))

(define save-as
  (activity-instructions "Save the File"
                         '()
                         (list (instruction-basic "Click 'File' and  'Save Definitions As'")
                               (instruction-basic "Rename the file, make sure to keep the '.rkt' at the end!")
                               (instruction-goal  "your renamed and saved file."))
                         (video-qr "http://bit.ly/2ImsLCl")))

(define (change-position url)
  (activity-instructions "Change the Start Position"
                         '()
                         (list                        
                          (instruction-basic "Find your collectible's posn values at the bottom.")
                          (instruction-basic "Make your collectible start far away.")
                          (instruction-basic "TIP: (posn 0 0) is the top left corner.")
                          (instruction-goal "your collectible starting far away in game."))
                        (video-qr url)))

(define (change-player-position url)
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

(define (animate sprite)
  (activity-instructions (++ "Animate Your " (string-titlecase sprite))
                         '()
                         (list (instruction-basic (++ "Duplicate and change frames in Piskel to animate your " (string-downcase sprite)))
                               (instruction-goal (++ "your animated " (string-downcase sprite) " in Piskel.")))
                         (video-qr "http://bit.ly/2DLfNKP")))

(define export-sprite-sheet
  (activity-instructions "Export Your Sprite Sheet"
                         '()
                         (list (instruction-basic "Click Export and PNG")
                               (instruction-basic "Change the number of COLUMNS to match the number of frames you have.")
                               (instruction-basic "Export the image to your SAVE_MY_WORK folder.")
                               (instruction-goal "your Sprite Sheet in your SAVE_MY_WORK folder."))
                         (video-qr "http://bit.ly/2HSkJQN")))

(define import-sprite-sheet
  (activity-instructions "Import Your Sprite Sheet"
                         '()
                         (list (instruction-basic "Find the sprite you want to replace.")
                               (instruction-basic "Delete the image and insert your new Sprite Sheet.")
                               (instruction-basic "Change the ROWS and COLUMNS to match.")
                               (instruction-goal "your code with the new Sprite Sheet."))
                         (video-qr "http://bit.ly/2G35zr6")))

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



(define (shrink i)
  (reusable-material
   (scale i 0.5)))

