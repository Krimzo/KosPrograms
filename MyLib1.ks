function CurrentGravity {
    return body:mu / (altitude + body:radius)^2.
}.
function MaxAcc {
    return ship:availablethrust / ship:mass.
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
function PosVerDis {
    return (verticalSpeed^2) / (2 * CurrentGravity()).
}.
function NegVerDis {
    return (verticalSpeed^2) / (2 * MaxAcc() - 2 * CurrentGravity()).
}.
function HoverThrottle {
    parameter wantedAltitude.
    if((wantedAltitude - altitude) < 0){
        return (2 * (wantedAltitude - (altitude - NegVerDis())) + CurrentGravity() - (2 * ship:verticalspeed)) / MaxAcc().
    }
    return (2 * (wantedAltitude - (PosVerDis() + altitude)) + CurrentGravity() - (2 * ship:verticalspeed)) / MaxAcc().
}.
global decimalDigits is "0123456789".
function StrParseInt {
    parameter inputString.
	set inputString to inputString:trim().
	set strLen to inputString:length.
	set parsedNum to 0.
    set sign to 1.
	for i in range(0, strLen, 1) {
		if (inputString[i] = "-") {
            if (i = 0) {
                set sign to -1. 
            }
            else {
                print("Couldn't parse scalar. Bad string input.").
			    return 1/0.
            }
        }
        else {
		    set digitPos to decimalDigits:find(inputString[i]).
		    if (digitPos = -1) {
			    print("Couldn't parse scalar. Bad string input.").
			    return 1/0.
		    }
		    set parsedNum to parsedNum + (digitPos * 10^(strLen - 1 - i)).
        }
	}
	return parsedNum * sign.
}.
