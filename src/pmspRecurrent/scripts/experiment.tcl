# Warping: examining effects of frequency upon regularization
# 2020-01-12

source ../model/pmspRecurrent.tcl

# viewUnits
# graphObject

set dilution_amounts {1}
set num_epochs 40
set test_procedure test_probes

foreach dilution_amount $dilution_amounts {
    run_experiment $dilution_amounts $num_epochs $test_procedure
}
