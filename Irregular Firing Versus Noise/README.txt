README:
Code by Alexandre Guet-McCreight
2015

Languague requirements:
NEURON
Matlab

Summary:
This code explores the effect of intrinsic noise on irregular spiking for different variants of the IS3 cell model.

In this case one could submit code to the neuroscience gateway (NSG) for high-performance computing (https://www.nsgportal.org/). Note that the code is not parallelized.

Make sure to update all directory paths as they were possibly changed during the development of this Github repository.

Run Procedure:
1. Compile mod files (see NEURON Website for details on this: https://www.neuron.yale.edu/neuron/)
2. To run the simulations, go to a particular model variant folder and open the "VaryNoise.hoc" file in NEURON
3. Plot the results by running the "NoiseVsISIstdev.m" Matlab script

Run Procedure (NSG):
1. Create a zip file containing the relevent code.
2. Submit to NSG
3. Plot the results by running the "NoiseVsISIstdev.m" Matlab script
