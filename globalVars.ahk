#Requires AutoHotkey v2.0

;current active sport Defaults to Football
currentSport := Sport.Football

;Video spot array moved to vMix
; spots :=   [[1, 1],
;             [1, 2],
;             [1, 3],
;             [1, 4],
;             [1, 5],
;             [2, 1],
;             [2, 2],
;             [2, 3],
;             [2, 4],
;             [2, 5],
;             [3, 1],
;             [3, 2],
;             [3, 3],
;             [3, 4],
;             [3, 5],
;             [4, 1]
;         ]

; Array of Get Loud Reaction buttons on the Reaction Tab
getLoud := [[3,5],
            [4,1]
        ]

;play flash ads in this order (random starting point) MOved to vMix
; flashes := [[1, 1],
;             [1, 2],
;             [1, 3],
;             [1, 4], 
;             [1, 5],
;             [2, 1],  
;             [2, 2],  
;             [2, 3], 
;             [2, 4], 
;             [2, 5],
;             [3, 1],
;             [3, 2],
;             [3, 3],
;             [3, 4],
;             [3, 5],
;             [4, 1],
;             [4, 2],
;             [4, 3],
;             [4, 4],
;             [4, 5]
;         ]

;this is the used Foootball scoreboard layout across the script, the Default is: "1 - split"

bitfocusAPIBaseURL := "http://10.7.199.2:1255/api"

Class Sport {
    static Football => "Football"
    static Soccer   => "Soccer"
    static None     => "none"
}

Class Layouts {
    ;3 element array, [Used Layouts Row, Used Layouts Col, Sport]
    static FootballScoreboard => [1,1,Sport.Football]
    static FootballFullScreen => [1,3,Sport.Football]
    static SoccerScoreboard   => [1,2,Sport.Soccer]
    static SoccerFullScreen   => [0,0,Sport.Soccer] ;TODO: not built yet
    static PracticeBoard      => [2,4,Sport.Football]
    static EmergencyGeneral   => [2,1,Sport.None]
    static EmergencyWeather   => [2,2,Sport.None]
    static FieldDay           => [2,3,Sport.Football]
    static TestMode           => [2,5,Sport.None]
    static FallScorebard      => [1,4,Sport.Football]
    static HalloweenSb        => [1,5,Sport.Football]
}