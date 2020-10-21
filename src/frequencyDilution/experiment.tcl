# Warping: examining effects of frequency upon regularization
# 2020-01-12

source frequencyDilution.tcl

# viewUnits
# graphObject

# foreach dilutionAmount {1 2 3} {
foreach dilutionAmount {1} {
    # reproducible results
    seed 1

    # initialize simulation with dilution amount
    FrequencyDilution $dilutionAmount

    # initialize logging with an interval of 1
    Logger 1

    loadWeights ../results/dilution-epoch-200.wt.gz

    puts "-----"
    puts "Introduce anchors: dilution amount = ${dilutionAmount}"
    puts "-----"

    introduceAnchors $dilutionAmount

    puts "-----"
    puts "Test: dilution amount = ${dilutionAmount}"
    puts "-----"

    doTest

    saveAccuracyResults "../results/outputs-200-n${dilutionAmount}-ln2.tsv"
}
