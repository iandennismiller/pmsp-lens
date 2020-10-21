# Warping: examining effects of frequency upon regularization
# 2020-01-12

source frequencyDilution.tcl

# viewUnits
# graphObject

# reproducible results
seed 1

# initialize simulation with dilution amount = 1
FrequencyDilution 1

# initialize logging with an interval of 1
Logger 1

# train full schedule
doTrainingFull

# saveWeights ../results/dilution-epoch-400.wt.gz
saveWeights ../../results/dilution-epoch-200.wt.gz

# saveAccuracyResults "../results/train-debug-target-vowel-accuracy.tsv"
# saveAccuracyResults "../results/train-debug-most-active-vowel-accuracy.tsv"
# saveAccuracyResults "../results/train-debug-all-vowels-accuracy.tsv"
# saveAccuracyResults "../results/train-debug-criteria.tsv"
# saveAccuracyResults "../results/train-debug-momentum-learning-085.tsv"
# saveAccuracyResults "../results/train-debug-20-steepest-momentum-learning-085.tsv"
# saveAccuracyResults "../results/train-debug-20-steepest-dbd-momentum-90.tsv"
# saveAccuracyResults "../results/train-debug-50-steepest-dbd-momentum-90.tsv"
# saveAccuracyResults "../results/train-debug-10-steepest-dbd-momentum-85.tsv"
# saveAccuracyResults "../results/train-debug-10-steepest-momentum-085-600-epochs.tsv"
# saveAccuracyResults "../results/train-debug-10-steepest-momentum-085-800-epochs.tsv"
# saveAccuracyResults "../results/train-debug-just-dbd-low-momentum.tsv"
# saveAccuracyResults "../results/train-debug-pseudoexamplefreq.tsv"
# saveAccuracyResults "../results/train.tsv"
saveAccuracyResults "../../results/train-200.tsv"

exit
