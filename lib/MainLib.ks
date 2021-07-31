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
    
    set northYaw to 360.
    set eastYaw to 90.

    set neededNorthPitch to min(max(arcCos(min(max((wantedNorthVelo - GetNorthVelo()) / MaxAcc(), -1), 1)), pitchLimit), (180 - pitchLimit)).
    set neededEastPitch to min(max(arcCos(min(max((wantedEastVelo - GetEastVelo()) / MaxAcc(), -1), 1)), pitchLimit), (180 - pitchLimit)).

    return heading(eastYaw, neededEastPitch, 0).
}.
