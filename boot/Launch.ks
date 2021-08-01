core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
print("Press any key to launch:").
terminal:input:getchar().
from {local i is 3.} until (i = 0) step {set i to i-1.} do {
  print("T -" + i).
  wait(1).
}

lock throttle to 0.0.
lock steering to heading(110.5, 79).
stage.

clearScreen.
print("Liftoff!").
wait(2).

print("Waiting for booster flameout.").
list engines in engineList.
set boosterFlameout to false.
until boosterFlameout {
    for engine in engineList {
        if engine:flameout {
            set boosterFlameout to true.
            break.
        }
    }
}
print("Booster dead").
wait(2).

stage.
print("Booster ditched").
wait(1).

runPath("0:AutoLand.ks").
