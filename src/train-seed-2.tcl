# Warping: examining effects of frequency upon regularization
# 2020-01-12

source frequencyDilution/frequencyDilution.tcl

# viewUnits
# graphObject

# reproducible results
seed 2

# initialize simulation with dilution amount = 1
FrequencyDilution 1

# initialize logging with an interval of 1
Logger 1

# train full schedule
doTrainingFull

saveWeights ../results/dilution-seed-2-epoch-400.wt.gz

saveAccuracyResults "../results/train-seed-2.tsv"

exit
