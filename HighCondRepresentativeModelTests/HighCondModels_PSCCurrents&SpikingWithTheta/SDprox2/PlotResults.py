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

Case = 'SDprox2_E_COM_I_COM'

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
def getMeasures(inhsyn,excsyn,inhspikes,excspikes,examplenum,repnum,inhtheta,exctheta,EXCSLM,EXCSR,OLM,NGF,IS2,BIS,IS1,holding,vclampon):	
	rep = int(repnum)
	example = int(examplenum)
	h.randomize_syns(example,rep) # Randomizes synapse location with a different seed on each repetition
	h.f(int(inhsyn),int(excsyn),int(inhspikes),int(excspikes),0,example,rep,1,inhtheta,exctheta,EXCSLM,EXCSR,OLM,NGF,IS2,BIS,IS1,int(holding),vclampon) # Runs Simulation
	data = numpy.array(h.recSI)
	timevec = numpy.arange(1000.1,int(tstop)+0.1,dt)
	currentvec = data[10001:len(data)] # Cut out first second of simulation (transient effects)
	return timevec, currentvec

# Set up simulations
numexctheta = 27
numinhtheta = 8
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	numinh = ParamNums[0][x]
	numexc = ParamNums[1][x]
	inhspikes = ParamNums[2][x]
	excspikes = ParamNums[3][x]
	
	ExampleString = ParamStrs[x]
	
	results = getMeasures(numinh,0,inhspikes,0,1,100,numinhtheta,0,0,0,1,1,1,1,1,0,1) # i.e. same random seed values for all representative scenarios
	print 'HC1 = ' + ParamStrs[x] + ', for inhibitory only'
	timevec1 = results[0]
	currentvec1 = results[1]*1000
	conductancevec1 = (results[1])/((0-(-70))*0.001) # Results in Nanosiemens

	results = getMeasures(0,numexc,0,excspikes,1,100,0,numexctheta,1,1,0,0,0,0,0,-70,1) # i.e. same random seed values for all representative scenarios
	print 'HC1 = ' + ParamStrs[x] + ', for excitatory only'
	timevec2 = results[0]
	currentvec2 = results[1]*1000
	conductancevec2 = (results[1])/((-70-(0))*0.001)
	
	results = getMeasures(numinh,numexc,inhspikes,excspikes,1,100,numinhtheta,numexctheta,1,1,1,1,1,1,1,-70,0) # i.e. same random seed values for all representative scenarios
	print 'HC1 = ' + ParamStrs[x] + ', Voltage Trace'
	timevec3 = results[0]
	voltagevec = results[1]
	
	f, axarr = matplotlib.pyplot.subplots(3)
	axarr[0].plot(timevec3,voltagevec,color='k')
	axarr[0].tick_params(labelsize=12)
	# axarr.set_xlabel('Time (ms)')
	axarr[0].set_ylabel('Voltage (mV)',fontsize=12)
	axarr[0].set_xlim(9000,10000)
	# axarr.set_ylim(-70,40)
	for tic in axarr[0].xaxis.get_major_ticks():
		tic.tick1On = tic.tick2On = False
	axarr[0].set_xticklabels([])
	
	axarr[1].plot(timevec1,currentvec1,colors[0])
	axarr[1].plot(timevec2,currentvec2,colors[1])
	axarr[1].tick_params(labelsize=12)
	# axarr.set_xlabel('Time (ms)')
	axarr[1].set_ylabel('Current (pA)',fontsize=12)
	axarr[1].set_xlim(9000,10000)
	# axarr.set_ylim(-1000,1000)
	for tic in axarr[1].xaxis.get_major_ticks():
		tic.tick1On = tic.tick2On = False
	axarr[1].set_xticklabels([])
	
	axarr[2].plot(timevec1,conductancevec1,colors[0])
	axarr[2].plot(timevec2,conductancevec2,colors[1])
	axarr[2].tick_params(labelsize=12)
	axarr[2].set_xlabel('Time (ms)',fontsize=12)
	axarr[2].set_ylabel('Conductance (nS)',fontsize=12)
	axarr[2].set_xlim(9000,10000)
	# axarr.set_ylim(0,14)
	pyplot.savefig('PLOTfiles/' + Case + '_Traces_' + ExampleString + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_Traces_' + ExampleString + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
	
	tvec1split = numpy.split(timevec1,72)
	tvec2split = numpy.split(timevec2,72)
	cond1split = numpy.split(conductancevec1,72)
	cond2split = numpy.split(conductancevec2,72)
	cond1mean = numpy.mean(cond1split,axis=0)
	cond2mean = numpy.mean(cond2split,axis=0)
	cond1std = numpy.std(cond1split,axis=0)
	cond2std = numpy.std(cond2split,axis=0)
	f, axarr = matplotlib.pyplot.subplots(1)
	axarr.fill_between(tvec1split[0],cond1mean-cond1std,cond1mean+cond1std,facecolor='red', alpha=0.5)
	axarr.plot(tvec1split[0],cond1mean,color='red')
	axarr.fill_between(tvec2split[0],cond2mean-cond2std,cond2mean+cond2std,facecolor='blue', alpha=0.5)
	axarr.plot(tvec2split[0],cond2mean,color='blue')	
	axarr.tick_params(labelsize=10)
	axarr.set_xlabel('Time (ms)',fontsize=12)
	axarr.set_ylabel('Conductance (nS)',fontsize=12)
	axarr.set_xlim(1000,1125)
	axarr.set_xticks([1000, 1031.25, 1062.5, 1093.75, 1125])
	axarr.set_xticklabels(['0', '31.25', '62.5', '93.75', '125'])
	
	axarr2 = axarr.twiny()
	axarr2.set_xlim(axarr.get_xlim())
	axarr2.set_xticks([1000, 1031.25, 1062.5, 1093.75, 1125])
	axarr2.set_xticklabels([r"$0^\circ$", r"$90^\circ$", r"$180^\circ$", r"$270^\circ$", r"$360^\circ$"])
    # axarr2.axis["right"].major_ticklabels.set_visible(False)
    # axarr2.axis["top"].major_ticklabels.set_visible(True)
	pyplot.savefig('PLOTfiles/' + Case + '_CondAvg_' + ExampleString + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_CondAvg_' + ExampleString + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()

elapsed = time.time() - t
print elapsed
