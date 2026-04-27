#Requires AutoHotkey v2.0

#Include globalVars.ahk
#Include utils.ahk
#Include Lib\UIA.ahk

/*
this method generates the X,Y coords for the mouse click in the bottom pannel from 
a row,column notation with 1,1 being top left

current settings are:
starting position 1300,400
horozontal distance of 125
vertical distance of 150

these settings assume one row of the top pannel showing and 4 rows of the bottom pannel
*/
getBottomPannelButtonPos(row, col)
{
    static startpos := [1300,400]
    static hdist := 125
    static vdist := 150
    hight := startpos[2]+(row-1)*vdist
    width := startpos[1]+(col-1)*hdist
    return [width,hight]
}

getTopPanelButtonPos(col)
{
    static startpos := [1300, 180]
    static hdist := 125
    width := startpos[1]+(col-1)*hdist
    Return [width,startpos[2]]
}


clickBottomPanelButton(row,col){
    WinActivate "Ignite Sports"
    button := getBottomPannelButtonPos(row,col)
    click button[1], button[2]
}

clickTopPanelButton(col){
    WinActivate "Ignite Sports"
    button := getTopPanelButtonPos(col)
    click button[1], button[2]
}

clickCenterPane(){
    WinActivate "Ignite Sports"
    click 600,400
}

clickLive(){
    WinActivate "Ignite Sports"
    ; click 1276, 40
    IgniteSportsUI.ElementFromPath("QWQWQ/QIJ").Click("left")
    clickTopPanelButton(2)
}

clickBlank(){
    WinActivate "Ignite Sports"
    ; click 1276, 40
    IgniteSportsUI.ElementFromPath("QWQWQ/QIJ").Click("left")
    clickTopPanelButton(1)
}

clickContentTab(){
    WinActivate "Ignite Sports"
    ; ;click content tab
    ; Click 1340, 40
    ; sleep 50
    ; ;twice to make sure
    ; Click 1340, 40
    ; sleep 50
    ; click 1340, 40
    ; sleep 50
    ; click 1340, 40
    ; sleep 50

    IgniteSportsUI.ElementFromPath("QWQWQ/QIJq").Click("left")
}

clickCCTab(){
    WinActivate "Ignite Sports"
    ;click cc tab
    ; click 1510, 40
    IgniteSportsUI.ElementFromPath("QWQWQ/QIJs").Click("left")
}

clickLayoutTab(){
    WinActivate "Ignite Sports"
    IgniteSportsUI.ElementFromPath("QWQWQ/QIJv").Click("left")
    ; Click 1793, 40
    ; sleep 50
    ; ;twice to make sure
    ; Click 1793, 40
    ; sleep 50
    ; click 1793, 40
    ; sleep 50
    ; click 1793, 40
    ; sleep 50
}

clickUsedLayouts(){
    WinActivate "Ignite Sports"
    IgniteSportsUI.ElementFromPath("QWQWQQIJu").Click("left")
    ; Click 1720, 270
    ; sleep 50
    ; ;twice to make sure
    ; Click 1720, 270
    ; sleep 50
    ; Click 1720, 270
    ; sleep 50
    ; Click 1720, 270
    ; sleep 50
}

clickReactionTab(){
    WinActivate "Ignite Sports"
    IgniteSportsUI.ElementFromPath("QWQWQQIJt").Click("left")
    ; click 1630, 270
    ; sleep 50
    ; click 1630, 270
    ; sleep 50
}

readContentStringFromBitfocus(){

    variable := "loadContent"

    contentString := ReadBitfocusCustomVariable(variable)

    return contentString
}

Search(searchString){
    IgniteSportsUI.ElementFromPath("QWQWQ/QYQQ4").Value := searchString
}

