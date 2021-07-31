function GetVecType {
  parameter ves,thing.
  if thing:istype("vector") {
    return thing:normalized.
  } 
  if thing:istype("direction") {
    return thing:forevector.
  } 
  if thing:istype("vessel") or thing:istype("part") {
    return thing:facing:forevector.
  } 
  if thing:istype("geoposition") or thing:istype("waypoint") {
    return (thing:position - ves:position):normalized.
  } 
  return 1 / 0.
}.

function GetHeading {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to GetVecType(ves,thing).
  }

  local east is vcrs(ship:up:vector, ship:north:vector).

  local trig_x is vdot(ves:north:vector, pointing).
  local trig_y is vdot(east, pointing).

  local result is arctan2(trig_y, trig_x).

  if result < 0 {
    return (360 + result).
  } else {
    return result.
  }
}.
function GetPitch {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to GetVecType(ves,thing).
  }

  return (90 - vang(ves:up:vector, pointing)).
}.
function GetRoll {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing.
  if not thing:istype("string") {
    if thing:istype("vessel") or pointing:istype("part") {
      set pointing to thing:facing.
    } else if thing:istype("direction") {
      set pointing to thing.
    } else {
      print "type: " + thing:typename + " is not reconized by roll_for".
	}
  }

  local trig_x is vdot(pointing:topvector,ves:up:vector).
  if abs(trig_x) < 0.0035 {//this is the dead zone for roll when within 0.2 degrees of vertical
    return 0.
  } else {
    local vec_y is vcrs(ves:up:vector,ves:facing:forevector).
    local trig_y is vdot(pointing:topvector,vec_y).
    return arctan2(trig_y,trig_x).
  }
}.



