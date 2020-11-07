# Warping: examining effects of frequency upon regularization
# 2020-01-12

source ../model/pmspRecurrent.tcl

# viewUnits
# graphObject

# reproducible results
seed 1

# initialize simulation with dilution amount = 1
pmspRecurrentSimulation 1

# initialize logging with an interval of 1
Logger 1

set dilution_amounts { 1 }
set base_vocab_epochs 2000
set anchors_epochs 10

foreach dilution_amount $dilution_amounts {
    train_anchors $dilution_amount $base_vocab_epochs $anchors_epochs
}

# saveAccuracyResults "../../../results/recurrent-test.tsv"

exit
