function CurrentGravity {
    return body:mu / (altitude + body:radius)^2.
}.
function MaxAcc {
    return ship:availablethrust / ship:mass.
}.
function RealRAlt {
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

function StrParseInt {
    parameter inputString.
    set decimalDigits to "0123456789".
	set inputString to inputString:trim().
	set strLen to inputString:length-1.
	set parsedNum to 0.
    set sign to 1.
	for i in range(strLen, -1) {
		if (inputString[i] = "-" and i = 0) {
            set sign to -1. 
        }
		set legalDigit to decimalDigits:find(inputString[i]).
		if (legalDigit = -1) {
			print("Bad string input.").
			return 1/0.
		}
		set parsedNum to parsedNum + (legalDigit * 10^(strLen-i)).
	}
	return parsedNum * sign.
}
