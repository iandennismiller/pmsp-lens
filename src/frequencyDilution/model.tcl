# Warping: examining effects of frequency upon regularization
# 2020-01-12

proc PMSPDilutionModel { amount } {
    addNet "pmsp${amount}"

    # input layer
    addGroup ortho_onset 30 INPUT
    addGroup ortho_vowel 27 INPUT
    addGroup ortho_coda 48 INPUT

    # hidden layer
    addGroup hidden 100

    # output layer
    addGroup phono_onset 23 OUTPUT
    addGroup phono_vowel 14 OUTPUT
    addGroup phono_coda 24 OUTPUT

    # connections
    connectGroups ortho_onset hidden -p FULL
    connectGroups ortho_vowel hidden -p FULL
    connectGroups ortho_coda hidden -p FULL
    connectGroups hidden phono_onset -p FULL
    connectGroups hidden phono_vowel -p FULL
    connectGroups hidden phono_coda -p FULL

    useNet "pmsp${amount}"
}
