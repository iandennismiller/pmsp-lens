# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

proc pmspRecurrentNetwork { label } {
    addNet "pmspRecurrent${label}" -i 2 -t 10 CONTINUOUS

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

    useNet "pmspRecurrent${label}"
}
