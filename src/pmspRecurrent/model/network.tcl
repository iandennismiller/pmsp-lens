# Warping: examining effects of frequency upon regularization
# 2020-01-12

proc pmspRecurrentNetwork { amount } {
    addNet "pmspRecurrent${amount}" -i 2 -t 20 CONTINUOUS

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

    useNet "pmspRecurrent${amount}"
}
