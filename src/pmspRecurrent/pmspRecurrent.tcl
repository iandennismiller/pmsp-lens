# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source util/logger.tcl
source model/examples.tcl
source model/training.tcl
source model/testing.tcl
source model/network_recurrent.tcl
source model/network_feed_forward.tcl


proc pmspRecurrentSimulation { label dt } {
    # create PMSP network
    pmspRecurrentNetwork $label $dt

    # setObj numUpdates 700
    # "lens lr" must be double to correct for missing '*2'; actual is 0.0008
    # setObj learningRate 0.0008
    setObj learningRate 0.00016
    # setObj learningRate 0.05
    setObj weightDecay 0.00000
    # setObj weightDecay 0.00000
    # setObj trainGroupCrit 0.5
    setObj randRange 0.1
    setObj reportInterval 10
    setObj targetRadius 0.1
    setObj pseudoExampleFreq 1
    # setObj input.initInput 0
    # setObj input.initOutput 0.5

    # "error is injected only for the second unit of time; units receive no direct pressure to be correct for the first unit of time (although back-propagated internal error causes weight changes that encourage units to move towards the appropriate states as early as possible"
    # this prevents error from being computed until after the graceTime has passed.
    setObj vocab.minTime 2.0
    setObj vocab.maxTime 2.0
    setObj vocab.graceTime 1.0

    # setObj bias.randMean -1.85
    # setLinkValues randMean -1.85 -t bias
}
