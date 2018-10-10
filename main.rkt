#lang slideshow

(require pict/color)
(require pict/shadow)
(require pict/code)
(require simple-qr)
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

(define (redesign-sprite-sheet url)
  (activity-instructions "Re-design Your Animation"
                         '()
                         (list
                          (instruction-basic "Import your sheet back into piskel.")                          
                          (instruction-basic "Modify your design.")
                          (instruction-basic "Export and insert into DrRacket.")
                          (instruction-goal "your redesigned animation running in game."))
                        (video-qr url)))

;load code snippet
(define (load-new-code demo-name)
  (activity-instructions "Load the New Code"
                         '()
                         (list (instruction-basic "Click on TS Magic Loader. In the text field, type:")
                               (instruction-basic (codify demo-name))
                               (instruction-basic "Click the Load button")
                               (instruction-basic "The video on the left shows how to use the magic loader.")
                               (instruction-goal  "The new code open in DrRacket"))
                         (video-qr "https://bit.ly/2q7YAr3")))

;(with-award 1 copy-paste) 
(define copy-paste-bad-sprite
  (activity-instructions "Copy and Paste the Code"
                         '()
                         (list (instruction-basic "Highlight the new code.")
                               (instruction-basic "Press CTRL+C to COPY.")
                               (instruction-basic "Go back to your project and make a new line BEFORE (define lost?)")
                               (instruction-basic "Press CTRL+V to PASTE.")
                               (instruction-goal "your new code in your project"))
                         (video-qr "https://bit.ly/2HetpC0")))
                                                 
;(with-award 2 add-sprites-and-edge)
(define add-sprites-and-edge
  (activity-instructions "Add Sprites and Left-Edge"
                         '()
                         (list                        
                          (instruction-basic "Find the (start-game) code at the bottom.")
                          (instruction-basic "Make a new line after (hero-entity) and type:")
                          (instruction-basic (codify "(bad-chest-entity)"))
                          (instruction-basic (codify "(left-edge)"))
                          (instruction-goal "your moving sprite in game"))
                        (video-qr "https://bit.ly/2EmMmiK")))

;(with-award 2 add-death-to-hero)
(define add-death-on-collide
  (activity-instructions "Add Death on Collide"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Make a new line after (key-movement 3) and type: ")
                          (instruction-basic (codify "(on-collide \"bad chest\" die)"))
                          (instruction-goal "your hero dying on collision"))
                        (video-qr "https://bit.ly/2HbA3sx")))

