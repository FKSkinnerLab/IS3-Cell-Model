README:
Code by Alexandre Guet-McCreight
2017

Languagues:
Matlab
NEURON (hoc)

Summary:
This directory contains a variety of different folders, which run variations of ion channel conductance parameter search simulations of the hippocampal interneuron specific 3 cell (IS3). For more details, see Guet-McCreight and colleagues (2016).

In this case one could submit code to the neuroscience gateway (NSG) for high-performance computing (https://www.nsgportal.org/). Note that the code is not parallelized.

Also note that this code uses code written by Adam Taylor to create clutter based dimensional reordering plots (Taylor et al, 2006; see "stack-ordering" folder within the "AddedScriptsAndToolboxes" folder). Once again, make sure to update the path to the toolbox.

Make sure to update all directory paths as they were possibly changed during the development of this Github repository.

Run Procedure:
1. Compile mod files (see NEURON Website for details on this: https://www.neuron.yale.edu/neuron/)
2. Run "Run_Procedure.hoc" in NEURON.
3. Run "PANDORA_Load_measure_DDMMYYYY.m" in Matlab.

Run Procedure (NSG):
1. Create a zip file containing the relevent code.
2. Submit to NSG
3. Plot the results by running the "PANDORA_Load_measure_DDMMYYYY.m" Matlab script (i.e. replace DDMMYYY with the corresponding day, month and year that is written on the file within the repository)

Reference:
Guet-McCreight A, Camiré O, Topolnik L, Skinner FK. (2016). Using a Semi-Automated Strategy to Develop Multi-Compartment Models That Predict Biophysical Properties of Interneuron-Specific 3 (IS3) Cells in Hippocampus. eNeuro. 3(4). pii: ENEURO.0087-16.2016.
Taylor AL, Hickey TJ, Prinz AA, Marder E. (2006). Structure and visualization of high-dimensional conductance spaces. J Neurophysiol. 96(2):891-905.
