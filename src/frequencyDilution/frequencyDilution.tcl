# Warping: examining effects of frequency upon regularization
# 2020-01-12

source logger.tcl
source model.tcl

proc FrequencyDilution { amount } {
    # create PMSP Dilution model
    PMSPDilutionModel $amount

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
    setLinkValues randMean -1.85 -t bias
}

proc doTrainingTest {} {
    doTraining t
}

proc doTrainingFull {} {
    doTraining f
}

proc doTraining { testing } {
    puts "-----"
    puts "START: training"
    puts "-----"

    # load training examples
    loadExamples ../../examples/pmsp-train.ex -s vocab
    exampleSetMode vocab PERMUTED
    useTrainingSet vocab

    # coax network to settle
    train -a steepest -setOnly
    setObj momentum 0.0
    resetNet

    # if the "testing" parameter is true, exit early
    if { [expr {$testing == "t"} ] } {
        train 3
        return
    } else {
        train 25
    }

    # perform remaining training
    train -a "deltaBarDelta" -setOnly
    setObj momentum 0.85
    train 174

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
    set example_file "../../examples/pmsp-added-anchors-n${amount}.ex"
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
    loadExamples ../../examples/probes-new.ex -s test

    test
}
