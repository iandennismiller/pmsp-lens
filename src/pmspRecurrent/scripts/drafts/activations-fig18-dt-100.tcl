# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

# source ../pmspRecurrent.tcl
source ../util/activations.tcl

set stage 1

# we start with dt = 5, then dt = 20, and finally dt = 100
if { $stage == 1 } {
    set dt 100
    set start_epoch 0
    set end_epoch 1900
}
# if { $stage == 2 } {
#     set dt 20
#     set start_epoch 1801
#     set end_epoch 1850
# }
# if { $stage == 3 } {
#     set dt 100
#     set start_epoch 1851
#     set end_epoch 1900
# }

# these are relative to ./scripts
set weights_path "/home/idm/scratch/pmsp-weights/pmsp-study-3-replication-7"
set examples_path "../../../usr/examples"
set results_path "../../../var/results/2021-03-29-dt-100-2"

global log_outputs_filename
set log_outputs_filename [open "${results_path}/activations-output.txt" w ]

global log_hidden_filename
set log_hidden_filename [open "${results_path}/activations-hidden.txt" w ]

seed 1

###
# Network Architecture

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

setObj learningRate 0.05
setObj momentum 0.98

# p. 28 "the slight tendency for weights to decay towards zero was removed, to prevent the very small weight changes induced by low-frequency words - due to their very small scaling factors - from being overcome by the tendency of weights to shrink towards zero."
setObj weightDecay 0.00000

# "output units are trained to targets of 0.1 and 0.9"
setObj targetRadius 0.1

loadExamples "${examples_path}/fig18-test.ex" -s vocab
exampleSetMode vocab PERMUTED
useTrainingSet vocab

setObj vocab.minTime 2.0
setObj vocab.maxTime 2.0
setObj vocab.graceTime 1.0

# install hook to log activations
setObj postExampleProc { log_activations_hook }

# Need to view units to be able to access the history arrays.
# TODO: ensure it updates per example, not per batch
# (updates 3: update after each example)
viewUnits -updates 3
# viewUnits
# could set target history property?
# consider testing the "-numexamples 2" and manually run through a couple

# For now, manually set the epoch
# set epoch 2000

for { set epoch $start_epoch } { $epoch <= $end_epoch } { incr epoch 1 } {
    puts "value of epoch: $epoch"

    # load a network that has been already trained
    resetNet
    loadWeights "${weights_path}/${epoch}.wt.gz"

    # `test` doesn't provide access to hidden units via postExampleProc
    # use train instead
    # test
    train 1

}

close $log_outputs_filename
close $log_hidden_filename

exit
