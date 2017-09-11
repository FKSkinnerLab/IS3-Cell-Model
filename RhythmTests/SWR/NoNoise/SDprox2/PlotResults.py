### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
import scipy
from scipy import signal
from scipy import stats

Case = 'SDprox2_E_COM_I_COM'
EXCSLM = 0
EXCSR = 0
OLMSLM = 0
NGFSLM = 0
IS2SLM = 0
BISSR = 0
IS1SR = 0
EXC = 1
INH = 1
AddTheta = 0
AddSWR = 1
SWREXCSR = numpy.array([0,1,1,1,1])
SWRBISSR = numpy.array([0,0,1,1,1])
SWRIS1SR = numpy.array([0,0,0,1,1])
SWROLMSLM = numpy.array([0,0,0,0,1])

numExcThetaSyns = 27 # i.e. 3 connections so 9 synapses per connection
numInhThetaSyns = 8 # i.e. 2 connections so 4 synapses per connection
numExcSWRSyns = 27 # Just using the same as for theta
numInhSWRSyns = 8 # Just using the same as for theta
SaveExample = 1
synspikesrandseedvec1 = numpy.array([10,1,89189,76511,23884976]) # Note that I use the first index in future simulations
synspikesrandseedvec2 = numpy.array([15,77716,267826,47246,28])
synlocrandseedvec1 = numpy.array([5,889829,294,76161,299835])
synlocrandseedvec2 = numpy.array([2,26556284,42,189,9817])

# HC Treshold Measurement Values
tstop = 10 # seconds
font_size = 13

Examples = numpy.load('NPYfiles/' + Case + '_ExampleHCModelParams.npy')
ExampleStrings = numpy.load('NPYfiles/' + Case + '_ExampleHCModelStrings.npy')
thetaSynMultiplier = numpy.array([0, 0, 0, 0, 0])
SWRSynMultiplier = 0
tstop = h.tstop/1000
dt = h.dt

