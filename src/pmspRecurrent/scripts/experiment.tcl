# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source ../model/pmspRecurrent.tcl

set dilution_amounts { 1 }
set num_epochs 40
set test_procedure test_probes
set weights_path "../../../var/saved-weights"
set examples_path "../../../usr/examples"
set results_path "../../../results"


foreach dilution_amount $dilution_amounts {
    seed 1

    # initialize simulation with dilution amount
    pmspRecurrentSimulation $dilution_amount

    # initialize logging with an interval of 1
    Logger 1

    puts "-----"
    puts "Test: dilution amount = ${dilution_amount}, epochs = ${num_epochs}"
    puts "-----"

    loadWeights "${weights_path}/recurrent-epoch-${num_epochs}-dilution-${dilution_amount}.wt.gz"

    test_probes $examples_path

    saveAccuracyResults "${results_path}/recurrent-epoch-${num_epochs}-dilution-${dilution_amount}.tsv"
}
