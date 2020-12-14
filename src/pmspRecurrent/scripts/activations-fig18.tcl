# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source ../pmspRecurrent.tcl
source ../util/activations.tcl

set num_epochs 2000
set weights_path "../../../var/saved-weights-recurrent-dt-20"
set examples_path "../../../usr/examples"
set results_path "../../../results/2020-12-12"

global log_outputs_filename
set log_outputs_filename [open "${results_path}/recurrent-training-activations-output.txt" w ]

global log_hidden_filename
set log_hidden_filename [open "${results_path}/recurrent-training-activations-hidden.txt" w ]

seed 1
pmspRecurrentSimulation "pmsp"

# load the base PMSP vocabulary for testing
# loadExamples "${examples_path}/pmsp-train.ex" -s test
introduce_base_vocabulary $examples_path

loadExamples "${examples_path}/fig18-test.ex" -s test

# install hook to log activations
setObj postExampleProc { log_activations_hook }

# Need to view units to be able to access the history arrays.
viewUnits

for { set epoch 0 }  { $epoch <= 2000 } { incr epoch 100 } {
    puts "value of epoch: $epoch"

    # load a network that has been already trained
    resetNet
    loadWeights "${weights_path}/recurrent-epoch-${epoch}-pmsp.wt.gz"

    train 1

    test
}

close $log_outputs_filename
close $log_hidden_filename

exit
