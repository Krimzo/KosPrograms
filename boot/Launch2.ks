core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
print ("IPU: " + config:ipu).
print ("Press any key to start:").
terminal:input:getchar().

stage.
runPath("0:Hover.ks").
