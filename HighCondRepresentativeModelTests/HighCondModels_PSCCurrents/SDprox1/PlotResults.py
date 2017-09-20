### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
import efel
import time
import random

t = time.time()

Case = 'SDprox1_E_COM_I_COM'

# If Loading Vectors
ParamNums = numpy.load('NPYfiles/' + Case + '_ExampleHCModelParams.npy')
ParamStrs = numpy.load('NPYfiles/' + Case + '_ExampleHCModelStrings.npy')

LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes = [ParamNums[0][0], ParamNums[1][0], ParamNums[2][0], ParamNums[3][0]]
HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes = [ParamNums[0][1], ParamNums[1][1], ParamNums[2][1], ParamNums[3][1]]
LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes = [ParamNums[0][2], ParamNums[1][2], ParamNums[2][2], ParamNums[3][2]]
HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes = [ParamNums[0][3], ParamNums[1][3], ParamNums[2][3], ParamNums[3][3]]
LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes = [ParamNums[0][4], ParamNums[1][4], ParamNums[2][4], ParamNums[3][4]]
HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes = [ParamNums[0][5], ParamNums[1][5], ParamNums[2][5], ParamNums[3][5]]
LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes = [ParamNums[0][6], ParamNums[1][6], ParamNums[2][6], ParamNums[3][6]]
HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes = [ParamNums[0][7], ParamNums[1][7], ParamNums[2][7], ParamNums[3][7]]
LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes = [ParamNums[0][8], ParamNums[1][8], ParamNums[2][8], ParamNums[3][8]]
HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes = [ParamNums[0][9], ParamNums[1][9], ParamNums[2][9], ParamNums[3][9]]
LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes = [ParamNums[0][10], ParamNums[1][10], ParamNums[2][10], ParamNums[3][10]]
HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes = [ParamNums[0][11], ParamNums[1][11], ParamNums[2][11], ParamNums[3][11]]
LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes = [ParamNums[0][12], ParamNums[1][12], ParamNums[2][12], ParamNums[3][12]]
HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes = [ParamNums[0][13], ParamNums[1][13], ParamNums[2][13], ParamNums[3][13]]
LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes = [ParamNums[0][14], ParamNums[1][14], ParamNums[2][14], ParamNums[3][14]]
HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes = [ParamNums[0][15], ParamNums[1][15], ParamNums[2][15], ParamNums[3][15]]

holding_potentials = numpy.array([0,-70])
colors = ['r','b']
data = numpy.zeros((100001,), dtype=numpy.float64)
tstop = h.tstop
dt = h.dt
def getMeasures(inhsyn,excsyn,inhspikes,excspikes,examplenum,repnum,holding):	
	rep = int(repnum)
	example = int(examplenum)
	h.randomize_syns(example,rep) # Randomizes synapse location with a different seed on each repetition
	h.f(int(inhsyn),int(excsyn),int(inhspikes),int(excspikes),0,example,rep,int(holding)) # Runs Simulation
	data = numpy.array(h.recSI)
	timevec = numpy.arange(1000.1,int(tstop)+0.1,dt)
	currentvec = data[10001:len(data)] # Cut out first second of simulation (transient effects)
	return timevec, currentvec

