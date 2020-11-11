# Quasiregularity
# 2019 Ian Dennis Miller
# Small-Scale Network, One Exception in Language
# Based on Psychol Rev. 2013 October; 120(4): 903–916. doi:10.1037/a0034195.

addNet exception
addGroup input 3 INPUT
addGroup hidden 3
addGroup output 3 OUTPUT
connectGroups input hidden -p FULL
connectGroups hidden output -p FULL

loadExamples small-exception-train.ex -s train
loadExamples small-exception-test.ex -s test

viewUnits
graphObject

# setObj postTrialProc {puts [getObject group(2).unit(0).output]}
# foreach x [getObject group(2).output] { puts $x }
# puts [getObject group(2).output(0)]

proc printLayer {group unit} {
    format "%s\t%-3d\t%.3f\n" [getObj $group.name] [getObj $unit.num] \
        [getObj $unit.output]
}

setObj postExampleProc {
    printUnitValues outputs.gz printLayer { input hidden } -a
}

setObj numUpdates 150
# setObj learningRate 0.01
setObj weightDecay 0.0001
setObj trainGroupCrit 0.5
train -a steepest -setOnly

resetNet

train
test

# exit
