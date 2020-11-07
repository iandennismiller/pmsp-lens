# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source ../model/pmspRecurrent.tcl

set dilution_amounts { 1 }
set base_vocab_epochs 2000
set anchors_epochs 2000
set weights_path "../../../var/saved-weights"
set examples_path "../../../usr/examples"
set results_path "../../../results"

foreach dilution_amount $dilution_amounts {
    seed 1
    pmspRecurrentSimulation $dilution_amount
    # initialize logging with an interval of 1
    # Logger 1
    train_anchors $dilution_amount $base_vocab_epochs $anchors_epochs $weights_path $examples_path
}

# saveAccuracyResults "${results_path}/recurrent-test.tsv"

exit
