#Requires AutoHotkey v2.0

!l::{
    StatusCode := PostIgnightMode("Live")

    ; Check the result. A status code like 200, 201, or 204 usually indicates success.
    if (StatusCode > 199 && StatusCode < 300) {
        MsgBox("SUCCESS! 'ignightMode' set to " . "Live" . ". Status: " . StatusCode)
    } else {
        MsgBox("FAILED! Status: " . StatusCode . ". Check the network and API.")
    }
}

!c::{
    StatusCode := PostIgnightMode("CC")

    ; Check the result. A status code like 200, 201, or 204 usually indicates success.
    if (StatusCode > 199 && StatusCode < 300) {
        MsgBox("SUCCESS! 'ignightMode' set to " . "CC" . ". Status: " . StatusCode)
    } else {
        MsgBox("FAILED! Status: " . StatusCode . ". Check the network and API.")
    }
}


/**
 * Sends a POST request to set the 'ignightMode' custom variable.
 * The response body is ignored, but the HTTP Status is returned.
 *
 * @param {String} mode - The value to set: 'CC' or 'Live'.
 * @returns {Int} The HTTP status code (e.g., 200, 404) or 0 on script error.
 */
PostIgnightMode(mode) {
    ; --- Configuration & Validation ---
    if (!mode = "CC" && !mode = "Live") {
        return 0 ; Return 0 for script validation error
    }
    
    Url := "http://10.7.199.2:1255/api/custom-variable/ignightMode/value?value=" . mode
    
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

