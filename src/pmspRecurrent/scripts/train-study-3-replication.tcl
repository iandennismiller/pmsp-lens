# pmsp-lens
# Ian Dennis Miller
# 2021-03-08

####
# Timeline
# - epoch 0
#   - targetRadius = 0.1 ("output units are trained to targets of 0.1 and 0.9")
#   - learning rate = 0.05 ("the global learning rate ... was increased from 0.001 to 0.05")
#   - weight decay = 0.0 ("the slight tendency for weights to decay towards zero was removed)
#   - delta-bar-delta ("adaptive connection-specific rates")
#   - momentum = 0.9
#   - time intervals = 2 ("the network is run for 2.0 units of time")
#   - ticks per interval: dt = 5 ("the network was trained using a discretization _d_ = 0.2")
#  - "units update their states 10 times (2.0/0.2) in the forward pass"
# - epoch 200
#   - momentum = 0.98
# - epoch 1800
#   - dt = 20 ("... _d_ was reduced from 0.2 to 0.05")
# - epoch 1850
#   - dt = 100 ("... reduced further to 0.01")
# - epoch 1900
#   - exit

# reproducible
seed 1

# unique name of this script, for naming saved weights
set script_name "pmsp-study-3-replication"

set stage 3

# all relative to ./scripts
set root_path "../../.."
set weights_path "/home/idm/scratch/pmsp-weights"
set examples_path "${root_path}/usr/examples"
set results_path "${root_path}/var/results/2021-03-08"

###
# Network Architecture

# we start with dt = 5, then dt = 20, and finally dt = 100
if { $stage == 1 } {
    set dt 5
}
if { $stage == 2 } {
    set dt 20
}
if { $stage == 3 } {
    set dt 100
}

addNet "pmspRecurrent" -i 2 -t $dt CONTINUOUS

# input layer
addGroup ortho_onset 30 INPUT
addGroup ortho_vowel 27 INPUT
addGroup ortho_coda 48 INPUT

# hidden layer
addGroup hidden 100 IN_INTEGR

# output layer
addGroup phono_onset 23 OUTPUT IN_INTEGR CROSS_ENTROPY
addGroup phono_vowel 14 OUTPUT IN_INTEGR CROSS_ENTROPY
addGroup phono_coda 24 OUTPUT IN_INTEGR CROSS_ENTROPY

# connections
connectGroups ortho_onset hidden -p FULL
connectGroups ortho_vowel hidden -p FULL
connectGroups ortho_coda hidden -p FULL
connectGroups hidden phono_onset -p FULL -bidirectional
connectGroups hidden phono_vowel -p FULL -bidirectional
connectGroups hidden phono_coda -p FULL -bidirectional
connectGroups {phono_onset phono_vowel phono_coda} {phono_onset phono_vowel phono_coda}

useNet "pmspRecurrent"

###
# Parameters

# "the global learning rate ... was increased from 0.001 to 0.05, to compensate for the fact that the summed frequency for the entire training corpus is reduced from 683.4 to 6.05 when using actual rather than logarithmic frequencies."
# How to sum frequencies in examples file:
# echo $(grep freq pmsp-train.ex | cut -d ' ' -f2 | sed 's/$/+/') 0 | bc
# echo $(cat plaut_dataset_collapsed.csv|cut -d',' -f5 | tr -d $'\r' | sed 's/$/+/') 0 | bc
# df = pd.read_csv('../pmsp-torch/pmsp/data/plaut_dataset_collapsed.csv')
# sum([math.log(2+x) for x in df['freq']])
# Our sum: 8208.649287087

# setObj learningRate 0.00016
setObj learningRate 0.05

# p. 28 "the slight tendency for weights to decay towards zero was removed, to prevent the very small weight changes induced by low-frequency words - due to their very small scaling factors - from being overcome by the tendency of weights to shrink towards zero."
setObj weightDecay 0.00000

# "output units are trained to targets of 0.1 and 0.9"
setObj targetRadius 0.1

# setObj trainGroupCrit 0.5

# what is randRange accomplishing?
# setObj randRange 0.1

# diagnostic parameter not related to replication
setObj reportInterval 10

# example frequencies are caclulated as log(2 + kucera-and-francis-count, e)
# "In order to improve performance on the XOR task, we might think of trying to weight the examples presented to the network more heavily in favor of the ones it gets wrong. One way to do this is to activate pseudo-example-frequencies by setting the network's pseudoExampleFreq to 1. The error on an example will then be scaled by the example's frequency value."
# pseudoExampleFreq is 1 in order to use frequencies in examples file
setObj pseudoExampleFreq 1

# this routine will save weights to the proper path
proc save_weights_hook {} {
    global weights_path
    global script_name
    set epoch [ getObj totalUpdates ]
    saveWeights "${weights_path}/${script_name}/${epoch}.wt.gz"
}
setObj postEpochProc { save_weights_hook }

# perform actual training
loadExamples "${examples_path}/pmsp-train.ex" -s vocab
exampleSetMode vocab PERMUTED
useTrainingSet vocab

# "error is injected only for the second unit of time; units receive no direct pressure to be correct for the first unit of time (although back-propagated internal error causes weight changes that encourage units to move towards the appropriate states as early as possible"
# this prevents error from being computed until after the graceTime has passed.
setObj vocab.minTime 2.0
setObj vocab.maxTime 2.0
setObj vocab.graceTime 1.0

# Stage 1: dt = 5
if { $stage == 1 } {
    # coax network to settle
    train -a steepest -setOnly
    setObj momentum 0.0
    resetNet
    train 10

    # perform remaining training with delta-bar-delta
    train -a "deltaBarDelta" -setOnly
    setObj momentum 0.9
    train 190

    setObj momentum 0.98
    train 1600

    # reset accumulated evidence
    setObj learningRate 0
    train -a steepest -setOnly
    train 1
}

# setTime -t 20

# Stage 2: dt = 20
if { $stage == 2 } {
    # load weights
    loadWeights "${weights_path}/${script_name}/1800.wt.gz"

    train -a "deltaBarDelta" -setOnly
    setObj momentum 0.98
    train 50
}

setTime -t 100

# Stage 3: dt = 100
# if { $stage == 3 } {
    # load weights
    # loadWeights "${weights_path}/${script_name}/1849.wt.gz"

    # train -a "deltaBarDelta" -setOnly
    # setObj momentum 0.98
    train 50
# }

# saveAccuracyResults "${results_path}/recurrent-$num_epochs.tsv"

exit
