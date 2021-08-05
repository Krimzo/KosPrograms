runOncePath("0:lib/PhysLib.ks").
runOncePath("0:lib/NavLib.ks").
runOncePath("0:lib/IntLib.ks").


function HoverThrottle {
    parameter wantedAltitude.
    if ((wantedAltitude - altitude) < 0) {
        return (2 * (wantedAltitude - (altitude - NegVerDis())) + CurrentGravity() - (2 * ship:verticalspeed)) / (MaxAcc() * sin(GetPitch())).
    }
    return (2 * (wantedAltitude - (PosVerDis() + altitude)) + CurrentGravity() - (2 * ship:verticalspeed)) / (MaxAcc() * sin(GetPitch())).
}.

function HoverHeading {
    parameter wantedNorthVelo.
    parameter wantedEastVelo.
    parameter pitchLimit.
    
    set neededYaw to arcTan2((wantedEastVelo - GetEastVelo()), (wantedNorthVelo - GetNorthVelo())).

    set neededEastVelo to abs(wantedEastVelo - GetEastVelo()).
    set neededNorthVelo to abs(wantedNorthVelo - GetNorthVelo()).
    set totalNeededVelo to max((neededNorthVelo + neededEastVelo), 1E-4).

    set neededEastPitch to max(arcCos(min(neededEastVelo / MaxAcc(), 1)), pitchLimit).
    set neededNorthPitch to max(arcCos(min(neededNorthVelo / MaxAcc(), 1)), pitchLimit).
    set neededPitch to (neededNorthPitch * (neededNorthVelo / totalNeededVelo) + neededEastPitch * (neededEastVelo / totalNeededVelo)).

    return heading(neededYaw, neededPitch).
}.
