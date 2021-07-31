runoncepath("0:lib/MainLib.ks").

lock throttle to 0.0.
sas off.
lock steering to up.
clearScreen.

print("Auto landing started!").
wait until ship:verticalspeed < -1.

print("Locking to retrograde").
lock steering to ship:srfretrograde.

gear on.
print("Doing the suicide burn!").
until (ship:verticalspeed > -1) {
    lock throttle to HoverThrottle(altitude - RealRadarAlt()).
}

lock throttle to 0.0.

wait(3).
clearScreen.
print("Landed!").
