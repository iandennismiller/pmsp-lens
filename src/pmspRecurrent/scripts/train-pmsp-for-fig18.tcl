# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source ../pmspRecurrent.tcl
source ../util/activations.tcl

set num_epochs 2000
set weights_path "../../var/saved-weights-debug"
set examples_path "../../../usr/examples"
set results_path "../../var/results/2021-01-17"

seed 1
pmspRecurrentSimulation "pmsp"

loadExamples "${examples_path}/fig18-test.ex" -s test

global log_outputs_filename
set log_outputs_filename [open "${results_path}/recurrent-${num_epochs}-activations-output.txt" w ]

global log_hidden_filename
set log_hidden_filename [open "${results_path}/recurrent-${num_epochs}-activations-hidden.txt" w ]

# install hook to log activations
setObj postExampleProc { log_activations_hook }

# Need to view units to be able to access the history arrays.
viewUnits

train_base_vocabulary $num_epochs $weights_path $examples_path

close $log_outputs_filename
close $log_hidden_filename

# saveAccuracyResults "${results_path}/recurrent-test.tsv"

exit
