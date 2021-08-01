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

    set neededNorthVelo to (wantedNorthVelo - GetNorthVelo()).
    set neededEastVelo to (wantedEastVelo - GetEastVelo()).
    set totalNeededVelo to (abs(neededNorthVelo) + abs(neededEastVelo)).

    if (not(neededNorthVelo = 0) and not(neededEastVelo = 0)) {
        if (neededEastVelo < 0) {
            set neededYaw to (360 - arcCos(neededNorthVelo / sqrt(neededEastVelo^2 + neededNorthVelo^2))).
        }
        else {
            set neededYaw to (arcCos(neededNorthVelo / sqrt(neededEastVelo^2 + neededNorthVelo^2))).
        }
    }
    else {
        set neededYaw to 0.
    }

    set neededNorthPitch to max(arcCos(min(max(neededNorthVelo / MaxAcc(), -1), 1)), pitchLimit).
    set neededNorthPitch to min(neededNorthPitch, (180 - neededNorthPitch)).
    set neededEastPitch to max(arcCos(min(max(neededEastVelo / MaxAcc(), -1), 1)), pitchLimit).
    set neededEastPitch to min(neededEastPitch, (180 - neededEastPitch)).

    if (totalNeededVelo > 0) {
        set neededPitch to (abs(neededNorthPitch * (neededNorthVelo / totalNeededVelo)) + abs(neededEastPitch * (neededEastVelo / totalNeededVelo))).
    }
    else {
        set neededPitch to 90.
    }

    return heading(neededYaw, neededPitch, 180).
}.
