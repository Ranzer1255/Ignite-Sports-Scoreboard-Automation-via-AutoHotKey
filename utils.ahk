#Requires AutoHotkey v2.0
#Include globalVars.ahk

join( strArray ){
    s := ""
    for i,v in strArray
        s .= ", " . v
    Return SubStr(s, 3)
}

join2D( strArray2D ){
    s := ""
    for i,array in strArray2D
        s.= ", [" . join(array) . "]"
    Return SubStr(s,3)
}

WrtieBitfocusCustomVariable(variable, value){
    Url := bitfocusAPIBaseURL . "/custom-variable/" . variable . "/value?value=" . value
    
    try {
        HttpRequest := ComObject("WinHttp.WinHttpRequest.5.1")
        HttpRequest.Open("POST", Url, false) 
        HttpRequest.Send("") 
        return HttpRequest.Status
    } catch {
        return 0 
    }
}

ReadBitfocusCustomVariable(variable){
    Url := bitfocusAPIBaseURL . "/custom-variable/" . variable . "/value"

    try {
        HttpRequest := ComObject("WinHttp.WinHttpRequest.5.1")
        HttpRequest.Open("GET", Url, false)
        HttpRequest.Send("")
        return HttpRequest.ResponseText
    } catch as e{
        MsgBox e.Message
        return ""
    } 
}