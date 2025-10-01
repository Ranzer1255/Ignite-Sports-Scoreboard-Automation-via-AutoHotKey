#Requires AutoHotkey v2.0

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