#Requires AutoHotkey v2.0.7+

#Include globalVars.ahk
#include functions.ahk

;Alt + Letter-Keys

;Blank Center Pannel
!b::{
    switchToOpConsole
    clickCenterPane
    clickBlank
}

;Edit Signs
!e::{
    clickEditSigns
}

; get loud!
!g::{
    global getLoud

    switchToOpConsole
    clickCenterPane

    clickReactionTab
    button := Random(1,getLoud.Length)

    clickBottomPanelButton(getLoud[button][1],getLoud[button][2])
    
}

;load content specified by bitfocus into center pane
!l::{
    contentString := readContentStringFromBitfocus()

    clickContentTab
    Search(contentString)
    clickCenterPane
    clickTopPanelButton(1)

}

;manual publish
!p::{
    clickPublish
}

;Alt+s: set up UI (position mouse on cross bar before pressing button)
!s::{
    MouseClickDrag "Left",,, 1530, 250 
}

;Kill switch alt+q
!q::ExitApp


;F-Keys

;First Down
F1::{
    clickDown(1)
}
;2nd Down
F2::{
    clickDown(2)
}
;3rd Down
F3::{
    clickDown(3)
}
;4th Down
F4::{
    clickDown(4)
}

;touchdown
F6::{
    clickCenterPane

    clickReactionTab

    ;touchdown card (1,5)
    clickBottomPanelButton(1,5)
}
;PAT
F7::{
    clickCenterPane
    clickReactionTab

    ;PAT card (3,3)
    clickBottomPanelButton(3,3)
}

;Flag
F8::{
    clickCenterPane
    clickReactionTab

    ;FLAG card (2,4)
    clickBottomPanelButton(2,4)
}

;interception!
F9::{
    clickCenterPane
    clickReactionTab

    ;interception card (2,2)
    clickBottomPanelButton(2,2)
}

;Full screen
F13::{
    LoadXkeysPreset(Layouts.FootballFullScreen)
    clickPublish
}

;go to live
F14::{
    clickCenterPane
    clickLive
}

;General Evac
F23::{
    switchToOpConsole
    LoadXkeysPreset(Layouts.EmergencyGeneral)
    clickPublish
}
;Weather emergency alert
F24::{
    switchToOpConsole
    LoadXkeysPreset(Layouts.EmergencyWeather)
    clickPublish
}


;Alt + F-Keys

;Xkeys Generic Scoreboard
!F5::{
    switchToOpConsole
    LoadXkeysPreset(Layouts.FootballScoreboard)
    sleep 50
    clickCenterPane
    sleep 50
    clickPublish
}

;Xkeys Soccer
!F6::{
    switchToOpConsole
    LoadXkeysPreset(Layouts.SoccerScoreboard)
    clickPublish
}

;Xkeys Special
!F7::{
    switchToOpConsole
    LoadXkeysPreset(Layouts.PracticeBoard)
    clickPublish
}

;Xkeys Off
!F8::{
    clickClearSigns()
}

;Field Day
!F10::{
    switchToOpConsole
    LoadXkeysPreset(Layouts.FieldDay)
    clickPublish
}

;Testmode
!F24::{
    switchToOpConsole
    LoadXkeysPreset(Layouts.TestMode)
    clickPublish
}