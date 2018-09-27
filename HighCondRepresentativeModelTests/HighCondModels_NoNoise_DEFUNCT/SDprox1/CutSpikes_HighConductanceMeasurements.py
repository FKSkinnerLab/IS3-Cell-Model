### Test Script for a file found in the SDprox2 results from initial Parallel Simulations

import efel
import numpy
import time
import random

t = time.time()

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

data = numpy.zeros((100001,), dtype=numpy.float64)
tstop = h.tstop
dt = h.dt
def getMeasures(inhsyn,excsyn,inhspikes,excspikes,examplenum,repnum):	
	rep = int(repnum)
	example = int(examplenum)
	h.randomize_syns(example,rep) # Randomizes synapse location with a different seed on each repetition
	h.f(int(inhsyn),int(excsyn),int(inhspikes),int(excspikes),0,example,rep) # Runs Simulation
	for p in range(0,int(tstop/dt+1)): data[p] = h.recV[p]
	timevec = numpy.arange(1000.1,int(tstop)+0.1,dt)
	voltage = data[10001:len(data)] # Cut out first second of simulation since there are transient effects still present and make sure that the last spike repolarizes to -66.7 mV
	trace = {}
	trace['T'] = timevec
	trace['V'] = voltage
	trace['stim_start'] = [0]
	trace['stim_end'] = [10000]
	traces = [trace]
	
	traces_results = efel.getFeatureValues(traces,['AP_amplitude','ISI_CV','Spikecount','AP_begin_indices','AP_end_indices'])
	traces_mean_results = efel.getMeanFeatureValues(traces,['AP_amplitude','ISI_CV','Spikecount'])
	
	#### Create Trace Where Spikes Are Removed ####
	AP_begin = traces_results[0]['AP_begin_indices']
	AP_end = traces_results[0]['AP_end_indices']
	spikecut_voltage = []
	
	if AP_begin is not None:
		for i in range(0,len(AP_begin)):
			# Cut out action potentials + 100 index points preceding each spike
			if i == 0:
				spikecut_tempvoltage = voltage[0:AP_begin[i]-80]
				spikecut_voltage.append(spikecut_tempvoltage)
			elif i == len(AP_begin):
				spikecut_tempvoltage = [voltage[AP_end[i-1]:AP_begin[i]]-80, voltage[AP_end[i]:len(voltage)]]
				spikecut_voltage.append(spikecut_tempvoltage)
			else:
				spikecut_tempvoltage = voltage[AP_end[i-1]:AP_begin[i]-80]
				spikecut_voltage.append(spikecut_tempvoltage)
			# Find lengths of appended arrays and rebuild voltage trace array
			x = []
			for i in range(0,len(spikecut_voltage)):
				newlength = len(spikecut_voltage[i])
				x.append(newlength)
			totallength = numpy.sum(x)
			spv = numpy.zeros((totallength,), dtype=numpy.int)
			count = 0
			for i in range(0,len(spikecut_voltage)):
				for j in range(0,len(spikecut_voltage[i])):
					spv[count] = spikecut_voltage[i][j]
					count = count + 1
	else:
		spv = voltage
	
	spv = spv[spv < -50] # Remove all voltage instinces greater than -50 mV
	spt = numpy.arange(0,len(spv),1)*0.1 # Build new tvec for trace with spike cut
	
	### Generate Measurements ###
	if len(spv) == 0:
		StdVolt_i = 0
		MeanVolt_i = -50 # i.e. set to highest possible average if all data points get cut
	else:
		StdVolt_i = numpy.std(spv)
		MeanVolt_i = numpy.mean(spv)
	NumSpikes_i = traces_mean_results[0]['Spikecount']
	if traces_mean_results[0]['AP_amplitude'] is not None:
		MeanAPamp_i = traces_mean_results[0]['AP_amplitude']
	else:
		MeanAPamp_i = 0
	if traces_mean_results[0]['ISI_CV'] is not None:
		ISICV_i = traces_mean_results[0]['ISI_CV']
	else:
		ISICV_i = 0
		reload(efel) # added due to previous error following which all models had ISICV values of 0 regardless of spikes
	AvgPot_Thresh = -66.7
	StdPot_Thresh = 2.2
	ISICV_Thresh = 0.8
	AMP_DB_Thresh = 40
	HC_Metric = 0
	HC_Metric = HC_Metric + (MeanVolt_i >= AvgPot_Thresh) + (StdVolt_i >= StdPot_Thresh) + (ISICV_i >= ISICV_Thresh) - 4*((MeanAPamp_i < AMP_DB_Thresh) & (MeanAPamp_i > 0))
	print 'Vm = ' + str(MeanVolt_i) + ', Vm STD = ' + str(StdVolt_i) + ', ISICV = ' + str(ISICV_i) + ', Amp = ' + str(MeanAPamp_i) + ', HC = ' + str(HC_Metric)
	outputresults = [rep,HC_Metric,MeanVolt_i,StdVolt_i,ISICV_i,MeanAPamp_i]
	return outputresults

# Set up parallel context
CumulHCs = numpy.zeros((16,), dtype=numpy.float64)
MeanVm = numpy.zeros((16,10), dtype=numpy.float64)
Vm_STD = numpy.zeros((16,10), dtype=numpy.float64)
ISI_cv = numpy.zeros((16,10), dtype=numpy.float64)
Mean_A = numpy.zeros((16,10), dtype=numpy.float64)
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	numinh = ParamNums[0][x]
	numexc = ParamNums[1][x]
	inhspikes = ParamNums[2][x]
	excspikes = ParamNums[3][x]
	for y in range(1,11):
		results = getMeasures(numinh,numexc,inhspikes,excspikes,1,y)
		print 'HC1 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
		MeanVm[x][y-1] = results[2]
		Vm_STD[x][y-1] = results[3]
		ISI_cv[x][y-1] = results[4]
		Mean_A[x][y-1] = results[5]
		if results[1] == 3:
			CumulHCs[x] = CumulHCs[x] + 1

elapsed = time.time() - t
print elapsed
