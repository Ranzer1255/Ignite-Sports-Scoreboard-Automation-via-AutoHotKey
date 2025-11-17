#Requires AutoHotkey v2.0.7+

#Include globalVars.ahk
#Include functions.ahk
#Include hotkeys.ahk
#Include utils.ahk

writeModeToBitfocus()

;background functions
SetTimer(writePublishedToBitfocus,5000)
