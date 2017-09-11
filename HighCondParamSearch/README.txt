README:
Code by Alexandre Guet-McCreight
2017

Languague requirements:
Python
NEURON
Matlab

Summary:
This code contains mostly just a series of test attempts to submit code to the neuroscience gateway (NSG) for high-performance computing (https://www.nsgportal.org/)

I would recommend not submitting any of the earlier instantiations of this project to NSG, as on several submissions it generated a lot of files (more data than NSG had room for) and NSG had to close the site to clean up their data storage because of this. In fact, I have had to retroactively delete the results folders from N1 to N3 in order to reduce space on my personal computer. If you are trying to replicate anything to do with in-vivo like parameter search explorations, please skip to the "HighCondParamSearch_N5" folder. N1 to N4 are more or less just smaller resolution versions of N5 but with less refinements in the code. 

Also note that this code uses code written by Adam Taylor to create clutter based dimensional reordering plots (Taylor et al, 2006; see "stack-ordering" folder within the "AddedScriptsAndToolboxes" folder). Once again, make sure to update the path to the toolbox.

Run Procedure:
1. Create a zip file containing the relevent code.
2. Submit to NSG
3. Create CBDR plots by running the "PlotCBDR.m" in Matlab
