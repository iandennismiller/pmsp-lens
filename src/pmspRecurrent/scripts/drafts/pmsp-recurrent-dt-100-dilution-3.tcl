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

set random_seed 1
set dilution_amount 3

# reproducible
seed $random_seed

# unique name of this script, for naming saved weights
set script_name "pmsp-recurrent-dt-100-dilution-$dilution_amount-seed-$random_seed"
# mkdir var/results/$script_name
# mkdir var/weights/$script_name

# all relative to ./scripts
set root_path "../../.."
set weights_path "${root_path}/var/weights/${script_name}"
set examples_path "${root_path}/usr/examples"
set results_path "${root_path}/var/results/${script_name}"

# global log_outputs_filename
# set log_outputs_filename [open "${results_path}/activations-output.txt" w ]

# global log_hidden_filename
# set log_hidden_filename [open "${results_path}/activations-hidden.txt" w ]

###
# Network Architecture

set dt 100

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
    saveWeights "${weights_path}/${epoch}.wt.gz"
}
setObj postEpochProc { save_weights_hook }

# source ../util/activations.tcl
# setObj postExampleProc { log_activations_hook }
source ../util/accuracy.tcl
set loggingInterval 1
setObj postExampleProc { logAccuracyHook }

###
# Examples

# load frequency-dilution vocab and anchors

# replace 0.69314718 with 0.000085750
# n=1 replace 2.484906650 with (6 - (2998*0.000085750)) / 30 = 0.1914307167
# n=2 replace 1.945910149 with (6 - (2998*0.000085750)) / 60 = 0.09571535833
# n=2 replace 1.673976434 with (6 - (2998*0.000085750)) / 90 = 0.06381023889
set example_file "${root_path}/usr/examples/pmsp-added-anchors-the-normalized-n${dilution_amount}.ex"
loadExamples $example_file -s "vocab_anchors"
exampleSetMode "vocab_anchors" PERMUTED
useTrainingSet "vocab_anchors"

# "error is injected only for the second unit of time; units receive no direct pressure to be correct for the first unit of time (although back-propagated internal error causes weight changes that encourage units to move towards the appropriate states as early as possible"
# this prevents error from being computed until after the graceTime has passed.
setObj vocab_anchors.minTime 2.0
setObj vocab_anchors.maxTime 2.0
setObj vocab_anchors.graceTime 1.0

# Need to view units to be able to access the history arrays.
# ensure it updates per example, not per batch
# (updates 3: update after each example)
viewUnits -updates 3

# loadWeights "${weights_path}/pmsp-study-3-replication-7-seed-1/1850.wt.gz"
# loadWeights "${weights_path}/jepg-2017-recurrent-dt-100-dilution-3-seed-1/2000.wt.gz"
loadWeights "${root_path}/var/weights/pmsp-recurrent-dt-100-seed-1/2000.wt.gz"

train -a "deltaBarDelta" -setOnly
setObj momentum 0.98
train 2000

# reset accumulated evidence
setObj learningRate 0
train -a steepest -setOnly
train 1

saveAccuracyResults "${results_path}/accuracy-training.tsv"
