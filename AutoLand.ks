runoncepath("0:MyLib1.ks").
function LandingThrottle {
    return (CurrentGravity() + ((ship:airspeed^2) / (2 * RealRAlt()))) / MaxAcc().
}.

lock throttle to 0.0.
sas off.
lock steering to up.
set landingCompleted to false.

clearScreen.
print("Auto landing started!").
wait until ship:verticalspeed < -1.

print("Locking to retrograde").
lock steering to ship:srfretrograde.

if(alt:radar >= 250){
    when (alt:radar < 250) then {
        if(not gear) {
            gear on.
            print("Gears out!").
        }
    }
}
else {
    if(not gear) {
        gear on.
        print("Gears out!").
    }
}
when ship:verticalspeed > -1 then {
    set landingCompleted to true.    
}

print("Waiting for altitude...").
wait until LandingThrottle() > 0.97.

print("Doing the suicide burn!").
until landingCompleted {
    lock throttle to LandingThrottle().
}

lock throttle to 0.0.
lock steering to up.

wait(3).
clearScreen.
print("Landed!").
core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
