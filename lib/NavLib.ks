function GetHeading {
  return mod(360 - latlng(90, 0):bearing, 360).
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
function TrueRadarAlt {
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
function GetLandingCoords {
  set currentCoords to latlng(latitude, longitude).

}.
