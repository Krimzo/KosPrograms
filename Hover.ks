runoncepath("0:lib/AutoPilotLib.ks").

sas off.
set hovering to true.
set hoverAltitude to altitude.
set northVelocity to 0.0.
set eastVelocity to 0.0.
lock steering to up.
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
    wait(0.5).
    clearScreen.
    lock throttle to 0.0.
    runPath("0:AutoLand.ks").
}.
//on ag4 {
//    set hovering to false.
//    wait(0.25).
//    clearScreen.
//    print("Hover mode is off!").
//}.
on ag5 {
    set northVelocity to (northVelocity - 5).
    preserve.
}.
on ag6 {
    set northVelocity to (northVelocity + 5).
    preserve.
}.
on ag7 {
    set eastVelocity to (eastVelocity - 5).
    preserve.
}.
on ag8 {
    set eastVelocity to (eastVelocity + 5).
    preserve.
}.
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
    set northVelocity to 0.0.
    set eastVelocity to 0.0.
    preserve.
}.

until not hovering {
    lock throttle to HoverThrottle(hoverAltitude).
    lock steering to HoverHeading(northVelocity, eastVelocity, 30).
    print ("Hover altitude: " + round(hoverAltitude, 2) + " meters      ") at (0, 0).
    print ("North velocity: " + northVelocity + "       ") at (0, 1).
    print ("East velocity: " + eastVelocity + "       ") at (0, 2).
}
