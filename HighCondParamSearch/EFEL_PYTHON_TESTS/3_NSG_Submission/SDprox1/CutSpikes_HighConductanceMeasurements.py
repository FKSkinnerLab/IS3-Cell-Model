### Test Script for a file found in the SDprox2 results from initial Parallel Simulations

import efel
import numpy
import time

t = time.time()

NumInh = numpy.arange(1,346,86)
NumExc = numpy.arange(1,1530,382)
InhSpikes = numpy.array([1000])
ExcSRSpikes = numpy.array([300])
ExcSLMSpikes = numpy.array([300])
NumExcCommon = numpy.array([16])
NumInhCommon = numpy.array([9])

Vec_count = 0
for i_NumInh in range(0,len(NumInh)):
	for i_NumExc in range(0,len(NumExc)):
		for i_InhSpikes in range(0,len(InhSpikes)):
			for i_ExcSpikes in range(0,len(ExcSRSpikes)):
				for i_NumExcCommon in range(0,len(NumExcCommon)):
					for i_NumInhCommon in range(0,len(NumInhCommon)):
						Vec_count = Vec_count + 1

NumInhVec = numpy.zeros((Vec_count,), dtype=numpy.int)
NumExcVec = numpy.zeros((Vec_count,), dtype=numpy.int)
InhSpikesVec = numpy.zeros((Vec_count,), dtype=numpy.int)
ExcSRSpikesVec = numpy.zeros((Vec_count,), dtype=numpy.int)
ExcSLMSpikesVec = numpy.zeros((Vec_count,), dtype=numpy.int)
NumExcCommonVec = numpy.zeros((Vec_count,), dtype=numpy.int)
NumInhCommonVec = numpy.zeros((Vec_count,), dtype=numpy.int)

Vec_count = 0
for i_NumInh in range(0,len(NumInh)):
	for i_NumExc in range(0,len(NumExc)):
		for i_InhSpikes in range(0,len(InhSpikes)):
			for i_ExcSpikes in range(0,len(ExcSRSpikes)):
				for i_NumExcCommon in range(0,len(NumExcCommon)):
					for i_NumInhCommon in range(0,len(NumInhCommon)):
						NumInhVec[Vec_count] = NumInh[i_NumInh]
						NumExcVec[Vec_count] = NumExc[i_NumExc]
						InhSpikesVec[Vec_count] = InhSpikes[i_InhSpikes]
						ExcSRSpikesVec[Vec_count] = ExcSRSpikes[i_ExcSpikes]
						ExcSLMSpikesVec[Vec_count] = ExcSRSpikes[i_ExcSpikes]
						NumExcCommonVec[Vec_count] = NumExcCommon[i_NumExcCommon]
						NumInhCommonVec[Vec_count] = NumInhCommon[i_NumInhCommon]
						Vec_count = Vec_count + 1

StdVolt = numpy.zeros((Vec_count,), dtype=numpy.float64)
MeanVolt = numpy.zeros((Vec_count,), dtype=numpy.float64)
MeanAPamp = numpy.zeros((Vec_count,), dtype=numpy.float64)
ISICV = numpy.zeros((Vec_count,), dtype=numpy.float64)
NumSpikes = numpy.zeros((Vec_count,), dtype=numpy.int)

trace_index = 0
trace_mat = []
InhSpikeTrains_Mat = []
ExcSRSpikeTrains_Mat = []
ExcSLMSpikeTrains_Mat = []

def getMeasures(TrIn):
	trace_index = int(TrIn)
	print('Trace Index = ' + str(trace_index))
	# trace_index = i_NumInhCommon + i_NumExcCommon*len(NumInhCommon) + i_ExcSRSpikes*len(NumInhCommon)*len(NumExcCommon) + i_InhSpikes*len(NumInhCommon)*len(NumExcCommon)*len(ExcSRSpikes) + i_NumExc*len(NumInhCommon)*len(NumExcCommon)*len(ExcSRSpikes)*len(InhSpikes) + i_NumInh*len(NumInhCommon)*len(NumExcCommon)*len(ExcSRSpikes)*len(InhSpikes)*len(NumExc)
	h.f(TrIn)
	data = numpy.fromfile("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('model_',str(NumInhVec[trace_index]),'_NumInh_',str(NumExcVec[trace_index]),'_NumExc_',str(InhSpikesVec[trace_index]),'_InhSpikes_',str(ExcSRSpikesVec[trace_index]),'_ExcSRSpikes_',str(ExcSRSpikesVec[trace_index]),'_ExcSLMSpikes_',str(NumExcCommonVec[trace_index]),'_NumExcCommon_',str(NumInhCommonVec[trace_index]),'_NumInhCommon.dat'),dtype=float)
	
	timevec = numpy.arange(1000,10000.1,0.1)
	voltage = data[10001:len(data)] # Cut out first second of simulation since there are transient effects still present
	
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
	outputresults = [trace_index,StdVolt_i,MeanVolt_i,NumSpikes_i,MeanAPamp_i,ISICV_i]
	return outputresults

from neuron import h
pc = h.ParallelContext()
pc.runworker()
# Set up parallel context
print 'Number of Hosts = ' + str(pc.nhost())
if pc.nhost() == 1:
	for l in range(0,Vec_count): 
		results = getMeasures(l)
		StdVolt[results[0]] = results[1]
		MeanVolt[results[0]] = results[2]
		NumSpikes[results[0]] = results[3]
		MeanAPamp[results[0]] = results[4]
		ISICV[results[0]] = results[5]
else:
	print 'Step 1: submit jobs'
	for l in range(0,Vec_count): 
		pc.submit(getMeasures,l)
		print 'Trace Index Submit = ' + str(l)
	print 'Step 2: working'
	while pc.working():
		print 'Step 2A'
		print 'User ID = ' + str(pc.userid())
		results = pc.pyret()
		print 'Results = ' + str(results)
		print 'Step 2B: Store Results'
		StdVolt[results[0]] = results[1]
		MeanVolt[results[0]] = results[2]
		NumSpikes[results[0]] = results[3]
		MeanAPamp[results[0]] = results[4]
		ISICV[results[0]] = results[5]
		print 'Step 2C: Results Storage Complete'
print 'Step 3: Done'
pc.done()
# import multiprocessing
# from multiprocessing import Pool
# NUM_PROCS = multiprocessing.cpu_count()
# print('number of processors = ' + str(NUM_PROCS))
# pool = Pool(NUM_PROCS)
# chunksize = 10
# NumIndexes = Vec_count
# results = []
# results.append(pool.map(getMeasures,range(0,NumIndexes),chunksize))

# Reformat and sort measurement vectors according to trace indices (i.e. results[0][i][0])
# if pc.nhost() > 1:
#     for i in range(0,len(results)):
#         StdVolt[results[i][0]] = results[i][1]
#         MeanVolt[results[i][0]] = results[i][2]
#         NumSpikes[results[i][0]] = results[i][3]
#         MeanAPamp[results[i][0]] = results[i][4]
#         ISICV[results[i][0]] = results[i][5]

elapsed = time.time() - t
print elapsed
