# - how low does accuracy for base vocab go?
# - 10% is good, 75% is too high

# test.group.crit 0.5, will test at group level, will pass criterion if all units on corrct side of 0.5

# all relative to ./scripts
set root_path "../../.."
set output_file "$root_path/var/results/search-parameter-the-frequency-dt-100-full-epochs-300-big-epoch3000.txt"

###
# Network Architecture

set dt 100

addNet "pmspRecurrent" -i 2 -t $dt CONTINUOUS

# input layer
addGroup ortho_onset 30 INPUT
addGroup ortho_vowel 27 INPUT
addGroup ortho_coda 48 INPUT

# hidden layer
addGroup hidden 100 IN_INTEGR

# output layer
addGroup phono_onset 23 OUTPUT IN_INTEGR CROSS_ENTROPY
addGroup phono_vowel 14 OUTPUT IN_INTEGR CROSS_ENTROPY
addGroup phono_coda 24 OUTPUT IN_INTEGR CROSS_ENTROPY

# connections
connectGroups ortho_onset hidden -p FULL
connectGroups ortho_vowel hidden -p FULL
connectGroups ortho_coda hidden -p FULL
connectGroups hidden phono_onset -p FULL -bidirectional
connectGroups hidden phono_vowel -p FULL -bidirectional
connectGroups hidden phono_coda -p FULL -bidirectional
connectGroups {phono_onset phono_vowel phono_coda} {phono_onset phono_vowel phono_coda}

useNet "pmspRecurrent"

###
# Parameters

setObj learningRate 0.05
setObj weightDecay 0.00000
setObj targetRadius 0.1
setObj reportInterval 10
setObj pseudoExampleFreq 1
setObj testGroupCrit 0.5

###
# Examples

# load frequency-dilution vocab and anchors

# replace 0.69314718 with 0.000085750
# n=1 replace 2.484906650 with (6 - (2998*0.000085750)) / 30 = 0.1914307167
# n=2 replace 1.945910149 with (6 - (2998*0.000085750)) / 60 = 0.09571535833
# n=2 replace 1.673976434 with (6 - (2998*0.000085750)) / 90 = 0.06381023889

# 01 = s/0.1914307167/0.1/g
# 001 = s/0.1914307167/0.01/g

# set freqs [ list 01 001 ]
set freqs [ list 000001 00001 0001 001 01 1 10 100 1000 10000 100000 ]
# set freqs [ list 0001 0002 0003 0004 0005 0006 0007 0008 0009 001 ]

set example_test_file "${root_path}/usr/examples/pmsp-train-the-normalized.ex"
loadExamples $example_test_file -s "vocab_pmsp"
exampleSetMode "vocab_pmsp" PERMUTED
useTestingSet "vocab_pmsp"

foreach {freq} $freqs {
    puts "frequency: $freq"

    set example_file "${root_path}/usr/examples/pmsp-added-anchors-the-normalized-n1-freq-$freq.ex"
    loadExamples $example_file -s "vocab_anchors"
    exampleSetMode "vocab_anchors" PERMUTED
    useTrainingSet "vocab_anchors"

    setObj vocab_anchors.minTime 2.0
    setObj vocab_anchors.maxTime 2.0
    setObj vocab_anchors.graceTime 1.0

    # setObj test.group.crit 0.5

    # resume training with the final epoch of a fully-trained PMSP network
    loadWeights "${root_path}/var/net/pmsp-recurrent-dt-100-seed-1/weights/3000.wt.gz"

    train -a "deltaBarDelta" -setOnly
    setObj momentum 0.98

    # at each epoch, run test on base vocabulary corpus, -return arg to test command? instead of printing, it returns an object; test_result.percent_corret or test_result.error; will be the percent correct of base vocabulary; just keep minimum results across this sweep, save minimum and key it according to dilution level and scaling frequency for language

    # just retrain until min test error is 95%

    for { set epoch_idx 3000} {$epoch_idx <= 3300} {incr epoch_idx} {
        train 1
        test

        puts $Test(percentCorrect)

        set f [open $output_file "a"]
        puts $f "$freq\t$epoch_idx\t$Test(percentCorrect)"
        close $f

    }

}

exit
