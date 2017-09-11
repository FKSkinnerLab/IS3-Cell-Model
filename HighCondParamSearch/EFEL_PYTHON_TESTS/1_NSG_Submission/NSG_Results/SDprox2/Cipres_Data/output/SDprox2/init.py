import neuron
from neuron import h

h.load_file("SynParamSearch.hoc")
execfile("PlotResults.py")
execfile("DeleteModelFiles.py")
h.quit()