;(with-award 1 test-game) ;Add adjust speed values?
(define test-and-modify-game
  (activity-instructions "Modify and Test Game"
                         '()
                         (list
                          (instruction-basic "Adjust any random speed values.")
                          (instruction-basic "Add more bad sprites.")
                          (instruction-basic "Save your code.")
                          (instruction-basic "Run and test your game again.")
                          (instruction-goal "your new changes running in game."))
                        (scale-to-fit (local-bitmap "click_run.png") 250 250 #:mode 'preserve)))

(define add-random-direction
  (activity-instructions "Add Random Directions"
                        '()
                         (list                        
                          (instruction-basic "Find (define (bad-chest-entity) ...)")
                          (instruction-basic "Make a new line after (respawn 'right) and type: ")
                          (instruction-basic (codify "(random-direction 170 190)"))
                          (instruction-goal "your sprites moving at random angles"))
                        (video-qr "https://bit.ly/2EknCrb")))

;(with-award 1 copy-paste-keep-score) 
(define copy-paste-keep-score
  (activity-instructions "Copy and Paste the Code"
                         '()
                         (list (instruction-basic "Highlight the new code.")
                               (instruction-basic "Press CTRL+C to COPY.")
                               (instruction-basic "Go back to your project and make a new line BEFORE (define lost?)")
                               (instruction-basic "Press CTRL+V to PASTE.")
                               (instruction-goal "your new code in your project"))
                         (video-qr "https://bit.ly/2HqIEdA")))
                                                 
;(with-award 2 modify-score)
(define modify-score
  (activity-instructions "Modify the Keep Score Code"
                         '()
                         (list
                          (instruction-basic "Change \"hero\" and \"chest\" to match your game.")
                          (instruction-basic "Find the (start-game) code and add (score-entity) after (game-over-screen).")
                          (instruction-basic "Test the game.")
                          (instruction-goal "your score changing in game."))
                        (video-qr "https://bit.ly/2vh0aw0")))

(define export-import-sprite-sheet
  (activity-instructions "Export & Insert Your Animation"
                         '()
                         (list (instruction-basic "Click Export and PNG")
                               (instruction-basic "Change the number of COLUMNS to match the number of frames you have.")
                               (instruction-basic "Export the image to your SAVE_MY_WORK folder.")
                               (instruction-basic "Find the sprite you want to replace.")
                               (instruction-basic "Delete the image and insert your new Sprite Sheet.")
                               (instruction-basic "Change the ROWS and COLUMNS to match.")
                               (instruction-goal "your code with the new Sprite Sheet."))
                         (video-qr "https://bit.ly/2qLLZdx")))



(define won-code-img (scale (code (define (won? g e) 
                                    (define score (get-counter (get-entity "score" g)))
                                    (>= score 1000)))
                            4 ))

(define modify-won 
  (activity-instructions "Modify the Win Condition"
                         '()
                         (list                        
                          (instruction-basic "Find the '(define (won?' code.")
                          (instruction-basic "Modify the code to read the counter from score-entity. It should look like this:")
                          (instruction-image won-code-img 640 100 "")
                          ;(instruction-basic "Change 'speed' to 'score'.")
                          ;(instruction-basic "Change 'get-speed' to 'get-counter'.")
                          ;(instruction-basic "Change 'get-entity \"###\"' to 'get-entity \"score\"'.")
                          ;(instruction-basic "Change (>= speed 10) to        (>= score 1000).")
                          (instruction-goal "a score of 1000 in game."))
                        (video-qr "https://bit.ly/2HsgDlH")))

(define add-score-background
  (activity-instructions "Add a Score Background"
                         '()
                         (list (instruction-basic "TS Magic Load: 'tsgd_score_bg'.")
                               (instruction-basic "Copy/Paste the code BEFORE (define (score-entity).")
                               (instruction-basic "Add (score-bg) BEFORE (score-entity) in (start-game).")
                               (instruction-goal "your score background in game."))
                         (video-qr "https://bit.ly/2HlBRCq")))

(define download-background
  (activity-instructions "Download a New Background"
                         '()
                         (list
                          (instruction-basic "Open Google Chrome and click 'CC Search'.")
                          (instruction-basic "Find a new background image and save it in SAVE_MY_WORK.")
                          (instruction-goal "your image saved in the folder."))
                         (video-qr "https://bit.ly/2Hpg60v")))

(define open-resize-pinta
  (activity-instructions "Resize the Background"
                         '()
                         (list
                          (instruction-open "Pinta")
                          (instruction-basic "Open the downloaded image.")
                          (instruction-basic "Resize and crop the image to 640 by 480.")
                          (instruction-goal "your resized image in Pinta."))
                         (video-qr "https://bit.ly/2Jj525O")))

(define save-insert-background
  (activity-instructions "Save & Insert Background"
                         '()
                         (list
                          (instruction-basic "In Pinta, rename and save the image to SAVE_MY_WORK.")
                          (instruction-basic "In DrRacket, delete the old bg and insert your new one.")
                          (instruction-basic "Test your game.")
                          (instruction-goal "your new background in-game."))
                         (video-qr "https://bit.ly/2HmmPww")))


(define add-edges-code-img (scale (code (right-edge)
                                        (top-edge)
                                        (bottom-edge))
                                  4 ))

(define add-edges
  (activity-instructions "Add More Edges"
                         '()
                         (list                        
                          (instruction-basic "Find (start-game ...)")
                          (instruction-basic "AFTER (left-edge), type:")
                          (instruction-image (text-with-image "             " add-edges-code-img) 640 140 "")
                          (instruction-goal "your new code."))
                        (video-qr "https://bit.ly/2JCHI38")))

(define stop-on-left-code-img (scale (code (on-collide "left edge" (go-to-pos-inside 'left)))
                                     4 ))

(define stop-on-left-edge
  (activity-instructions "Stop On Left Edge"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "AFTER (key-movement ...), type:")
                          (instruction-image (text-with-image "      " stop-on-left-code-img) 640 140 "")
                          (instruction-basic "Run the game.")
                          (instruction-goal "your player stopping on the left edge"))
                        (video-qr "https://bit.ly/2KoUseY")))


(define more-stop-on-edge-code-img (scale (code (on-collide "right edge"  (go-to-pos-inside 'right))
                                                (on-collide "top edge"    (go-to-pos-inside 'top))
                                                (on-collide "bottom edge" (go-to-pos-inside 'bottom))
                                                )
                                          4 ))

(define more-stop-on-edge
  (activity-instructions "More Stop On Edges"
                         '()
                         (list                        
                          (instruction-basic "Add more edge stoppers for right, top, and bottom.")
                          (instruction-basic "It should look like this:")
                          (instruction-image (text-with-image "      " more-stop-on-edge-code-img) 640 140 "")
                          (instruction-basic "Run the game.")
                          (instruction-goal "your player stopping on all edges"))
                        (video-qr "https://bit.ly/2rajRkC")))

(define wrap-around-code-img (scale (code (on-collide "top edge"    (go-to-pos-inside 'bottom))
                                          (on-collide "bottom edge" (go-to-pos-inside 'top))
                                          )
                                    4 ))

(define wrap-around-top-bottom
  (activity-instructions "Wrap Around"
                         '()
                         (list                        
                          (instruction-basic "Modify the code to make the top edge send you to the bottom and the bottom edge to the top.")
                          (instruction-basic "It should look like this:")
                          (instruction-image (text-with-image "      " wrap-around-code-img) 640 140 "")
                          (instruction-basic "Run the game.")
                          (instruction-goal "your player wrapping around."))
                        (video-qr "https://bit.ly/2KstkMa")))

(define stop-on-edge-v2-code-img (scale (code (stop-on-edge 'left 'right)) 4 ))

(define stop-on-edge-improved
  (activity-instructions "Stop On Edge Improved"
                         '()
                         (list                        
                          (instruction-basic "Erase the left and right edge stoppers and replace it with this improved code:")
                          (instruction-image (text-with-image "      " stop-on-edge-v2-code-img) 640 140 "")
                          (instruction-basic "Options are (blank), 'left, 'right, 'top, and 'bottom.")
                          (instruction-goal "your player stopping on left and right edges."))
                        (video-qr "https://bit.ly/2ra1U5y")))

(define wrap-around-v2-code-img (scale (code (wrap-around 'top-bottom)) 4 ))

(define wrap-around-improved
  (activity-instructions "Wrap Around Improved"
                         '()
                         (list                        
                          (instruction-basic "Erase the top and bottom wrap around and replace it with this improved code:")
                          (instruction-image (text-with-image "      " wrap-around-v2-code-img) 640 140 "")
                          (instruction-basic "Remove right, top, and bottom edges from (start-game).")
                          (instruction-goal "your player wrapping around."))
                        (video-qr "https://bit.ly/2r9nfvh")))

(define random-hue-code-img (scale (code (change-img-hue (random 360) [IMAGE] )) 4 ))

(define random-hue-background
  (activity-instructions "Random Hue Background"
                         '()
                         (list                        
                          (instruction-basic "Add this code around the background image: ")
                          (instruction-image (text-with-image "   " random-hue-code-img) 640 140 "")
                          (instruction-basic "[IMAGE] = your bg image.")
                          (instruction-basic "Works best with bright colors.")
                          (instruction-goal "a random color background"))
                        (video-qr "https://bit.ly/2I6q7nf")))

(define random-hue-player
  (activity-instructions "Random Hue Player"
                         '()
                         (list                        
                          (instruction-basic "Add this code around the player image: ")
                          (instruction-image (text-with-image "   " random-hue-code-img) 640 140 "")
                          (instruction-basic "[IMAGE] = your sheet/image")
                          (instruction-basic "Works best with bright colors.")
                          (instruction-goal "a random color sprite."))
                        (video-qr "https://bit.ly/2HElPE3")))

(define add-enemy-code
  (activity-instructions "Add the Enemy Code"
                         '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (scale (codify "tsgd_enemy") 1.5)))
                               (instruction-basic "Copy/Paste the Code BEFORE (define (lost? g e)")
                               (instruction-goal "your new code in your project"))
                         (scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 250 250 #:mode 'preserve)))

(define add-enemy-entity
  (activity-instructions "Add the Enemy Entity"
                         '()
                         (list (instruction-basic "Find the (start-game) code and make a new line AFTER (score-entity).")
                               (instruction-basic (text-with-image "Type: " (scale (codify "(enemy-entity)") 1.5)))
                               (instruction-basic "Test the game.")
                               (instruction-goal "your enemy in game."))
                         (scale-to-fit (local-bitmap "tsgd_add_enemy_entity.png") 250 250 #:mode 'preserve)))

;   (with-award 2 death-by-dragon)
(define death-by-dragon
  (activity-instructions "Add Death by Dragon"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Make a new line after (on-collide \"###\" die).")
                          (instruction-basic (text-with-image "Type: " (codify "(on-collide \"dragon\" die)")))
                          (instruction-basic "Test the game.")
                          (instruction-goal "your hero dying by the dragon"))
                        (scale-to-fit (local-bitmap "tsgd_add_death.png") 250 250 #:mode 'preserve)))

;   (with-award 1 add-rotation-style)
(define add-rotation-style
  (activity-instructions "Add Rotation Style"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Make a new line after (every-tick (move)) and type:")
                          (instruction-image (scale (codify "(rotation-style 'left-right)") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon pointing left and right"))
                        (scale-to-fit (local-bitmap "tsgd_add_rotation_style.png") 250 250 #:mode 'preserve)))


(define rage-mode-code-img (scale (code (after-time 200 (do-many (change-color-by 260)
                                                                 (scale-sprite 1.25)))
                                        ) 4 ))

(define after-time-rage
  (activity-instructions "Add a Rage Mode"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Make a new line after (rotation-style ...) and type:")
                          (instruction-image (text-with-image "   " rage-mode-code-img) 640 140 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon changing size and color."))
                        (scale-to-fit (local-bitmap "tsgd_rage_mode.png") 250 250 #:mode 'preserve)))

;   (with-award 2 (load-copy "tsgd_fireball"))
(define add-fireball-code
  (activity-instructions "Add the Fireball Code"
                         '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (scale (codify "tsgd_fireball") 1.5)))
                               (instruction-basic "Copy/Paste the Code BEFORE (define (lost? g e)")
                               (instruction-goal "your new code in your project"))
                         (scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 250 250 #:mode 'preserve)))

;   (with-award 1 add-spawner)
(define spawner-code-img (scale (code (spawner fireball-entity 20)) 4 ))

(define add-fireball-spawner
  (activity-instructions "Add a Fireball Spawner"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Make a new line after the last (on edge ...) and type:")
                          (instruction-image (text-with-image "   " spawner-code-img) 640 140 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon shooting fireballs."))
                        (scale-to-fit (local-bitmap "tsgd_add_spawner.png") 250 250 #:mode 'preserve)))

;   (with-award 1 add-die-by-fireball)

(define death-by-fireball-code-img (scale (code (on-collide "fireball" die)) 4 ))

(define death-by-fireball
  (activity-instructions "Add Death by Fireball"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Make a new line after the last (on-collide \"###\" die) and type:")
                          (instruction-image (text-with-image "   " death-by-fireball-code-img) 640 140 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "your hero dying by the fireball"))
                        (scale-to-fit (local-bitmap "tsgd_add_death_fireball.png") 250 250 #:mode 'preserve)))

;(with-award 2 add-follow-code-enemy)
(define add-follow-code-enemy
  (activity-instructions "Make the Dragon Follow You"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Disable (do-every ...) by typing a ';' just before it.")
                          (instruction-basic "Make a new line and type:")
                          (instruction-image (scale (codify "(follow \"hero\")") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon following you."))
                        (scale-to-fit (local-bitmap "tsgd_dragon_follow.png") 250 250 #:mode 'preserve)))
                        

;(with-award 1 change-rotation-style)
(define change-rotation-style
  (activity-instructions "Make the Dragon Face You"
                          '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Change (rotation-style 'left-right) to: ")
                          (instruction-image (scale (codify "(rotation-style 'face-direction)") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon facing you."))
                        (scale-to-fit (local-bitmap "tsgd_face_direction.png") 250 250 #:mode 'preserve)))
                         


;(with-award 1 add-follow-code-collectible)
(define collectible-follow-code-img (scale (code (direction 0)
                                                 (speed 2)
                                                 (every-tick (move))
                                                 (follow "hero")) 4 ))

(define add-follow-code-collectible
  (activity-instructions "Make the Collectible Follow"
                         '()
                         (list                        
                          (instruction-basic "Find the collectible definition.")
                          (instruction-basic "Add the following components BEFORE (on-collide ...):")
                          (instruction-image (text-with-image "   " collectible-follow-code-img) 640 140 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the collectible following you."))
                        (scale-to-fit (local-bitmap "tsgd_collectible_follow.png") 250 250 #:mode 'preserve)))

;(with-award 1 replace-the-dragon)
(define replace-the-dragon
  (activity-instructions "Draw a New Enemy"
                         '()
                         (list (instruction-basic "Draw a new enemy sprite and replace the dragon.")
                               (instruction-basic "Change the ROWS and COLUMNS to match your new sprite.")
                               (instruction-goal "your new enemy sprite in game."))
                         (scale-to-fit (local-bitmap "tsgd_replace_dragon.png") 250 250 #:mode 'preserve)))

;(with-award 3 (google-form "https://bit.ly/2rFTOkv"))
(define (review-your-game url)
  (activity-instructions "Open the Game Review"
                         '()
                         (list (instruction-basic "Scan the card to open the Game Review.")
                               (instruction-basic "Answer the questions about your game.")
                               (instruction-goal "your Google Form submitted."))
                         (code-qr url)))

;(choose "any"
; (list
; (with-award 2 replace-the-fireball)
(define replace-the-fireball
  (activity-instructions "Draw a Fireball Sprite"
                         '()
                         (list (instruction-basic "Draw a new fireball sprite and export it to SAVE_MY_WORK.")
                               (instruction-basic "Find (define (rainbow-fireball)) and replace (circle 10 \"solid\" \"white\") with your image.")
                               (instruction-goal "your new fireball in game."))
                         (scale-to-fit (local-bitmap "tsgd_fireball.png") 250 250 #:mode 'preserve)))

; (with-award 1 add-point-to-fireball)
(define add-point-to-fireball
  (activity-instructions "Make the Fireball Point To You"
                          '()
                         (list                        
                          (instruction-basic "Find (define (fireball-entity) ...)")
                          (instruction-basic "Inside (on-start),change (random-direction 0 360) to: ")
                          (instruction-image (scale (codify "(point-to \"hero\")") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the fireballs shooting at you."))
                        (scale-to-fit (local-bitmap "tsgd_fireball.png") 250 250 #:mode 'preserve)))

;  (with-award 1 rotation-style-collectible)
(define more-rotation-style
  (activity-instructions "More Rotation Style"
                         '()
                         (list                        
                          (instruction-basic "Add (rotation-style ###) to the collectible and/or the fireball.")
                          (instruction-basic "Use either 'left-right mode or 'face-direction mode.")
                          (instruction-basic "Earn a 1$ for each rotation-style you add.")
                          (instruction-goal "more entities with rotation."))
                        (scale-to-fit (local-bitmap "tsgd_add_rotation_fireball.png") 250 250 #:mode 'preserve)))

(define load-copy-wall-and-lava
  (activity-instructions "Load/Copy Wall & Lava Code"
                         '()
                         (list (instruction-basic "TS Magic Load: 'tsgd_wall_and_lava'.")
                               (instruction-basic "Copy/Paste the code BEFORE (define lost?).")
                               (instruction-goal "your new code in your project"))
                         (scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 320 320 #:mode 'preserve)))


(define wall-lava-code-img (scale (code (wall-entity (posn 450 250))
                                        (wall-entity (posn 150 300))
                                        (lava-entity (posn 300 150))) 4 ))

(define add-wall-and-lava
  (activity-instructions "Add Walls & Lava"
                         '()
                         (list (instruction-basic "Find the (start-game) code, make a new line AFTER (enemy-entity), and type:")
                               (instruction-image (text-with-image "   " wall-lava-code-img) 640 140 "")
                               (instruction-basic "Test the game.")
                               (instruction-goal "your walls and lava in game."))
                         (scale-to-fit (local-bitmap "tsgd_add_walls_and_lava.png") 300 320 #:mode 'preserve)))

;(with-award 2 add-physical-colliders)
(define add-physical-colliders
  (activity-instructions "Add Physical Colliders"
                         '()
                         (list (instruction-basic "Add a (physical-collider) component to BOTH the hero-entity and the enemy-entity.")
                               (instruction-basic "Type it anywhere BEFORE (on-collide) or (on-edge).")
                               (instruction-goal "the hero and the enemy colliding with walls."))
                         (scale-to-fit (local-bitmap "tsgd_add_colliders.png") 320 320 #:mode 'preserve)))

;(with-award 1 death-by-lava)

(define death-by-lava-code-img (scale (code (on-collide "lava" die)) 4 ))

(define death-by-lava
  (activity-instructions "Add Death by Lava"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Add the following component:")
                          (instruction-image (text-with-image "   " death-by-fireball-code-img) 640 140 "")
                          (instruction-basic "You can comment out other lines with ';' to make testing easier. If you have rage mode on the enemy, disable that too.")
                          (instruction-goal "your hero dying by the lava."))
                        (scale-to-fit (local-bitmap "tsgd_add_death_lava.png") 250 320 #:mode 'preserve)))

;(with-award 2 draw-walls-and-lava)
(define replace-the-walls-and-lava
  (activity-instructions "Draw Your Own Walls & Lava"
                         '()
                         (list (instruction-basic "Draw new \"wall\" and \"lava\" sprites and save it.")
                               (instruction-basic "Find (define (wall-entity)) and replace (rectangle 80 40 \"solid\" \"white\") with your image.")
                               (instruction-basic "Repeat for the lava-entity.")
                               (instruction-goal "your new walls and lava in game."))
                         (scale-to-fit (local-bitmap "tsgd_wall_and_lava.png") 320 320 #:mode 'preserve)))


;        (with-award 2 add-bounce-to-fireball)
(define add-bounce-to-fireball
  (activity-instructions "Make the Fireball Bounce"
                          '()
                         (list                        
                          (instruction-basic "Find (define (fireball-entity) ...)")
                          (instruction-basic "Make a new line AFTER (rotation-style ...) and type:")
                          (instruction-image (scale (codify "(on-collide \"wall\" (bounce))") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the fireballs bouncing off walls."))
                        (scale-to-fit (local-bitmap "tsgd_add_bounce.png") 300 320 #:mode 'preserve)))
  
;        (with-award 1 add-after-time-die)
(define add-after-time-die
  (activity-instructions "After Time - Remove Bad Guys"
                          '()
                         (list                        
                          (instruction-basic "Find your moving sprite definition (bad-chest-entity, if you didn't rename it).")
                          (instruction-basic "Make a new line AFTER (every-tick ...) and type:")
                          (instruction-image (scale (codify "(after-time 500 die)") 2) 640 60 "")
                          (instruction-goal "the wave of bad guys ending."))
                        (scale-to-fit (local-bitmap "tsgd_add_after_time_die.png") 300 320 #:mode 'preserve)))

;        (with-award 1 add-after-time-spawn)
(define add-after-time-spawn
  (activity-instructions "After Time - Spawn Boss"
                          '()
                         (list                        
                          (instruction-basic "Remove (enemy-entity) from (start-game ...).")
                          (instruction-basic "Change the enemy-entity's position to (posn 0 0).")
                          (instruction-basic "Add the following component to lava-entity.")
                          (instruction-image (scale (codify "(after-time 600 (spawn (enemy-entity)))") 2) 640 60 "")
                          (instruction-goal "the boss spawning after 600."))
                        (scale-to-fit (local-bitmap "tsgd_spawn_boss.png") 250 320 #:mode 'preserve)))

;(with-award 1 load-copy-laser)
(define load-copy-laser
  (activity-instructions "Load/Copy Laser Code"
                         '()
                         (list (instruction-basic "TS Magic Load:")
                               (instruction-image (scale (codify "   tsgd_laser") 2) 640 60 "")
                               (instruction-basic "Copy/Paste the code BEFORE (define lost?).")
                               (instruction-goal "your new code in your project"))
                         (scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 320 320 #:mode 'preserve)))

;(with-award 2 modify-laser)
(define modify-laser
  (activity-instructions "Modify the Laser Code"
                         '()
                         (list
                          (instruction-basic "Change \"airplane\" and \"dragon\" to match your game.")
                          (instruction-basic "Modify the position to adjust where the laser will spawn on the hero.")
                          (instruction-goal "your modified laser code."))
                        (scale-to-fit (local-bitmap "tsgd_laser_position.png") 300 320 #:mode 'preserve)))

;(with-award 1 add-shoot-button)
(define add-shoot-button
  (activity-instructions "Add a Shoot Button"
                          '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Add the following component:")
                          (instruction-image (scale (codify "(on-key 'space (spawn laser-entity))") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "The hero shooting lasers."))
                        (scale-to-fit (local-bitmap "tsgd_shoot_laser.png") 250 320 #:mode 'preserve)))

;(with-award 1 add-laser-collisions)

(define laser-collisions-code-img (scale (code (on-collide "laser" (respawn 'right))) 4 ))

(define add-laser-collisions
  (activity-instructions "Add Laser Collisions"
                          '()
                         (list                        
                          (instruction-basic "Find your moving sprite definition (bad-chest-entity, if you didn't rename it).")
                          (instruction-basic "Make a new line AFTER (on-start ...) and type:")
                          (instruction-image (text-with-image "" laser-collisions-code-img) 640 140 "")
                          (instruction-goal "the hero shooting down enemies."))
                        (scale-to-fit (local-bitmap "tsgd_laser_collision.png") 250 320 #:mode 'preserve)))

;(with-award 2 death-by-laser)
(define death-by-laser-code-img (scale (code (on-collide "laser" die)) 4 ))

(define death-by-laser
  (activity-instructions "Add Death by Laser"
                         '()
                         (list                        
                          (instruction-basic "Find (define (fireball-entity) ...)")
                          (instruction-basic "Add the following component:")
                          (instruction-image (text-with-image "   " death-by-laser-code-img) 640 140 "")
                          (instruction-goal "your hero shooting down fireballs."))
                        (scale-to-fit (local-bitmap "tsgd_add_death_laser.png") 250 320 #:mode 'preserve)))

;(with-award 1 load-copy-boss-health)
(define load-copy-boss-health
  (activity-instructions "Load/Copy Boss Health Code"
                         '()
                         (list (instruction-basic "TS Magic Load:")
                               (instruction-image (scale (codify "   tsgd_boss_health") 2) 640 60 "")
                               (instruction-basic "Copy/Paste the code BEFORE (define lost?).")
                               (instruction-goal "your new code in your project"))
                         (scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 320 320 #:mode 'preserve)))

;(with-award 1 add-boss-health-entity)
(define add-boss-health-entity
  (activity-instructions "Add the Boss Health Entity"
                         '()
                         (list (instruction-basic "Find the (start-game) code, make a new line AFTER (score-entity) and type:")
                               (instruction-image (scale (codify "(boss-health-entity)") 2) 640 60 "")
                               (instruction-basic "Test the game.")
                               (instruction-goal "the boss health going down."))
                         (scale-to-fit (local-bitmap "tsgd_add_boss_health.png") 250 250 #:mode 'preserve)))

;(with-award 2 add-boss-death)
(define boss-death-code-img (scale (code (on-rule boss-health-is-zero? die)) 4 ))

(define add-boss-death
  (activity-instructions "Make the Boss Die"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Add the following component:")
                          (instruction-image (scale (codify "(on-rule boss-health-is-zero? die)") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the boss dying after multiple laser hits."))
                        (scale-to-fit (local-bitmap "tsgd_add_boss_death.png") 250 320 #:mode 'preserve)))

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
;; COMPLETE DAYS
#;(define day1-2dgame
  (list
   ;(with-award 1 (scan-badge "1"))
   ;(with-award 0 start-folders)
   (with-award 1 (open-racket "save"))
   (with-award 2 (demo-code "play" "1" "your game window running."))
   (with-award 1 (demo-code-more "17" "test_game.png"))
   (with-award 3 (google-form "http://bit.ly/2EZkOoB"))
   (with-award 2 (draw-sprite "spaceship.png" "Character"))
   (with-award 0 export-from-piskel)
   (choose "any"
           (list            
            (with-award 1 (load-code "v6/spaceship_game"))
            (with-award 1 save-as)
            (with-award 1 (insert-image "http://bit.ly/2FveHsH" "spaceship-sprite"))
            ))
   ))

(define day1-2dgame
  (list
   (with-award 0 open-racket-only)
   (with-award 2 (load-code "tsgd_style_1"))
   (with-award 1 (load-code-more "4" "load_style.png"))
   (with-award 3 (google-form "http://bit.ly/2NizLFU"))
   (with-award 2 (draw-sprite-style "betty_single.png" "Character"))
   (with-award 0 export-from-piskel)
   (choose "any"
           (list
            (with-award 0 reload-fave)
            (with-award 1 save-as)
            (with-award 1 (replace-sheet "http://bit.ly/2FTnKD7"))
            ))
   ))

;Design your own Collectible
(define day2-2dgame
  (list
   ;(with-award 1 (scan-badge "5"))
   (with-award 2 (draw-sprite "collectibles.png" "Collectible"))
   (with-award 0 export-from-piskel)
   (with-award 0 open-file)
   (with-award 3 (replace-sheet "http://bit.ly/2FTnKD7"))
   (with-award 1  test-game)
   (choose "any"
           (list
            (with-award 0 (import-to-piskel "Collectible"))
            (with-award 3 (redesign-sprite "http://bit.ly/2It8CdW"))
            (with-award 1 (change-player-position "http://bit.ly/2tTaFoi"))
            (with-award 1 (change-starting-tile))
            ;(with-award 1 (add-more-collectibles "https://bit.ly/2G9sIwr"))
            ))
   ))

;Animate your Collectible
(define day3-2dgame
  (list
   ;(with-award 1 (scan-badge "6"))
   (with-award 0 (import-to-piskel "Collectible")) ;1. Import Collectible
   (with-award 3 (animate "Collectible")) ;2. Duplicate and Edit Collectible -- change color/bounce/sparkle  (Video)
   (with-award 1 export-sprite-sheet) ;3. Export a Sprite Sheet (set rows and columns)  (Video)
   (with-award 0 open-file)
   (with-award 1 import-sprite-sheet) ;5. Insert Sprite Sheet - Change rows and columns to match sprite sheet (Video)
   (with-award 1  test-game)
   ;(with-award 1 redesign-sprite-sheet)
   (choose "any"
           (list
            (with-award 3 (animate "Character")) ;7. BONUS -- Animate the main character
            (with-award 0 export-sprite-sheet)
            (with-award 1 import-sprite-sheet)
            ;(with-award 2 (animate-more "Character"))
            ;(with-award 2 (animate-more "Background"))
            ))
   ))

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

;Add a Moving Bad Sprite
(define day5-2dgame
  (list
   (with-award 0 open-file)
   (with-award 0 (load-new-code "tsgd_moving_sprite"))
   (with-award 1 copy-paste-bad-sprite)
   (with-award 2 add-sprites-and-edge)
   (with-award 2 add-death-on-collide)
   (with-award 1 test-and-modify-game)
   (choose "any"
          (list
           (with-award 2 (draw-sprite "bad_sprite.png" "Bad Sprite"))
           (with-award 1 (replace-sheet "http://bit.ly/2FTnKD7"))
           (with-award 2 add-random-direction)
           ))
   ))

;Add a Score Entity
(define day6-2dgame
  (list
   (with-award 0 open-file)
   (with-award 0 (load-new-code "tsgd_keep_score"))
   (with-award 1 copy-paste-keep-score)       
   (with-award 2 modify-score)                
   (with-award 2 modify-won)
   (choose "any"
          (list
           (with-award 1 add-score-background)
           (with-award 1 download-background)
           (with-award 2 open-resize-pinta)
           (with-award 2 save-insert-background) 
           ))
   ))

;day 7 Stop on Edge and Wrap Around
(define day7-2dgame
  (list
   (with-award 0 open-file)
   (with-award 1 add-edges)
   (with-award 1 stop-on-left-edge)       
   (with-award 2 more-stop-on-edge)                
   (with-award 1 wrap-around-top-bottom)
   (choose "any"
          (list
           (with-award 2 stop-on-edge-improved)
           (with-award 2 wrap-around-improved)
           (with-award 1 random-hue-background)
           (with-award 1 random-hue-player) 
           ))
   ))

;day 8 Wandering Ai and Projectiles
(define day8-2dgame
  (list
   (with-award 0 open-file)
   (with-award 2 add-enemy-code)     
   (with-award 1 add-enemy-entity)
   (with-award 1 death-by-dragon)
   (with-award 1 add-rotation-style)
   (choose "any"
          (list
           (with-award 2 after-time-rage)
           (with-award 2 add-fireball-code)
           (with-award 1 add-fireball-spawner)
           (with-award 1 death-by-fireball)
           ))
   ))

;day 9 Follow Ai
(define day9-2dgame
  (list
   (with-award 0 open-file)
   (with-award 1 add-follow-code-enemy)     
   (with-award 1 change-rotation-style)
   (with-award 2 add-follow-code-collectible)
   (with-award 1 replace-the-dragon)
   (with-award 2 (review-your-game "https://bit.ly/2rFTOkv"))
   (choose "any"
          (list
           (with-award 2 replace-the-fireball)
           (with-award 1 add-point-to-fireball)
           (with-award 1 more-rotation-style)
           ))
   ))

;day 10 Walls and Lava
(define day10-2dgame
  (list
   (with-award 0 open-file)
   (with-award 1 load-copy-wall-and-lava)     
   (with-award 2 add-wall-and-lava)
   (with-award 1 add-physical-colliders)
   (with-award 1 death-by-lava)
   (with-award 2 replace-the-walls-and-lava)
   (choose "any"
          (list
           (with-award 1 add-bounce-to-fireball)
           (with-award 1 add-after-time-die)
           (with-award 2 add-after-time-spawn)
           ))
   ))

;day 11 Player Shooting and Boss Health
(define day11-2dgame
  (list
   (with-award 0 open-file)
   (with-award 1 load-copy-laser)     
   (with-award 2 modify-laser)
   (with-award 2 add-shoot-button)
   (with-award 2 add-laser-collisions)
   (with-award 1 death-by-laser)
   (choose "any"
          (list
           (with-award 1 load-copy-boss-health)
           (with-award 1 add-boss-health-entity)
           (with-award 2 add-boss-death)
           ))
   ))


;;; --- "red" = text color for Q#-#
(define (quest1)
  (make-picts "red" "Q1-" day1-2dgame (settings (bg (local-bitmap "bg-arcade.png")) PACMAN PACMAN-BONUS PACMAN-BONUS)))


(define (quest2)
  (make-picts "red" "Q2-" day2-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS)))


(define (quest3)
  (make-picts "red" "Q3-" day3-2dgame (settings (bg (local-bitmap "bg-arcade.png")) G-MUSH G-MUSH-BONUS G-MUSH-BONUS)))

(define (quest4)
  (make-picts "red" "Q4-" day4-2dgame (settings (bg (local-bitmap "bg-arcade.png")) STAR STAR-BONUS STAR-BONUS)))


(define (quest5)
  (make-picts "red" "Q5-" day5-2dgame (settings (bg (local-bitmap "bg-arcade.png")) R-MUSH R-MUSH-BONUS R-MUSH-BONUS)))


(define (quest6)
  (make-picts "red" "Q6-" day6-2dgame (settings (bg (local-bitmap "bg-arcade.png")) LINK LINK-BONUS LINK-BONUS)))

(define (quest7)
  (make-picts "red" "Q7-" day7-2dgame (settings (bg (local-bitmap "bg-arcade.png")) SAMUS SAMUS-BONUS SAMUS-BONUS)))

(define (quest8)
  (make-picts "red" "Q8-" day8-2dgame (settings (bg (local-bitmap "bg-arcade.png")) PIKACHU PIKACHU-BONUS PIKACHU-BONUS)))

(define (quest9)
  (make-picts "red" "Q9-" day9-2dgame (settings (bg (local-bitmap "bg-arcade.png")) CHARMANDER CHARMANDER-BONUS CHARMANDER-BONUS)))


(define (quest10)
  (make-picts "red" "Q10-" day10-2dgame (settings (bg (local-bitmap "bg-arcade.png")) SQUIRTLE SQUIRTLE-BONUS SQUIRTLE-BONUS)))


(define (quest11)
  (make-picts "red" "Q11-" day11-2dgame (settings (bg (local-bitmap "bg-arcade.png")) YOSHI YOSHI-BONUS YOSHI-BONUS)))



(provide quests)
(define (quests)
  (list quest1
        quest2
        quest3
        quest4
        quest5
        quest6
        quest7
        quest8
        quest9
        quest10
        quest11))



