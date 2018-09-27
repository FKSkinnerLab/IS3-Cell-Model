### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
from scipy import signal

Case = 'SDprox2_E_COM_I_COM'

# HC Treshold Measurement Values
tstop = 10 # seconds
font_size = 13

numsyns = 50
SLM = 1
SR = 0
EXC = 1
INH = 0
tstop = h.tstop
dt = h.dt

h.randomize_syns(5,2) # Just randomize synapses once
for x in range(0,numsyns):
	# Run Simulation
	if EXC == 1:
		EXCin = int(x)
		INHin = int(0)
		addStim = int(1)
	elif INH == 1:
		if x == 0:
			h.findC()
		INHin = int(x)
		EXCin = int(0)
		addStim = int(1)
	h.f(INHin,EXCin,SLM,SR, addStim) # i.e. same random seeds when comparing runs
	SpikeTimes = numpy.zeros((int(tstop/dt),), dtype=numpy.float)
	for i in range(0,len(h.apctimes)): SpikeTimes[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
	
	f, Pxx_den = signal.welch(SpikeTimes, 1/(dt/1000), nperseg=25000)
	print "PSD @ 8Hz = " + str(Pxx_den[f==8]) + ", Spike Count = " + str(h.apc.n)
	if (EXC == 1) & (Pxx_den[f==8]>50) & (h.apc.n > 10):
		print "Number of Excitatory Inputs = " + str(EXCin) + ", Number of Excitatory Synapses = " + str(EXCin*9)
		break
	elif (INH == 1) & (Pxx_den[f==8]>80) & (h.apc.n < 240):
		print "Number of Inhibitory Inputs = " + str(INHin) + ", Number of Inhibitory Synapses = " + str(INHin*4)
		break
h.sp.printfile("SynLocationsShapePlot.ps")


