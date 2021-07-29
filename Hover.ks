runoncepath("0:lib/MyLib1.ks").

sas off.
set hovering to true.
set hoverAltitude to altitude.
set hoverDirection to up.
clearScreen.

on ag1 {
    set hoverAltitude to (hoverAltitude + 5).
    preserve.
}.
on ag2 {
    set hoverAltitude to (hoverAltitude - 5).
    preserve.
}.
on ag3 {
    set hovering to false.
    wait(0.25).
    lock throttle to 0.0.
    runPath("0:AutoLand.ks").
}.
on ag4 {
    set hovering to false.
    wait(0.25).
    clearScreen.
    print("Hover mode is off!").
}.
on ag5 {
    set hoverDirection to r(hoverDirection:pitch, hoverDirection:yaw + 1, hoverDirection:roll).
    preserve.
}
on ag6 {
    set hoverDirection to r(hoverDirection:pitch + 1, hoverDirection:yaw, hoverDirection:roll).
    preserve.
}
on ag7 {
    set hoverDirection to r(hoverDirection:pitch - 1, hoverDirection:yaw, hoverDirection:roll).
    preserve.
}
on ag8 {
    set hoverDirection to r(hoverDirection:pitch, hoverDirection:yaw - 1, hoverDirection:roll).
    preserve.
}
on ag9 {
    set inputAltitude to "".

    clearScreen.
    print ("Custom altitude: ").
    set tempChar to "".
    until tempChar = terminal:input:enter {
        print (inputAltitude + "        ") at (0, 1).
        set tempChar to terminal:input:getchar().
        if (not(decimalDigits:find(tempChar) = -1)) {           
            set inputAltitude to (inputAltitude + tempChar).
        }
        else if (tempChar = terminal:input:backspace) {
            if(inputAltitude:length > 0) {
                set inputAltitude to inputAltitude:remove(inputAltitude:length - 1, 1).
            }
        }
    }
    clearScreen.

    set hoverAltitude to StrParseInt(inputAltitude).
    preserve.
}.
on ag10 {
    set hoverAltitude to altitude.
    preserve.
}.

until not hovering {
    lock throttle to HoverThrottle(hoverAltitude).
    lock steering to hoverDirection.
    print ("Hover altitude: " + round(hoverAltitude, 2) + " meters      ") at (0, 0).
    print ("Heading: " + GetHeading()) at (0, 1).
    print ("Pitch: " + GetPitch()) at (0, 2).
    print ("Roll: " + GetRoll()) at (0, 3).
}
