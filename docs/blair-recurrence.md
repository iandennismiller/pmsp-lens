OK, here are the changes:

-network type on initialization must now be declared as CONTINUOUS.  
intervals (i) should be set to 2 and ticks (t) set to 5.  This is done 
when you "addNet"

when adding groups, the hidden and output units should have their first 
TYPE set to be IN_INTEGR (for input integration.  This happens before 
you declare the sigmoid transform and before you declare that there are 
targets.

-for each group, you need to initialize its default net input and net 
output values, since the network starts computing these from the very 
first tick in the output layer now.  LENS may actually use the right 
defaults, but I can't remember.  The defaults for every layer except 
bias should be as follows.  I'll give the examples only for the input 
layer though (where it might actually not matter, I just can't remember 
how LENS deals with tick 0 in interval 0)

input.initInput 0
input.initOutput 0.5

This will start the network in a good neutral state for every example, 
and you'll probably see activity being reduced over the initial few 
ticks of time.

Next, every exampleSet you import needs to have its runtime noted 
explicitly.  We want every example to run for exactly 2 intervals, and 
for error to only be calculated after the first interval (since it would 
be basically impossible to be correct in the 0th interval, as activation 
from the input does not have time to flow to the output).  To do this, 
for every example set you would set

exSet.minTime 2.0

exSet.maxTime 2.0

exSet.graceTime 1.0  # this prevents error from being computed until 
after the graceTime has passed.

You might be able to set those properties at the network level at the 
start and they will be applied whenever you import the exampleSets, but 
I am not actually sure.  If that is true, you would not need to code it 
for every exampleSet.

Make sure the output units are computing CE_ERROR, as I don't think that 
is the default.

Plaut did play some computational games to try to get the network to 
converge faster in this case, but I suggest we see if we get more of the 
qualitative results that we expect without trying to tailor the ticks pa 
parameter (all of this is on p. 35/70 in his pdf).  The main thing here 
is that we may need to train this network for longer to achieve an 
equivalent level of training. Train using learning rate -0.05, momentum 
to 0.9 and standard delta-bar-delta parameters for 200 epochs, then 
increase momentum to 0.98 and train up to epoch 1850.

Once you confirm that the error trajectory for this network looks 
reasonable (just graphObj error before starting training and make sure 
it only goes down or stays stable, delta-bar-delta sometimes grows back 
up in lens due to how its computation works) you could probably just 
reset the net, set ticks = 20 when you addNet, and train the entire 
network from the start at ticks = 20 for 1850 epochs.  There is no point 
in trying to follow Plaut's exact way of cutting compute time down for 
the ticks parameter, as this whole simulation should still train in < 10 
minutes with ticks = 20.  It might even be done in a minute...

At that point you should be able to extract the hidden unit activities 
and compute the similarities as Brian did between pairs of examples' 
activities across different groups.


I now also have a working binary for lens in 64 bit, although for some 
reason parallel training across CPUs is broken and I have no idea 
why...  I'm not really prepared to devote any time to figuring it out 
though given we are advancing nicely on pyLens.

Blair