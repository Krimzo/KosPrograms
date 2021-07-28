runpath("0:MyLib1.ks").
function HoverThrottle {
    parameter wantedAltitude.
    return (2 * (wantedAltitude - altitude) + CurrentGravity() - ship:verticalspeed) / MaxAcc().
}.

clearScreen.
sas off.
lock steering to up.
set hovering to true.
set hoverAltitude to altitude.

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
    lock throttle to 0.0.
    runPath("0:AutoLand.ks").
}.
on ag4 {
    set hovering to false.
    wait(0.5).
    lock throttle to 0.0.
    clearScreen.
    print("Hover mode is off!").
}.
on ag9 {
    // user input
}.
on ag10 {
    set hoverAltitude to altitude.
}.

until not hovering {
    print ("Hover altitude: " + round(hoverAltitude, 2) + " meters") at (0, 0).
    lock throttle to HoverThrottle(hoverAltitude).
}
