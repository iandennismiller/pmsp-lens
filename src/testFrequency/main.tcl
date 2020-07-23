# Test whether PERMUTED scales by example frequency
# 2020-01-13

addNet xor
addGroup input 2 INPUT
addGroup hidden 2
addGroup output 1 OUTPUT
connectGroups input hidden -p FULL
connectGroups hidden output -p FULL

loadExamples test-xor.ex -s train
exampleSetMode train ORDERED
# exampleSetMode train PERMUTED

loadExamples train-xor.ex -s test

viewUnits
graphObject

resetNet

setObj learningRate 0.5
# setObj weightDecay 0.0001
setObj trainGroupCrit 0.98
setObj randRange 0.5
setObj bias.randMean -1.85
setObj reportInterval 10
setLinkValues randMean -1.85 -t bias

# coax network to settle
train -a steepest -setOnly
setObj momentum 0.0
train 10

train -a "deltaBarDelta" -setOnly
setObj momentum 0.9
train 100
