# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source ../model/pmspRecurrent.tcl

# viewUnits
# graphObject

# reproducible results
seed 1

# initialize simulation with dilution amount = 1
pmspRecurrentSimulation 1

# initialize logging with an interval of 1
Logger 1

setObj postExampleProc {log_activations_hook}
# Need to view units to be able to access the history arrays.
viewUnits
# graphObject

set epochs 700

global log_outputs_filename
set log_outputs_filename [open "../../../results/recurrent-${epochs}-activations-output.txt" w ]

global log_hidden_filename
set log_hidden_filename [open "../../../results/recurrent-${epochs}-activations-hidden.txt" w ]

loadWeights "../../../var/saved-weights/recurrent-epoch-${epochs}.wt.gz"
loadExamples ../../../usr/examples/pmsp-train.ex -s test
test
close $log_outputs_filename
close $log_hidden_filename

setObj postExampleProc {}
