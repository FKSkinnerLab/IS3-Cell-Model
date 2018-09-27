README:
Code by Alexandre Guet-McCreight
2015

Languague requirements:
NEURON

Summary:
This code was used to do a sanity check regarding the placement of power of 4 within the a-type potassium channel equations taken from the Saraga OLM cell model (Lawrence et al, 2006). 

Basically, instead of:
ik = gbar*m*m*m*m*h*(v - ek)

... This was done instead:
ik = gbar*m*h*(v - ek)
minf = (1/(1 + exp(-(v+41.4(mV))/26.6(mV))))^4

...So the ^4 was placed on minf instead.

References:
Lawrence JJ, Saraga F, Churchill JF, Statland JM, Travis KE, Skinner FK, McBain CJ. (2006). Somatodendritic Kv7/KCNQ/M channels control interspike interval in hippocampal interneurons. J Neurosci. 26(47):12325-38.