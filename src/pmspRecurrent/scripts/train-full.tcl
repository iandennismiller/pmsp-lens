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

# train full schedule
set num_epochs 350
doTraining $num_epochs

# saveAccuracyResults "../../../results/recurrent-$num_epochs.tsv"
saveWeights "../../../results/recurrent-epoch-$num_epochs.wt.gz"

exit
