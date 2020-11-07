# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source ../pmspRecurrent.tcl
source ../util/activations.tcl

set epochs 2000
set weights_path "../../../var/saved-weights"
set examples_path "../../../usr/examples"
set results_path "../../../results"

seed 1
pmspRecurrentSimulation "pmsp"

# load a network that has been already trained
loadWeights "${weights_path}/recurrent-epoch-${epochs}-pmsp.wt.gz"

# load the base PMSP vocabulary for testing
loadExamples "${examples_path}/pmsp-train.ex" -s test

global log_outputs_filename
set log_outputs_filename [open "${results_path}/recurrent-${epochs}-activations-output.txt" w ]

global log_hidden_filename
set log_hidden_filename [open "${results_path}/recurrent-${epochs}-activations-hidden.txt" w ]

# install hook to log activations
setObj postExampleProc { log_activations_hook }

# Need to view units to be able to access the history arrays.
viewUnits

test

close $log_outputs_filename
close $log_hidden_filename
