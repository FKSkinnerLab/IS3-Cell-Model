README:
Code by Alexandre Guet-McCreight
2017

Languague requirements:
NEURON (hoc)
Matlab

Summary:
This code simulates an experimental procedure for determining the reversal potential of excitatory AMPA synapses. It uses this procedure to calculate the reversal potential for synapses located on each individual compartment of the model, one at a time.

Run Procedure:
1. Compile mod files (see NEURON Website for details on this: https://www.neuron.yale.edu/neuron/)
2. Run "MeasureErevAdjPSCs.hoc" in NEURON to generate data files in the "Output" folder
3. Run "PlotResultsErev.m" in Matlab to generate the summary figure that plots the reversal potential along the different dendritic subtrees