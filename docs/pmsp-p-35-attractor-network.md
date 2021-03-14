# Attractor Network

## Network Architecture

...

A relatively larger _d_ can be used during the extensive training period (0.2 in the current simulation), when minimizing computation time is critical, whereas a much smaller can be used during testing (e.g., _d_ = 0.01), when a very accurate approximation is desired. As long as remains sufficiently small for the approximations to be adequate, these manipulations do not fundamentally alter the behavior of the system.

## Training Procedure

The training corpus for the network is the same as used with the feedforward network trained on actual word frequencies.
As in that simulation, the frequency value of each word is used to scale the weight changes induced by the word.

The network is trained with a version of back-propagation designed for recurrent networks, known as back-propagation through time (Rumelhart, Hinton, & Williams, 1986a, 1986b; Williams & Peng, 1990), further adapted for continuous units (Pearlmutter, 1989).
In understanding back-propagation through time, it may help to think of the computation in standard back-propagation in a three layer feedforward network as occurring over time.
In the forward pass, the states of input units are clamped at time t = 0.
Hidden unit states are computed at t = 1 from these input unit states, and then output unit states are computed at t = 2 from the hidden unit states.
In the backward pass, error is calculated for the output units based on their states (t = 2).
Error for the hidden units and weight changes for the hidden-to-output connections are calculated based on the error of the output units (t = 2) and the states of hidden units (t = 1).
Finally, the weight changes for the input-to-hidden connections are calculated based on the hidden unit error (t =  1) and the input unit states (t =  0).
Thus, feedforward back-propagation can be interpreted as involving a pass forward in time to compute unit states, followed by a pass backward in time to compute unit error and weight changes.

...

It is possible for the states of units to change quickly if they receive a very large summed input from other units (see Figure 13). However, even for rather large summed input, units typically require some amount of time to approach an extremal value, and may never completely reach it.
As a result, it is practically impossible for units to achieve targets of 0 or 1 immediately after a stimulus has been presented.
For this reason, in the current simulation, a less stringent training regime is adopted.
Although the network is run for 2.0 units of time, error is injected only for the second unit of time; units receive no direct pressure to be correct for the first unit of time (although back-propagated internal error causes weight changes that encourage units to move towards the appropriate states as early as possible).
In addition, output units are trained to targets of 0.1 and 0.9 rather than 0 and 1, although no error is injected if a unit exceeds its target (e.g., reaches a state of 0.95 for a target of 0.9).
This training criterion can be achieved by units with only moderately large summed input (see the curve for input = 4 in Figure 13).

As with the feedforward network using actual frequencies, the attractor network was trained with a global learning rate _L_ = 0.05 (with adaptive connection-specific rates) and momentum = 0.9. 
Furthermore, as mentioned above, the network was trained using a discretization _d_ = 0.2.
Thus, units update their states 10 times (2.0/0.2) in the forward pass, and they back-propagate error 10 times in the backward pass.
As a result, the computational demands of the simulation are about 10 times that of one of the feedforward simulations.
In an attempt to reduce the training time, momentum was increased to 0.98 after 200 epochs.
To improve the accuracy of the network’s approximation to a continuous system near the end of training, _d_ was reduced from 0.2 to 0.05 at epoch 1800, and reduced further to 0.01 at epoch 1850 for an additional 50 epochs of training.
During this final stage of training, each unit updated its state 200 times over the course of processing each input.

## Appendix

https://ni.cmu.edu/~plaut/Lens/Manual/Commands/addNet.html

- timeIntervals: is an integer specifying the maximum "real" time for which each example will be run. For non-continuous networks, this is the same as the number of events or ticks. For continuous networks, these are in abstract time units. The default is 1.
- ticksPerInterval: is specific to continuous networks and sets the number of ticks or activation updates per time interval. dt will default to the inverse of this value.
- To get recurrent backprop-through-time (which isn't really continuous), leave the ticksPerInterval 1 and use the CONTINUOUS type.

https://ni.cmu.edu/~plaut/Lens/Manual/training.html

targetRadius: this is used during processing of a batch rather than during weight updates following a batch. If an output unit's activation is within this range of the target, there will be no error. This is done by effectively adjusting the target to be the same as the activation. If the activation is farther from the target than this distance, the effective target will be this much closer to the activation. 
