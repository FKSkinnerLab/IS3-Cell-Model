### Test Script for a file found in the SDprox2 results from initial Parallel Simulations

import efel
import numpy
import time

t = time.time()

NumInh_max = h.testninhsyns
NumExc_max = h.testnexcsyns
NumInh_res = h.inhsynres
NumExc_res = h.excsynres
InhSpikes_max = h.maxinhspikes
ExcSpikes_max = h.maxexcSRspikes
InhSpikes_res = h.inhspikeresolution
ExcSpikes_res = h.excSRspikeresolution
NumExcCommon_max = h.maxcommonexc
NumInhCommon_max = h.maxcommoninh

NumInh = numpy.arange(NumInh_res,NumInh_max+1,NumInh_res)
NumExc = numpy.arange(NumExc_res,NumExc_max+1,NumExc_res)
InhSpikes = numpy.arange(0,InhSpikes_max+1,InhSpikes_res)
ExcSRSpikes = numpy.arange(0,ExcSpikes_max+1,ExcSpikes_res)
ExcSLMSpikes = numpy.arange(0,ExcSpikes_max+1,ExcSpikes_res)
NumExcCommon = numpy.array([NumExcCommon_max])
NumInhCommon = numpy.array([NumInhCommon_max])

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

data = numpy.zeros((100001,), dtype=numpy.float64)
tstop = h.tstop
dt = h.dt
def getMeasures(TrIn):	
	trace_index = int(TrIn)
	h.f(TrIn) # Runs Simulation
	for p in range(0,int(tstop/dt+1)): data[p] = h.recV[p]
	timevec = numpy.arange(1000,int(tstop/dt+1),dt)
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

# Set up parallel context
pc = h.ParallelContext()
pc.runworker()
if pc.nhost() == 1:
	for l in range(0,Vec_count): 
		results = getMeasures(l)
		StdVolt[results[0]] = results[1]
		MeanVolt[results[0]] = results[2]
		NumSpikes[results[0]] = results[3]
		MeanAPamp[results[0]] = results[4]
		ISICV[results[0]] = results[5]
else:
	for l in range(0,Vec_count): 
		pc.submit(getMeasures,l)
	while pc.working():
		results = pc.pyret()
		StdVolt[results[0]] = results[1]
		MeanVolt[results[0]] = results[2]
		NumSpikes[results[0]] = results[3]
		MeanAPamp[results[0]] = results[4]
		ISICV[results[0]] = results[5]
pc.done()

elapsed = time.time() - t
print elapsed
