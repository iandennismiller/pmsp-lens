# Warping: examining effects of frequency upon regularization
# 2020-01-12

source ../util/logger.tcl
source network.tcl

proc pmspRecurrentSimulation { amount } {
    # create PMSP network
    pmspRecurrentNetwork $amount

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

# num_epochs: how many epochs to train for.
proc doTraining { num_epochs } {
    puts "-----"
    puts "START: training"
    puts "-----"

    # load training examples
    loadExamples ../../../usr/examples/pmsp-train.ex -s vocab
    exampleSetMode vocab PERMUTED
    useTrainingSet vocab

    # this prevents error from being computed until after the graceTime has passed.
    setObj vocab.minTime 2.0
    setObj vocab.maxTime 2.0
    setObj vocab.graceTime 1.0

    # coax network to settle
    train -a steepest -setOnly
    setObj momentum 0.0
    resetNet

    # if a value below 25 epochs is provided, then this is a debugging run
    if {$num_epochs <= 25} {
        train 3
        set num_epochs_dbd 1
    } else {
        # otherwise, run first 25 epochs with gradient descent
        train 25
        set num_epochs_dbd [expr $num_epochs - 25]
        puts "will train with DBD for ${num_epochs_dbd} epochs"
    }

    # perform remaining training with delta-bar-delta
    train -a "deltaBarDelta" -setOnly
    setObj momentum 0.85
    train $num_epochs_dbd

    # reset accumulated evidence
    setObj learningRate 0
    train -a steepest -setOnly
    train 1

    puts "-----"
    puts "END: training"
    puts "-----"
}

proc introduceAnchors { amount } {
    # load frequency-dilution vocab and anchors
    set example_file "../../../usr/examples/pmsp-added-anchors-n${amount}.ex"
    loadExamples $example_file -s "vocab_anchors${amount}"
    exampleSetMode "vocab_anchors${amount}" PERMUTED
    useTrainingSet "vocab_anchors${amount}"

    train -a "deltaBarDelta" -setOnly
    setObj momentum 0.9
    setObj learningRate 0.0008

    # train 200
    train 50
}

proc doTest {} {
    # load testing examples
    loadExamples ../../../usr/examples/probes-new.ex -s test

    test
}
