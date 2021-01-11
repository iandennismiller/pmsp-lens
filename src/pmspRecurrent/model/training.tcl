# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

set delta_bar_delta_momentum 0.85

# num_epochs: how many epochs to train for.
proc train_base_vocabulary { num_epochs weights_path examples_path } {
    global delta_bar_delta_momentum

    puts "-----"
    puts "START: training"
    puts "-----"

    # load training examples
    introduce_base_vocabulary $examples_path

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
    setObj momentum $delta_bar_delta_momentum
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

proc train_anchors { dilution_amount base_vocab_epochs anchors_epochs weights_path examples_path } {
    global delta_bar_delta_momentum

    puts "-----"
    puts "Load trained base vocabulary weights: epoch = ${base_vocab_epochs}"
    puts "-----"

    loadWeights "${weights_path}/recurrent-epoch-${base_vocab_epochs}-pmsp.wt.gz"

    puts "-----"
    puts "Introduce anchors: dilution amount = ${dilution_amount}"
    puts "-----"

    introduce_anchors $dilution_amount $examples_path

    puts "-----"
    puts "Train using delta-bar-delta with base vocab plus anchors: dilution level = ${dilution_amount}, epochs = ${anchors_epochs} momentum = ${delta_bar_delta_momentum}"
    puts "-----"

    train -a "deltaBarDelta" -setOnly
    setObj momentum $delta_bar_delta_momentum
    setObj learningRate 0.0008
    train $anchors_epochs

    set total_epochs [expr $base_vocab_epochs + $anchors_epochs]

    saveWeights "${weights_path}/recurrent-epoch-${total_epochs}-dilution-${dilution_amount}.wt.gz"
}
