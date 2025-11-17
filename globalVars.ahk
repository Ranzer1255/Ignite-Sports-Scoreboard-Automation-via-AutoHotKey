#Requires AutoHotkey v2.0

;Global Variables
mode := 1
txtFilesLocation := "\\files\ScoreboardStatus"
;Video spot array
spots :=   [[1, 1],
            [1, 2],
            [1, 3],
            [1, 4],
            [1, 5],
            [2, 1],
            [2, 2],
            [2, 3],
            [2, 4],
            [2, 5],
            [3, 1],
            [3, 2],
            [3, 3],
            [3, 4],
            [3, 5],
            [4, 1]
        ]

; Array of Get Loud Reaction buttons on the Reaction Tab
getLoud := [[3,5],
            [4,1]
        ]

;play flash ads in this order (random starting point)
flashes := [[1, 1],
            [1, 2],
            [1, 3],
            [1, 4], 
            [1, 5],
            [2, 1],  
            [2, 2],  
            [2, 3], 
            [2, 4], 
            [2, 5],
            [3, 1],
            [3, 2],
            [3, 3],
            [3, 4],
            [3, 5],
            [4, 1],
            [4, 2],
            [4, 3],
            [4, 4],
            [4, 5]
        ]

;this is the used Foootball scoreboard layout across the script, the Default is: "1 - split"
FootballScoreboardLayout := "transparent"

bitfocusAPIBaseURL := "10.7.199.2:1255/api"