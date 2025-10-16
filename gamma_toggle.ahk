; AutoHotkey v2 Gamma Toggle Script
; Press Numpad * to turn ON increased gamma
; Press Numpad - to turn OFF (return to default)
; Runs automatically on startup

#Requires AutoHotkey v2.0
#SingleInstance Force

; Configuration - Adjust these values to your preference
DEFAULT_GAMMA := 1.0    ; Normal gamma (1.0 = no change)
INCREASED_GAMMA := 1.5  ; Higher value = brighter (try values between 1.2-2.0)

; Global state tracker
global currentGamma := DEFAULT_GAMMA
global isIncreased := false

; Hotkey: Numpad * to turn ON increased gamma
NumpadMult:: {
    global isIncreased, currentGamma
    
    ; Increase gamma
    SetGamma(INCREASED_GAMMA)
    currentGamma := INCREASED_GAMMA
    isIncreased := true
}

; Hotkey: Numpad - to turn OFF (return to default)
NumpadSub:: {
    global isIncreased, currentGamma
    
    ; Return to default
    SetGamma(DEFAULT_GAMMA)
    currentGamma := DEFAULT_GAMMA
    isIncreased := false
}

; Function to set gamma for all monitors
SetGamma(gamma) {
    ; Get DC for the screen
    hdc := DllCall("GetDC", "Ptr", 0, "Ptr")
    
    ; Create gamma ramp array
    ; Each color channel (R, G, B) needs 256 WORD values
    rampSize := 256 * 2 * 3  ; 256 values × 2 bytes per WORD × 3 channels
    ramp := Buffer(rampSize)
    
    ; Fill the ramp with gamma-corrected values
    loop 256 {
        ; Calculate gamma-corrected value
        value := Round(65535 * ((A_Index - 1) / 255) ** (1 / gamma))
        
        ; Ensure value is within valid range
        if (value > 65535)
            value := 65535
        if (value < 0)
            value := 0
        
        ; Set value for all three color channels (R, G, B)
        offset := (A_Index - 1) * 2
        NumPut("UShort", value, ramp, offset)           ; Red
        NumPut("UShort", value, ramp, offset + 512)     ; Green
        NumPut("UShort", value, ramp, offset + 1024)    ; Blue
    }
    
    ; Apply gamma ramp
    result := DllCall("SetDeviceGammaRamp", "Ptr", hdc, "Ptr", ramp, "Int")
    
    ; Release DC
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
    
    return result
}

; Ensure gamma is reset when script exits
OnExit((*) => SetGamma(DEFAULT_GAMMA))
