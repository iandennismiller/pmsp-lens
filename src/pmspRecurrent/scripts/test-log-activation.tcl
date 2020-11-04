source ../model/pmspRecurrent.tcl

# viewUnits
# graphObject

# reproducible results
seed 1

# initialize simulation with dilution amount = 1
pmspRecurrentSimulation 1

# initialize logging with an interval of 1
Logger 1

setObj postExampleProc {outTarg}
# Need to view units to be able to access the history arrays.
viewUnits
global f

loadWeights "../../../results/recurrent-epoch-2000.wt.gz"

set f [open "../../../results/recurrent-activations-epoch-2000.txt" w ]
doTest
close $f

setObj postExampleProc {}
