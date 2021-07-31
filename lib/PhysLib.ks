function CurrentGravity {
    return body:mu / (altitude + body:radius)^2.
}.
function MaxAcc {
    return ship:availablethrust / ship:mass.
}.

function GetHorizVeloHead {
    set horizontalHeading to arctan2(vdot(srfPrograde:vector, vcrs(ship:up:vector, ship:north:vector)), vdot(srfPrograde:vector, ship:north:vector)).
    if (horizontalHeading < 0) {
        return (horizontalHeading + 360).
    }
    return horizontalHeading.
}.
function GetNorthVelo {
    return (cos(-GetHorizVeloHead()) * ship:groundspeed).
}.
function GetEastVelo {
    return -(sin(-GetHorizVeloHead()) * ship:groundspeed).
}.

function PosVerDis {
    return (verticalSpeed^2) / (2 * CurrentGravity()).
}.
function NegVerDis {
    return (verticalSpeed^2) / (2 * MaxAcc() - 2 * CurrentGravity()).
}.
function RealRadarAlt {
    list parts in partList.
    set lowestPart to 0.
    set highestPart to 0.
    for part in partList {
        set currentPart to facing:vector * part:position.
        if currentPart < lowestPart {
	        set lowestPart to currentPart.
        }
        else if currentPart > highestPart {
	        set highestPart to currentPart.
        }
    }
    return alt:radar - (highestPart - lowestPart).
}.