# PMSP Replication
# 2019 Ian Dennis Miller

proc printLayer {group unit} {
    format "%s\t%-3d\t%.3f\n" [getObj $group.name] [getObj $unit.num] \
        [getObj $unit.output]
}

# setObj postExampleProc {
#     printUnitValues outputs.gz printLayer { input hidden } -a
# }

addNet pmsp
addGroup input 105 INPUT
addGroup hidden 100
addGroup output 61 OUTPUT
connectGroups input hidden -p FULL
connectGroups hidden output -p FULL

loadExamples pmsp-regular-train.ex -s train
loadExamples pmsp-regular-test.ex -s test
exampleSetMode train PROBABILISTIC

setObj numUpdates 700
setObj learningRate 0.00005
setObj weightDecay 0.001
setObj trainGroupCrit 0.5
setObj randRange 0.1
setObj bias.randMean -1.85
setLinkValues randMean -1.85 -t bias

viewUnits
# graphObject
# train -a "deltaBarDelta" -setOnly
train -a steepest -setOnly
resetNet
# train
# test
