# Warping: examining effects of frequency upon regularization
# 2020-01-12

source ../util/logger.tcl
source network.tcl

set weights_path "../../../var/saved-weights"

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


proc run_experiment { dilution_amounts num_epochs test_procedure } {
    global weights_path
    foreach dilution_amount $dilution_amounts {
        # reproducible results
        seed 1

        # initialize simulation with dilution amount
        pmspRecurrentSimulation $dilution_amount

        # initialize logging with an interval of 1
        Logger 1

        puts "-----"
        puts "Test: dilution amount = ${dilution_amount}, epochs = ${num_epochs}"
        puts "-----"

        loadWeights "${weights_path}/recurrent-epoch-${num_epochs}-dilution-${dilution_amount}.wt.gz"

        $test_procedure

        saveAccuracyResults "../../../results/recurrent-epoch-${num_epochs}-dilution-${dilution_amount}.tsv"
    }
}


proc train_anchors { dilution_amount base_vocab_epochs anchors_epochs } {
    global weights_path
    set delta_bar_delta_momentum 0.85

    puts "-----"
    puts "Load trained base vocabulary weights: epoch = ${base_vocab_epochs}"
    puts "-----"

    loadWeights "${weights_path}/recurrent-epoch-${base_vocab_epochs}-pmsp.wt.gz"

    puts "-----"
    puts "Introduce anchors: dilution amount = ${dilution_amount}"
    puts "-----"

    introduceAnchors $dilution_amount

    puts "-----"
    puts "Train using delta-bar-delta with base vocab plus anchors: dilution level = ${dilution_amount}, epochs = ${anchors_epochs} momentum = ${delta_bar_delta_momentum}"
    puts "-----"

    train -a "deltaBarDelta" -setOnly
    setObj momentum $delta_bar_delta_momentum
    train $anchors_epochs

    set total_epochs [expr $base_vocab_epochs + $anchors_epochs]

    saveWeights "${weights_path}/recurrent-epoch-${total_epochs}-dilution-${dilution_amount}.wt.gz"
}


# num_epochs: how many epochs to train for.
proc train_base_vocabulary { num_epochs } {
    global weights_path

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

    saveWeights "${weights_path}/recurrent-epoch-${num_epochs}-pmsp.wt.gz"
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
}

proc test_base {} {
    loadExamples "../../../usr/examples/pmsp-train.ex" -s test
    test
}

proc test_anchors {} {
    loadExamples "../../../usr/examples/anchors-n1.ex" -s test
    test
}

proc test_probes {} {
    loadExamples "../../../usr/examples/probes-new.ex" -s test
    test
}

proc test_anchors_probes {} {
    loadExamples "../../../usr/examples/pmsp-added-anchors-n1.ex" -s test
    test
}
