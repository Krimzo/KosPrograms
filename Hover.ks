runoncepath("0:MyLib1.ks").
function HoverThrottle {
    parameter wantedAltitude.
    if((wantedAltitude - altitude) < 0){
        return (2 * (wantedAltitude - (altitude - NegVerDis())) + CurrentGravity() - (2 * ship:verticalspeed)) / MaxAcc().
    }
    return (2 * (wantedAltitude - (PosVerDis() + altitude)) + CurrentGravity() - (2 * ship:verticalspeed)) / MaxAcc().
}.

sas off.
lock steering to up.
set hovering to true.
set hoverAltitude to altitude.
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
    clearScreen.
    print("Hover mode is off!").
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
    set hoverAltitude to RealRAlt().
    preserve.
}.

until not hovering {
    lock throttle to HoverThrottle(hoverAltitude).
    print ("Hover altitude: " + round(hoverAltitude, 2) + " meters    ") at (0, 0).
}
