# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source ../pmspRecurrent.tcl

set num_epochs 2000
set weights_path "../../../var/saved-weights"
set examples_path "../../../usr/examples"
set results_path "../../../results"

seed 1
pmspRecurrentSimulation "pmsp"
train_base_vocabulary $num_epochs $weights_path $examples_path

# saveAccuracyResults "${results_path}/recurrent-$num_epochs.tsv"

exit
