# Warping: examining effects of frequency upon regularization
# 2020-01-12

source pmspRecurrent.tcl

# viewUnits
# graphObject

# reproducible results
seed 1

# initialize simulation with dilution amount = 1
pmspRecurrentSimulation 1

# initialize logging with an interval of 1
Logger 1

# train in testing mode, which exist early
doTrainingTest

saveAccuracyResults "../../results/recurrent-test.tsv"

exit
