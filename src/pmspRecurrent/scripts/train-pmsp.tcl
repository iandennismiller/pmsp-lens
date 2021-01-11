# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source ../pmspRecurrent.tcl

set num_epochs 2000
set weights_path "../../../var/saved-weights-recurrent-dt-10"
set examples_path "../../../usr/examples"
set results_path "../../../results/2020-12-11"

proc save_weights_hook {} {
    global weights_path
    set epoch [getObj totalUpdates]
    saveWeights "${weights_path}/recurrent-epoch-${epoch}-pmsp.wt.gz"
}

seed 1
pmspRecurrentSimulation "pmsp"

setObj postEpochProc { save_weights_hook }

train_base_vocabulary $num_epochs $weights_path $examples_path

# saveAccuracyResults "${results_path}/recurrent-$num_epochs.tsv"

exit