# Set up simulations
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	numinh = ParamNums[0][x]
	numexc = ParamNums[1][x]
	inhspikes = ParamNums[2][x]
	excspikes = ParamNums[3][x]
	
	for y in range(0,2):
		results = getMeasures(numinh,numexc,inhspikes,excspikes,1,1000,holding_potentials[y]) # i.e. same random seed values for all representative scenarios
		print 'HC1 = ' + ParamStrs[x] + ', for example #' + str(x) + ' on rep #' + str(y)
		if y == 0:
			timevec1 = results[0]
			currentvec1 = results[1]*1000
			conductancevec1 = (results[1]*(1**-9))/((holding_potentials[y]-holding_potentials[y+1])*0.001)
		elif y == 1:
			timevec2 = results[0]
			currentvec2 = results[1]*1000
			conductancevec2 = (results[1]*(1**-9))/((holding_potentials[y]-holding_potentials[y-1])*0.001)
	f, axarr = matplotlib.pyplot.subplots(1)
	axarr.plot(timevec1,currentvec1,colors[0])
	axarr.plot(timevec2,currentvec2,colors[1])
	axarr.set_xlabel('Time (ms)')
	axarr.set_ylabel('Current (pA)')
	axarr.set_xlim(1000,10000)
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_Current' + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_Current' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
	f, axarr = matplotlib.pyplot.subplots(1)
	axarr.plot(timevec1,conductancevec1,colors[0])
	axarr.plot(timevec2,conductancevec2,colors[1])
	axarr.set_xlabel('Time (ms)')
	axarr.set_ylabel('Conductance (S)')
	axarr.set_xlim(1000,10000)
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_Conductance' + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_Conductance' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
	
	results = getMeasures(numinh,0,inhspikes,0,1,1000,-60) # i.e. same random seed values for all representative scenarios
	print 'HC1 = ' + ParamStrs[x] + ', for inhibitory only'
	timevec1 = results[0]
	currentvec1 = results[1]*1000
	conductancevec1 = (results[1]*(1**-9))/((-60-(-70))*0.001)

	results = getMeasures(0,numexc,0,excspikes,1,1000,-60) # i.e. same random seed values for all representative scenarios
	print 'HC1 = ' + ParamStrs[x] + ', for excitatory only'
	timevec2 = results[0]
	currentvec2 = results[1]*1000
	conductancevec2 = (results[1]*(1**-9))/((-60-(0))*0.001)
	
	f, axarr = matplotlib.pyplot.subplots(1)
	axarr.plot(timevec1,currentvec1,colors[0])
	axarr.plot(timevec2,currentvec2,colors[1])
	axarr.set_xlabel('Time (ms)')
	axarr.set_ylabel('Current (pA)')
	axarr.set_xlim(1000,10000)
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_CurrentAtRest' + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_CurrentAtRest' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
	f, axarr = matplotlib.pyplot.subplots(1)
	axarr.plot(timevec1,conductancevec1,colors[0])
	axarr.plot(timevec2,conductancevec2,colors[1])
	axarr.set_xlabel('Time (ms)')
	axarr.set_ylabel('Conductance (S)')
	axarr.set_xlim(1000,10000)
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_ConductanceAtRest' + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_ConductanceAtRest' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
	
	results = getMeasures(numinh,0,inhspikes,0,1,1000,0) # i.e. same random seed values for all representative scenarios
	print 'HC1 = ' + ParamStrs[x] + ', for inhibitory only again'
	timevec1 = results[0]
	currentvec1 = results[1]*1000
	conductancevec1 = (results[1]*(1**-9))/((0-(-70))*0.001)

	results = getMeasures(0,numexc,0,excspikes,1,1000,-70) # i.e. same random seed values for all representative scenarios
	print 'HC1 = ' + ParamStrs[x] + ', for excitatory only again'
	timevec2 = results[0]
	currentvec2 = results[1]*1000
	conductancevec2 = (results[1]*(1**-9))/((-70-(0))*0.001)
	
	f, axarr = matplotlib.pyplot.subplots(1)
	axarr.plot(timevec1,currentvec1,colors[0])
	axarr.plot(timevec2,currentvec2,colors[1])
	axarr.set_xlabel('Time (ms)')
	axarr.set_ylabel('Current (pA)')
	axarr.set_xlim(1000,10000)
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_Current2' + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_Current2' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
	f, axarr = matplotlib.pyplot.subplots(1)
	axarr.plot(timevec1,conductancevec1,colors[0])
	axarr.plot(timevec2,conductancevec2,colors[1])
	axarr.set_xlabel('Time (ms)')
	axarr.set_ylabel('Conductance (S)')
	axarr.set_xlim(1000,10000)
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_Conductance2' + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_Conductance2' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
elapsed = time.time() - t
print elapsed
