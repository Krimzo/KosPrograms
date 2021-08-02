function CurrentGravity {
    return body:mu / (altitude + body:radius)^2.
}.
function MaxAcc {
    return ship:availablethrust / ship:mass.
}.
function PosVerDis {
    return (verticalSpeed^2) / (2 * CurrentGravity()).
}.
function NegVerDis {
    return (verticalSpeed^2) / (2 * MaxAcc() - 2 * CurrentGravity()).
}.
