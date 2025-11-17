#Requires AutoHotkey v2.0

#Include globalVars.ahk

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
    click 1276, 40
    clickTopPanelButton(2)
}

clickBlank(){
    WinActivate "Ignite Sports"
    click 1276, 40
    clickTopPanelButton(1)
}

clickContentTab(){
    WinActivate "Ignite Sports"
    ;click content tab
    Click 1340, 40
    sleep 50
    ;twice to make sure
    Click 1340, 40
    sleep 50
    click 1340, 40
    sleep 50
    click 1340, 40
    sleep 50
}

clickCCTab(){
    WinActivate "Ignite Sports"
    ;click cc tab
    click 1510, 40
}

clickLayoutTab(){
    WinActivate "Ignite Sports"
    Click 1793, 40
    sleep 50
    ;twice to make sure
    Click 1793, 40
    sleep 50
    click 1793, 40
    sleep 50
    click 1793, 40
    sleep 50
}

clickUsedLayouts(){
    WinActivate "Ignite Sports"
    Click 1720, 270
    sleep 50
    ;twice to make sure
    Click 1720, 270
    sleep 50
    Click 1720, 270
    sleep 50
    Click 1720, 270
    sleep 50
}

clickReactionTab(){
    WinActivate "Ignite Sports"
    click 1630, 270
    sleep 50
    click 1630, 270
    sleep 50
}


writeModeToFile(){
    global mode
    variable := "ignightMode"

    switch mode{
        case 0: ;CC
            WrtieBitfocusCustomVariable(variable,"CC")
        case 1: ;Live
            WrtieBitfocusCustomVariable(variable,"Live")
    }
}

readContentStringFromFile(){

    variable := "loadContent"

    contentString := ReadBitfocusCustomVariable(variable)

    return contentString
}

clickFlash(key:=0){
    ;set the key pushed
    global lastKey := key
    
    clickCenterPane()

    ;switch to flash tab
    click 1550,270

    ;will click flashes in this order
    ;note if these need to be adjusted, use the Client position under the mouse positions in Windows Spy
    ;the hight of the bottom pannel has about 30px wiggle room try to get it just under the frame for
    ;the frame of the first row of boxes int he top window

    global flashes
    static i := Random(1,flashes.Length)

    ;allow skipping the clicker sleep when rerun, so this can be also used to clear 
    clickBottomPanelButton(flashes[i][1],flashes[i][2])
    
    ;move to next flash on next key press
    if i<flashes.Length {
        i := i+1
    } else {
        i := 1
    }
}

returnToDefaultScreen(){

    ;are we doing live video (1) or CC animations (0)
    global mode

    if !IsSet(mode){
        mode := 0
        writeModeToFile()
    }

    ;live video mode
    if (mode = 1){
        clickLive
        
    ;cc animation mode
    } else { 
        clickCCTab

        Search("cc")
 
        ;click random static image
        restingButton := random(1, 5)
        clickTopPanelButton(restingButton)
    }


}

Search(searchString){
    ;click clear
    click 1835, 70
    sleep 50
    click 1835, 70
    sleep 50
    
    ;click Text box
    click 1745, 70
    sleep 50
    click 1745, 70
    sleep 50
    
    Send searchString
}

clickPublish(){
    WinActivate "Ignite Sports"

    ;click publish
    while PixelGetColor(1165,775) != 0xF1C400 {
        click 1175,770
        sleep 150
        if A_Index > 4 
            break
    }
    writePublishedToFile
}

clickEditSigns(){
    click 1170,890
    sleep 50
    click 1170,890
}

clickClearSigns(){
        
    WinActivate "Ignite Sports"
    ;click clear signs

    while PixelGetColor(1165,775) == 0xF1C400 {
        click 1170,940
        sleep 50
        if A_Index > 4 
            break
    }
    writePublishedToFile
}

LoadXkeysPreset(preset){
    WinActivate "Ignite Sports"

    clickLayoutTab
    
    ;search for layout
    Search(preset)

    clickTopPanelButton(1)
    sleep 50
    clickTopPanelButton(1)

    sleep 1250

    ;deal with popup
    send "{Enter}"
    sleep 50
}

ClickContent(content){
    WinActivate "Ignite Sports"

    clickContentTab
    
    search(content)

    clickTopPanelButton(1)
    sleep 50
    clickTopPanelButton(1)
    
}

;updates the published.txt file with the current published status
writePublishedToFile(){
    ; pixel location 1154, 774
    ; off color 0x999999
    ; on  color 0xF1C400
    ; no button 0x262626

    if WinActive("Ignite Sports"){
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

; checks to see if we're in the Op console 
isOpConsole(){
    WinActivate("Ignite Sports")
    
    pixel := PixelGetColor(1154,774)
    return pixel != "0x262626"
}

switchToOpConsole(){
    ; MsgBox isOpConsole()
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

WrtieBitfocusCustomVariable(variable, value){
    Url := bitfocusAPIBaseURL . "/custom-variable/" . variable . "/value?value=" . value
    
    ; --- HTTP Request using WinHTTP COM Object ---
    try {
        HttpRequest := ComObject("WinHttp.WinHttpRequest.5.1")
        
        ; Open the POST request (synchronous)
        HttpRequest.Open("POST", Url, false) 
        
        ; Send the request with an empty body
        HttpRequest.Send("") 
        
        ; Return only the HTTP Status Code
        return HttpRequest.Status
        
    } catch {
        ; Return 0 for a connection or COM script error
        return 0 
    }
}

ReadBitfocusCustomVariable(variable){
    Url := bitfocusAPIBaseURL . "/custom-variable/" . variable . "/value"

    try {
        HttpRequest := ComObject("WinHttp.WinHttpRequest.5.1")
        
        ; Open the POST request (synchronous)
        HttpRequest.Open("GET", Url, false) 
        
        ; Send the request with an empty body
        HttpRequest.Send("")
        
        return HttpRequest.body
    } catch {
        return "Error"
    } 
}
