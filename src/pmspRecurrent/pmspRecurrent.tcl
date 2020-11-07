# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source util/logger.tcl
source model/examples.tcl
source model/training.tcl
source model/testing.tcl
source model/network_recurrent.tcl
source model/network_feed_forward.tcl


proc pmspRecurrentSimulation { label } {
    # create PMSP network
    pmspRecurrentNetwork $label

    # setObj numUpdates 700
    # "lens lr" must be double to correct for missing '*2'; actual is 0.0008
    # setObj learningRate 0.0008
    setObj learningRate 0.00016
    setObj weightDecay 0.000001
    # setObj trainGroupCrit 0.5
    setObj randRange 0.1
    setObj bias.randMean -1.85
    setObj reportInterval 10
    setObj targetRadius 0.1
    setObj pseudoExampleFreq 1
    # setObj input.initInput 0
    # setObj input.initOutput 0.5
    setLinkValues randMean -1.85 -t bias
}
