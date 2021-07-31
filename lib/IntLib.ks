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
