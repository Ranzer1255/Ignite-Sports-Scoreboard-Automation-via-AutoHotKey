#Requires AutoHotkey v2.0.7+

#Include globalVars.ahk
#include functions.ahk

;Alt + Number Buttons - Layout Switching

;layout 1
!1::{
    switchToOpConsole
    clickUsedLayouts
    clickBottomPanelButton(1,1)
    ; clickPublish
}

!2::{
    switchToOpConsole
    clickUsedLayouts
    clickBottomPanelButton(1,3)
    ; clickPublish
}


;Alt + Letter-Keys

;Blank Center Pannel
!b::{
    switchToOpConsole
    clickCenterPane
    clickBlank
}

;waving flag
!f::{
    switchToOpConsole
    LoadXkeysPreset("pregame - full")
    clickPublish
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

;load content specified by file into center pane
!l::{
    contentString := readContentStringFromFile()

    clickContentTab
    Search(contentString)
    clickCenterPane
    clickTopPanelButton(1)

}

;Alt+m: switch modes between CC animations (0) and Live video (1)
!m::{

    global mode

    if(!IsSet(mode)) {
        mode := 0
    }

    if(mode==1){
        mode := 0
        writeModeToFile()
        MsgBox "cc mode", "Mode", "t2"
    } else {
        mode := 1
        writeModeToFile()
        MsgBox "live video mode", "Mode", "T2"
    }
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

;Run next flash ad then go back to static
F5:: {
    clickCenterPane()
    clickFlash(5)
}

;touchdown
F6::{
    clickCenterPane
    global lastKey := 6
    ;click reaction tab
    click 1630, 270

    ;touchdown card (1,5)
    clickBottomPanelButton(1,5)
}

;PAT
F7::{
    clickCenterPane
    global lastKey := 7
    ;click reaction tab
    click 1630, 270

    ;PAT card (3,3)
    clickBottomPanelButton(3,3)
}

;Flag
F8::{
    clickCenterPane
    global lastKey := 8
    ;click reaction tab
    click 1630, 270

    ;FLAG card (2,4)
    clickBottomPanelButton(2,4)
}

;interception!
F9::{
    clickCenterPane
    global lastKey := 9

    clickReactionTab

    ;interception card (2,2)
    clickBottomPanelButton(2,2)
}

;run 30sec spot
F11::{
    clickCenterPane
    global lastKey := 11

    LoadXkeysPreset("4 - Full")
    clickCenterPane

    global spots

    static i :=1

    ;30sec spot tab
    click 1475, 270
    sleep 500

    clickBottomPanelButton(spots[i][1],spots[i][2])

        ;move to next spot on next key press
    if i<spots.Length {
        i := i+1
    } else {
        i := 1
    }
    clickPublish

}

;clear - run CC
F12::{ 
    global lastKey := 12
    ;run the default screen
    returnToDefaultScreen
}

;Full screen
F13::{
    LoadXkeysPreset("4 - full")
    clickPublish
}

;go to live
F14::{
    clickCenterPane
    clickLive
}

;Load FB Scoreboard
F15::{
    LoadXkeysPreset(FootballScoreboardLayout)
    clickPublish
}

;Halftime
F16::{
    LoadXkeysPreset("HT - Full")
    clickCenterPane
    returnToDefaultScreen
    clickPublish
}


;General Evac
F23::{
    switchToOpConsole
    LoadXkeysPreset("88GE -")
    clickPublish
}
;Weather emergency alert
F24::{
    switchToOpConsole
    LoadXkeysPreset("88WE -")
    clickPublish
}


;Alt + F-Keys

;Xkeys Generic Scoreboard
!F5::{
    switchToOpConsole
    LoadXkeysPreset(FootballScoreboardLayout)
    sleep 50
    clickCenterPane
    sleep 50
    clickPublish
}

;Xkeys Soccer
!F6::{
    switchToOpConsole
    LoadXkeysPreset("21 - ")
    clickPublish
}

;Xkeys Special
!F7::{
    switchToOpConsole
    LoadXkeysPreset("99S - ")
    clickPublish
}

;Xkeys Off
!F8::{
    clickClearSigns()
}

;Hosted Playoff Scoreboard
!F9::{
    switchToOpConsole
    LoadXkeysPreset("3 - split")
    clickPublish
}

;Testmode
!F24::{
    switchToOpConsole
    LoadXkeysPreset("Test Mode")
    clickPublish
}