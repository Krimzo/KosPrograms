function GetHeading {
  local result is arctan2(vdot(vcrs(ship:up:vector, ship:north:vector), ship:facing:forevector), vdot(ship:north:vector, ship:facing:forevector)).
  if result < 0 {
    return (360 + result).
  }
  return result.
}.
function GetPitch {
  return (90 - vang(ship:up:vector, ship:facing:forevector)).
}.
function GetNorthVelo {
    return vdot(ship:velocity:surface, ship:north:forevector).
}.
function GetEastVelo {
    return -vdot(ship:velocity:surface, ship:north:starvector).
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

