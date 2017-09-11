README:
Code by Alexandre Guet-McCreight
2016

Languague requirements:
NEURON
Matlab

Summary:
This code fits synaptic parameters for each compartment of the IS3 cell models. Note that only the "PassiveOptimization_N1" does so accurately, as the "LayerSpecificInputTests" folders do not accurately represent the experimental protocol that was used to generate the recordings that the synaptic paramteres were fit to. In the "PlotOptimizedPSCs_N2" folder, I use these optimized parameters to come up with a distance-dependent rule for synaptic conductance.

Make sure to update all directory paths as they were possibly changed during the development of this Github repository.

Run Procedure (PassiveOptimization_N1):
1. Compile mod files (see NEURON Website for details on this: https://www.neuron.yale.edu/neuron/)
2. To run the simulations, open the "PasSynOpt.hoc" file in NEURON
3. Plot the results by running the Matlab scripts

Run Procedure (PlotOptimizedPSCs_N2):
1. Compile mod files (see NEURON Website for details on this: https://www.neuron.yale.edu/neuron/)
2. To run the simulations, open the "ExportAdjPSCs.hoc" file in NEURON
3. Plot the results by running the Matlab scripts

