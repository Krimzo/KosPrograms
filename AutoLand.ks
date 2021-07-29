runoncepath("0:MyLib1.ks").

lock throttle to 0.0.
sas off.
lock steering to up.
clearScreen.

print("Auto landing started!").
wait until ship:verticalspeed < -1.

if (alt:radar >= 300) {
    when (alt:radar < 300) then {
        gear on.
    }
}
else {
    gear on.
}

print("Locking to retrograde").
lock steering to ship:srfretrograde.

print("Doing the suicide burn!").
until ship:verticalspeed > -1 {
    lock throttle to HoverThrottle(altitude - alt:radar).
}

lock throttle to 0.0.
lock steering to up.

wait(3).
clearScreen.
print("Landed!").
//core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
