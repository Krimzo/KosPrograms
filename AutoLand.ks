runoncepath("0:lib/MyLib1.ks").

lock throttle to 0.0.
sas off.
lock steering to up.
clearScreen.

print("Auto landing started!").
wait until ship:verticalspeed < -1.

print("Locking to retrograde").
lock steering to ship:srfretrograde.

print("Doing the suicide burn!").
gear on.
until ship:verticalspeed > -1 {
    lock throttle to HoverThrottle(altitude - RealRadarAlt()).
}

lock throttle to 0.0.

wait(3).
clearScreen.
print("Landed!").
//core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
