from neuron import h

h.load_file("SynParamSearch.hoc")
execfile("CutSpikes_HighConductanceMeasurements.py")
h.quit()
