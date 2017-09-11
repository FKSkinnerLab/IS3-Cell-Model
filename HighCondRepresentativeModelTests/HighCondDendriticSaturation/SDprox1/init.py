import neuron
from neuron import h

h.load_file("SynParamSearch.hoc")
execfile("PlotResults.py")
h.quit()