clickPublish(){
    WinActivate "Ignite Sports"
    Sleep 50

    count := 0
    ;click publish
    while PixelGetColor(1165,775) != 0xF1C400 {
        count++
        ; click 1175,770
        IgniteSportsUI.ElementFromPath("QWQ/Q/Qv").Click("left")
        sleep 150
        if A_Index > 5 {
            MsgBox("clicked A_Index times and failed every time")
            break
        }
            
    }
    ; MsgBox("took " . count . " clicks",,"T2")
    writePublishedToBitfocus
}

clickEditSigns(){
    while (PixelGetColor(1165,775) == 0xF1C400) {
        ; click 1170,890
        IgniteSportsUI.ElementFromPath("QWQ/Q/Qw").Click("left")
        sleep 50
        if A_Index > 5
            break
    }
    writePublishedToBitfocus
}

clickClearSigns(){
        
    WinActivate "Ignite Sports"
    ;click clear signs

    while PixelGetColor(1165,775) == 0xF1C400 {
        ; click 1170,940
        IgniteSportsUI.ElementFromPath("QWQ/Q/Q/").Click("left")
        sleep 50
        if A_Index > 4 
            break
    }
    writePublishedToBitfocus
}

; expects a layouts class object
LoadXkeysPreset(layout){
    global currentSport
    newSport := layout[3]
    WinActivate "Ignite Sports"
    send "{Enter}"

    clickUsedLayouts
    
    clickBottomPanelButton(layout[1],layout[2])

    if(newSport == Sport.None || newSport == currentSport) 
        return ;not changing sports. dont wait for the popup and move on...


    sleep 1250
    ;deal with popup
    send "{Enter}"
    sleep 50
    currentSport := newSport
    WrtieBitfocusCustomVariable("igniteSport",currentSport)
}

ClickContent(content){
    WinActivate "Ignite Sports"

    clickContentTab
    
    search(content)

    clickTopPanelButton(1)
    sleep 50
    clickTopPanelButton(1)
    
}

;updates Bitfocus with the current published status
writePublishedToBitfocus(){
    ; pixel location 1154, 774
    ; off color 0x999999
    ; on  color 0xF1C400
    ; no button 0x262626

    if WinActive("Ignite Sports"){
        if ( parseHeader(IgniteSportsUI.Name)["mode"]=="Operator's Console"){
            pixel := PixelGetColor(1154,774)

            variable := "ignitePublished"

            switch pixel{
                case 0x999999: ;off
                    WrtieBitfocusCustomVariable(variable,"off")
                case 0xF1C400: ;on  
                    WrtieBitfocusCustomVariable(variable,"on")
                default: 
                    WrtieBitfocusCustomVariable(variable,"ERR: WRONG PAGE")
            }
        }
    }
}

writeSelectedLayoutToBitfocus(){
    if WinActive("Ignite Sports"){
        if (isOpConsole){
            WrtieBitfocusCustomVariable("igniteSelectedLayout",parseHeader(IgniteSportsUI.name)["layout"])
        }
    }
}

; checks to see if we're in the Op console 
isOpConsole(){
    WinActivate("Ignite Sports")
    return parseHeader(IgniteSportsUI.Name)["mode"] == "Operator's Console"
}

switchToOpConsole(){
    WinActivate("Ignite Sports")
    if !isOpConsole() {
        ;menu
        click 25,50
        sleep 50
        ;op console
        click 100,90
        sleep 50

        clickEditSigns
    }
}

clickDown(down){

    global lastKey := down
    
    clickCenterPane
    ;click reaction tab
    clickReactionTab

    ;click selected down
    switch down {
        case 1:
            clickBottomPanelButton(1,1)
        case 2:
            clickBottomPanelButton(1,2)
        case 3:
            clickBottomPanelButton(1,3)
        case 4:
            clickBottomPanelButton(1,4)
        default:
            
    }
}

setDividerHeight(){
    CoordMode("Mouse","Screen")
    thumb := IgniteSportsUI.ElementFromPath("QWQWS")
    point := thumb.GetClickablePoint()
    MouseClickDrag("Left",point.x,point.y, 1530, 270) 
    CoordMode("Mouse","Client")
}