for randix in range(0,5):
	x = 0
	randseedsynspikes1 = synspikesrandseedvec1[randix]
	randseedsynspikes2 = synspikesrandseedvec2[randix]
	randseedsynloc1 = synlocrandseedvec1[randix]
	randseedsynloc2 = synlocrandseedvec2[randix]
	if Examples[0][x] == 0:
		print str(ExampleStrings[x]) + ' is empty'
		continue
	for y in range(0,5):
		print 'Simulating... ' + str(ExampleStrings[x]) + ' #' + str(y+1)
		ExampleString = ExampleStrings[x]
		HCNumber = x
		# Run Simulation of Example
		h.randomize_syns(randseedsynloc1,randseedsynloc2)
		h.f(Examples[0][x],Examples[1][x],Examples[2][x],Examples[3][x],SaveExample,randseedsynspikes1,randseedsynspikes2,AddTheta,INH*numInhThetaSyns*thetaSynMultiplier[y],EXC*numExcThetaSyns*thetaSynMultiplier[y],EXCSLM,EXCSR,OLMSLM,NGFSLM,IS2SLM,BISSR,IS1SR,SWREXCSR[y],SWRBISSR[y],SWRIS1SR[y],SWROLMSLM[y],numExcSWRSyns,numInhSWRSyns,AddSWR) # i.e. same random seeds when comparing runs
		
		HC_Trace = numpy.array(h.recV,dtype=numpy.float)
		voltvec = HC_Trace[1:len(HC_Trace)]
		SWRSynMultiplier = SWRSynMultiplier + 1
		bin_number = 30
		bin_range = (8000,10000)
		
		if y == 0:
			f2, axarr2 = matplotlib.pyplot.subplots(5, sharex=True)
			HC_Trace_Baseline = HC_Trace[10000:100001]
			HC_SpikeTimes_Baseline = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
			for i in range(0,len(h.apctimes)): HC_SpikeTimes_Baseline[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
			HC_SpikeTimes_Baseline = HC_SpikeTimes_Baseline[10000:100001]
			HC_SpikeTimes_Baseline2 = numpy.array(h.apctimes,dtype=numpy.float)
			
			axarr2[0].hist(HC_SpikeTimes_Baseline, bins = bin_number, range = bin_range, color = 'b', label = 'Baseline')
			axarr2[0].set_xlim(8000,10000)
			axarr2[0].spines['right'].set_visible(False)
			axarr2[0].spines['top'].set_visible(False)
			axarr2[0].spines['bottom'].set_visible(False)
			for tic in axarr2[0].xaxis.get_major_ticks():
				tic.tick1On = tic.tick2On = False
			leg = axarr2[0].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
		elif y == 1:
			HC_Trace_Rhythm = HC_Trace[10000:100001]
			HC_SpikeTimes_Rhythm = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
			for i in range(0,len(h.apctimes)): HC_SpikeTimes_Rhythm[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
			HC_SpikeTimes_Rhythm = HC_SpikeTimes_Rhythm[10000:100001]
			HC_SpikeTimes_Rhythm2 = numpy.array(h.apctimes,dtype=numpy.float)
			
			axarr2[1].hist(HC_SpikeTimes_Rhythm, bins = bin_number, range = bin_range, color = 'r', label = 'CA3')
			axarr2[1].axvline(9000, color='k', linestyle='dashed', linewidth=2)
			axarr2[1].set_xlim(8000,10000)
			axarr2[1].spines['right'].set_visible(False)
			axarr2[1].spines['top'].set_visible(False)
			axarr2[1].spines['bottom'].set_visible(False)
			for tic in axarr2[1].xaxis.get_major_ticks():
				tic.tick1On = tic.tick2On = False
			leg = axarr2[1].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
		elif y == 2:
			HC_Trace_X2Rhythm = HC_Trace[10000:100001]
			HC_SpikeTimes_X2Rhythm = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
			for i in range(0,len(h.apctimes)): HC_SpikeTimes_X2Rhythm[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
			HC_SpikeTimes_X2Rhythm = HC_SpikeTimes_X2Rhythm[10000:100001]
			HC_SpikeTimes_X2Rhythm2 = numpy.array(h.apctimes,dtype=numpy.float)
			
			axarr2[2].hist(HC_SpikeTimes_X2Rhythm, bins = bin_number, range = bin_range, color = 'g', label = 'CA3/BIS')
			axarr2[2].axvline(9000, color='k', linestyle='dashed', linewidth=2)
			axarr2[2].set_ylabel('Spike Count',fontsize=font_size-2)
			axarr2[2].set_xlim(8000,10000)
			axarr2[2].spines['right'].set_visible(False)
			axarr2[2].spines['top'].set_visible(False)
			axarr2[2].spines['bottom'].set_visible(False)
			for tic in axarr2[2].xaxis.get_major_ticks():
				tic.tick1On = tic.tick2On = False
			leg = axarr2[2].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
		elif y == 3:
			HC_Trace_X3Rhythm = HC_Trace[10000:100001]
			HC_SpikeTimes_X3Rhythm = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
			for i in range(0,len(h.apctimes)): HC_SpikeTimes_X3Rhythm[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
			HC_SpikeTimes_X3Rhythm = HC_SpikeTimes_X3Rhythm[10000:100001]
			HC_SpikeTimes_X3Rhythm2 = numpy.array(h.apctimes,dtype=numpy.float)
			
			axarr2[3].hist(HC_SpikeTimes_X3Rhythm, bins = bin_number, range = bin_range, color = 'c', label = 'CA3/BIS/IS1')
			axarr2[3].axvline(9000, color='k', linestyle='dashed', linewidth=2)
			axarr2[3].set_xlim(8000,10000)
			axarr2[3].spines['right'].set_visible(False)
			axarr2[3].spines['top'].set_visible(False)
			axarr2[3].spines['bottom'].set_visible(False)
			for tic in axarr2[3].xaxis.get_major_ticks():
				tic.tick1On = tic.tick2On = False
			leg = axarr2[3].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
		elif y == 4:
			HC_Trace_X4Rhythm = HC_Trace[10000:100001]
			HC_SpikeTimes_X4Rhythm = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
			for i in range(0,len(h.apctimes)): HC_SpikeTimes_X4Rhythm[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
			HC_SpikeTimes_X4Rhythm = HC_SpikeTimes_X4Rhythm[10000:100001]
			HC_SpikeTimes_X4Rhythm2 = numpy.array(h.apctimes,dtype=numpy.float)
			
			axarr2[4].hist(HC_SpikeTimes_X4Rhythm, bins = bin_number, range = bin_range, color = 'k', label = 'CA3/BIS/IS1/OLM')
			axarr2[4].axvline(9000, color='k', linestyle='dashed', linewidth=2)
			axarr2[4].set_xlim(8000,10000)
			axarr2[4].spines['right'].set_visible(False)
			axarr2[4].spines['top'].set_visible(False)
			leg = axarr2[4].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
			
			f2.savefig('PLOTfiles/' + Case + '_Hist_' + str(randix) + '_randix_' + ExampleString + '.pdf', bbox_inches='tight')
			f2.savefig('PLOTfiles/' + Case + '_Hist_' + str(randix) + '_randix_' + ExampleString + '.png', bbox_inches='tight')
		
		timevec = numpy.arange(0,10000.1,0.1)
		if y == 0:
			voltvec_baseline = HC_Trace
			f, axarr = matplotlib.pyplot.subplots(5, sharex=True)
			axarr[0].plot(timevec,voltvec_baseline,'b',label = 'Baseline')
			axarr[0].set_ylim(-85,30)
			axarr[0].set_xlim(8000,10000)
			axarr[0].spines['right'].set_visible(False)
			axarr[0].spines['top'].set_visible(False)
			axarr[0].spines['bottom'].set_visible(False)
			for tic in axarr[0].xaxis.get_major_ticks():
				tic.tick1On = tic.tick2On = False
			leg = axarr[0].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
		elif y == 1:
			voltvec_X1Rhythm = HC_Trace
			axarr[1].plot(timevec,voltvec_X1Rhythm,'r',label = 'CA3')
			axarr[1].axvline(9000, color='k', linestyle='dashed', linewidth=2)
			axarr[1].set_ylim(-85,30)
			axarr[1].set_xlim(8000,10000)
			axarr[1].spines['right'].set_visible(False)
			axarr[1].spines['top'].set_visible(False)
			axarr[1].spines['bottom'].set_visible(False)
			for tic in axarr[1].xaxis.get_major_ticks():
				tic.tick1On = tic.tick2On = False
			leg = axarr[1].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
		elif y == 2:
			voltvec_X2Rhythm = HC_Trace
			axarr[2].plot(timevec,voltvec_X2Rhythm,'g',label = 'CA3/BIS')
			axarr[2].axvline(9000, color='k', linestyle='dashed', linewidth=2)
			axarr[2].set_ylim(-85,30)
			axarr[2].set_ylabel('Voltage (mV)',fontsize=font_size-2)
			axarr[2].set_xlim(8000,10000)
			axarr[2].spines['right'].set_visible(False)
			axarr[2].spines['top'].set_visible(False)
			axarr[2].spines['bottom'].set_visible(False)
			for tic in axarr[2].xaxis.get_major_ticks():
				tic.tick1On = tic.tick2On = False
			leg = axarr[2].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
		elif y == 3:
			voltvec_X3Rhythm = HC_Trace
			axarr[3].plot(timevec,voltvec_X3Rhythm,'c',label = 'CA3/BIS/IS1')
			axarr[3].axvline(9000, color='k', linestyle='dashed', linewidth=2)
			axarr[3].set_ylim(-85,30)
			axarr[3].set_xlim(8000,10000)
			axarr[3].spines['right'].set_visible(False)
			axarr[3].spines['top'].set_visible(False)
			axarr[3].spines['bottom'].set_visible(False)
			for tic in axarr[3].xaxis.get_major_ticks():
				tic.tick1On = tic.tick2On = False
			leg = axarr[3].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
		elif y == 4:
			voltvec_X4Rhythm = HC_Trace
			axarr[4].plot(timevec,voltvec_X4Rhythm,'k',label = 'CA3/BIS/IS1/OLM')
			axarr[4].axvline(9000, color='k', linestyle='dashed', linewidth=2)
			axarr[4].set_ylim(-85,30)
			axarr[4].set_xlim(8000,10000)
			axarr[4].set_xlabel('Time (ms)',fontsize=font_size-2)
			axarr[4].spines['right'].set_visible(False)
			axarr[4].spines['top'].set_visible(False)
			leg = axarr[4].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
			leg.get_frame().set_alpha(1)
			for item in leg.legendHandles:
				item.set_visible(False)
			
			f.savefig('PLOTfiles/' + Case + '_Trace_' + str(randix) + '_randix_' + ExampleString + '.pdf', bbox_inches='tight')
			f.savefig('PLOTfiles/' + Case + '_Trace_' + str(randix) + '_randix_' + ExampleString + '.png', bbox_inches='tight')
		
		if y > 0:
			f3, axarr3 = matplotlib.pyplot.subplots(1)
			if SWREXCSR[y] == 1:
				for j in range(0,int(h.excSWRcount)):
					randind = int(h.EXCrandSRSWR.x[j])
					if randind == -1: randind = 0
					SWRVec = numpy.array([],dtype=numpy.float)
					for q in range(0,len(h.SWRSRexcprespiketrains[randind])): SWRVec = numpy.append(SWRVec,h.SWRSRexcprespiketrains[randind].x[q])
					SWRVec = numpy.array(SWRVec,dtype=numpy.float)
					axarr3.vlines(SWRVec,j+0.75,j+1.25,'g')
			if SWRBISSR[y] == 1:
				for o in range(0,int(h.inhSWRcount)):
					randind = int(h.BISrandSRSWR.x[o])
					if randind == -1: randind = 0
					SWRVec = numpy.array([],dtype=numpy.float)
					for q in range(0,len(h.SWRSRBISprespiketrains[randind])): SWRVec = numpy.append(SWRVec,h.SWRSRBISprespiketrains[randind].x[q])
					SWRVec = numpy.array(SWRVec,dtype=numpy.float)
					axarr3.vlines(SWRVec,o+j+1.75,o+j+2.25,'k')
			if SWRIS1SR[y] == 1:
				for p in range(0,int(h.inhSWRcount)):
					randind = int(h.IS1randSRSWR.x[p])
					if randind == -1: randind = 0
					SWRVec = numpy.array([],dtype=numpy.float)
					for q in range(0,len(h.SWRSRIS1prespiketrains[randind])): SWRVec = numpy.append(SWRVec,h.SWRSRIS1prespiketrains[randind].x[q])
					SWRVec = numpy.array(SWRVec,dtype=numpy.float)
					axarr3.vlines(SWRVec,p+o+j+2.75,p+o+j+3.25,color='orange')
			if SWROLMSLM[y] == 1:
				for l in range(0,int(h.inhSWRcount)):
					randind = int(h.OLMrandSLMSWR.x[l])
					if randind == -1: randind = 0
					SWRVec = numpy.array([],dtype=numpy.float)
					for q in range(0,len(h.SWRSLMOLMprespiketrains[randind])): SWRVec = numpy.append(SWRVec,h.SWRSLMOLMprespiketrains[randind].x[q])
					SWRVec = numpy.array(SWRVec,dtype=numpy.float)
					axarr3.vlines(SWRVec,l+p+o+j+3.75,l+p+o+j+4.25,'m')
			axarr3.set_xlim(8990,9100)
			if SWREXCSR[y] == 1 and SWRBISSR[y] == 0 and SWRIS1SR[y] == 0 and SWROLMSLM[y] == 0:
				axarr3.set_ylim(0,j+2)
			if SWREXCSR[y] == 1 and SWRBISSR[y] == 1 and SWRIS1SR[y] == 0 and SWROLMSLM[y] == 0:
				axarr3.set_ylim(0,o+j+3)
			if SWREXCSR[y] == 1 and SWRBISSR[y] == 1 and SWRIS1SR[y] == 1 and SWROLMSLM[y] == 0:
				axarr3.set_ylim(0,p+o+j+4)
			if SWREXCSR[y] == 1 and SWRBISSR[y] == 1 and SWRIS1SR[y] == 1 and SWROLMSLM[y] == 1:
				axarr3.set_ylim(0,p+o+l+j+5)
			axarr3.set_xlabel('Time (ms)',fontsize=font_size-4)
			axarr3.set_ylabel('Synapse Number',fontsize=font_size-4)
			f3.savefig('PLOTfiles/' + Case + '_SWRPresynapticSpikes_' + ExampleString + '_X' + str(y) + '_SWRMultiplier' + '.pdf', bbox_inches='tight')
			f3.savefig('PLOTfiles/' + Case + '_SWRPresynapticSpikes_' + ExampleString + '_X' + str(y) + '_SWRMultiplier' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
	
	bin_number = 1
	bin_range = (9000,9050)
	
	heights1,bins1 = numpy.histogram(HC_SpikeTimes_Baseline,bins=bin_number,range=bin_range)
	heights2,bins2 = numpy.histogram(HC_SpikeTimes_Rhythm,bins=bin_number,range=bin_range)
	heights3,bins3 = numpy.histogram(HC_SpikeTimes_X2Rhythm,bins=bin_number,range=bin_range)
	heights4,bins4 = numpy.histogram(HC_SpikeTimes_X3Rhythm,bins=bin_number,range=bin_range)
	heights5,bins5 = numpy.histogram(HC_SpikeTimes_X4Rhythm,bins=bin_number,range=bin_range)
	
	ind = numpy.arange(5)
	width = 0.4
	f4, axarr4 = matplotlib.pyplot.subplots(1, sharex=True)
	axarr4.bar(ind+width, [heights1, heights2, heights3, heights4, heights5], width, color='k')
	axarr4.set_xticks(ind+width)
	axarr4.set_xticklabels(('Base','CA3','CA3/BIS','CA3/BIS/IS1','CA3/BIS/IS1/OLM'),fontsize=font_size-3, fontweight='bold', rotation=45)
	axarr4.set_ylabel('Spike Count During SWR')
	axarr4.set_xlim(0,5+width)
	pyplot.tight_layout()
	f4.savefig('PLOTfiles/' + Case + '_SWRSpikeCount_' + str(randix) + '_randix_' + ExampleString + '.pdf', bbox_inches='tight')
	f4.savefig('PLOTfiles/' + Case + '_SWRSpikeCount_' + str(randix) + '_randix_' + ExampleString + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()



