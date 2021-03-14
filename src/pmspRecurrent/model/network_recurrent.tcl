# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

proc pmspRecurrentNetwork { label dt } {
    # https://ni.cmu.edu/~plaut/Lens/Manual/Commands/addNet.html
    # timeIntervals is an integer specifying the maximum "real" time for which each example will be run. For non-continuous networks, this is the same as the number of events or ticks. For continuous networks, these are in abstract time units. The default is 1.
    # ticksPerInterval is specific to continuous networks and sets the number of ticks or activation updates per time interval. dt will default to the inverse of this value.
    # To get recurrent backprop-through-time (which isn't really continuous), leave the ticksPerInterval 1 and use the CONTINUOUS type.

    # The network is trained with a version of back-propagation designed for recurrent networks, known as back-propagation through time (Rumelhart, Hinton, & Williams, 1986a, 1986b; Williams & Peng, 1990), further adapted for continuous units (Pearlmutter, 1989).
    # In understanding back-propagation through time, it may help to think of the computation in stan- dard back-propagation in a three layer feedforward network as occurring over time. In the forward pass, the states of input units are clamped at time t = 0. Hidden unit states are computed at t = 1 from these input unit states, and then output unit states are computed at t = 2 from the hidden unit states. In the backward pass, error is calculated for the output units based on their states (t = 2). Error for the hidden units and weight changes for the hidden-to-output connections are calculated based on the error of the output units (t = 2) and the states of hidden units (t = 1). Finally, the weight changes for the input-to-hidden connections are calculated based on the hidden unit error (t =  1) and the input unit states (t =  0). Thus, feedforward back-propagation can be interpreted as involving a pass forward in time to compute unit states, followed by a pass backward in time to compute unit error and weight changes.
    
    addNet "pmspRecurrent${label}" -i 2 -t $dt CONTINUOUS

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
