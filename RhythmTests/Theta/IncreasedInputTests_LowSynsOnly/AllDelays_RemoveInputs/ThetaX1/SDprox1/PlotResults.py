### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
import scipy
from scipy import signal
from scipy import stats

Case = 'SDprox1_E_COM_I_COM'
EXCSLM = 1
EXCSR = 1
OLMSLM = 1
NGFSLM = 1
IS2SLM = 1
BISSR = 1
IS1SR = 1
EXC = 1
INH = 1

numExcThetaSyns = 27 # i.e. 3 connections so 9 synapses per connection
numInhThetaSyns = 8 # i.e. 2 connections so 4 synapses per connection
SaveExample = 1
randseed1 = 10 # if using fixed random seeds
randseed2 = 15

# HC Treshold Measurement Values
tstop = 10 # seconds
font_size = 13

Examples = numpy.load('NPYfiles/' + Case + '_ExampleHCModelParams.npy')
ExampleStrings = numpy.load('NPYfiles/' + Case + '_ExampleHCModelStrings.npy')
thetaSynMultiplier = numpy.array([0, 1, 1, 1, 1, 1, 1, 1])
prethetanoise = numpy.array([0.01])

tstop = h.tstop/1000
dt = h.dt

for x2 in range(0,1):
	if Examples[0][x2] == 0:
		print str(ExampleStrings[x2]) + ' is empty'
		continue
	for n in prethetanoise:
		for y in range(0,8):
			print 'Simulating... ' + str(ExampleStrings[x2]) + ' #' + str(y+1)
			if y == 1:
				EXCSLM = 1
				EXCSR = 1
				OLMSLM = 1
				NGFSLM = 1
				IS2SLM = 1
				BISSR = 1
				IS1SR = 1
				EXC = 1
				INH = 1
			elif y == 2:
				EXCSLM = 1
				EXCSR = 0
				OLMSLM = 1
				NGFSLM = 1
				IS2SLM = 1
				BISSR = 1
				IS1SR = 1
				EXC = 1
				INH = 1
			elif y == 3:
				EXCSLM = 0
				EXCSR = 1
				OLMSLM = 1
				NGFSLM = 1
				IS2SLM = 1
				BISSR = 1
				IS1SR = 1
				EXC = 1
				INH = 1
			elif y == 4:
				EXCSLM = 1
				EXCSR = 1
				OLMSLM = 0
				NGFSLM = 1
				IS2SLM = 1
				BISSR = 1
				IS1SR = 1
				EXC = 1
				INH = 1
			elif y == 5:
				EXCSLM = 1
				EXCSR = 1
				OLMSLM = 1
				NGFSLM = 1
				IS2SLM = 0
				BISSR = 1
				IS1SR = 1
				EXC = 1
				INH = 1
			elif y == 6:
				EXCSLM = 1
				EXCSR = 1
				OLMSLM = 1
				NGFSLM = 1
				IS2SLM = 1
				BISSR = 0
				IS1SR = 1
				EXC = 1
				INH = 1
			elif y == 7:
				EXCSLM = 1
				EXCSR = 1
				OLMSLM = 1
				NGFSLM = 1
				IS2SLM = 1
				BISSR = 1
				IS1SR = 0
				EXC = 1
				INH = 1
			ExampleString = ExampleStrings[x2]
			HCNumber = x2
			# Run Simulation of Example
			h.randomize_syns(5,2) # i.e. same random seeds when comparing runs
			h.f(Examples[0][x2],Examples[1][x2],Examples[2][x2],Examples[3][x2],SaveExample,randseed1,randseed2,1,INH*numInhThetaSyns*thetaSynMultiplier[y],EXC*numExcThetaSyns*thetaSynMultiplier[y],EXCSLM,EXCSR,OLMSLM,NGFSLM,IS2SLM,BISSR,IS1SR,n) # i.e. same random seeds when comparing runs
			
			HC_Trace = numpy.fromfile("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('model_',str(Examples[0][x2]),'_NumInh_',str(Examples[1][x2]),'_NumExc_',str(Examples[2][x2]),'_InhSpikes_',str(Examples[3][x2]),'_ExcSRSpikes_',str(Examples[3][x2]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon_X',str(thetaSynMultiplier[y]),'_ThetaMultiplier_',str('%0.2f' %h.prethetanoise),'_prethetanoise.dat'),dtype=float)
			voltvec = HC_Trace[1:len(HC_Trace)]
			
			if y == 0:
				HC_Trace_Baseline = HC_Trace[10000:100001]
				HC_SpikeTimes_Baseline = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
				for i in range(0,len(h.apctimes)): HC_SpikeTimes_Baseline[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
				HC_SpikeTimes_Baseline = HC_SpikeTimes_Baseline[10000:100001]
				HC_SpikeTimes_Baseline2 = numpy.array(h.apctimes,dtype=numpy.float)
			elif y == 1:
				HC_Trace_Rhythm = HC_Trace[10000:100001]
				HC_SpikeTimes_Rhythm = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
				for i in range(0,len(h.apctimes)): HC_SpikeTimes_Rhythm[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
				HC_SpikeTimes_Rhythm = HC_SpikeTimes_Rhythm[10000:100001]
				HC_SpikeTimes_Rhythm2 = numpy.array(h.apctimes,dtype=numpy.float)
			elif y == 2:
				HC_Trace_CA3Removed = HC_Trace[10000:100001]
				HC_SpikeTimes_CA3Removed = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
				for i in range(0,len(h.apctimes)): HC_SpikeTimes_CA3Removed[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
				HC_SpikeTimes_CA3Removed = HC_SpikeTimes_CA3Removed[10000:100001]
				HC_SpikeTimes_CA3Removed2 = numpy.array(h.apctimes,dtype=numpy.float)
			elif y == 3:
				HC_Trace_EC3Removed = HC_Trace[10000:100001]
				HC_SpikeTimes_EC3Removed = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
				for i in range(0,len(h.apctimes)): HC_SpikeTimes_EC3Removed[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
				HC_SpikeTimes_EC3Removed = HC_SpikeTimes_EC3Removed[10000:100001]
				HC_SpikeTimes_EC3Removed2 = numpy.array(h.apctimes,dtype=numpy.float)
			elif y == 4:
				HC_Trace_OLMRemoved = HC_Trace[10000:100001]
				HC_SpikeTimes_OLMRemoved = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
				for i in range(0,len(h.apctimes)): HC_SpikeTimes_OLMRemoved[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
				HC_SpikeTimes_OLMRemoved = HC_SpikeTimes_OLMRemoved[10000:100001]
				HC_SpikeTimes_OLMRemoved2 = numpy.array(h.apctimes,dtype=numpy.float)
			elif y == 5:
				HC_Trace_IS2NGFRemoved = HC_Trace[10000:100001]
				HC_SpikeTimes_IS2NGFRemoved = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
				for i in range(0,len(h.apctimes)): HC_SpikeTimes_IS2NGFRemoved[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
				HC_SpikeTimes_IS2NGFRemoved = HC_SpikeTimes_IS2NGFRemoved[10000:100001]
				HC_SpikeTimes_IS2NGFRemoved2 = numpy.array(h.apctimes,dtype=numpy.float)
			elif y == 6:
				HC_Trace_BISRemoved = HC_Trace[10000:100001]
				HC_SpikeTimes_BISRemoved = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
				for i in range(0,len(h.apctimes)): HC_SpikeTimes_BISRemoved[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
				HC_SpikeTimes_BISRemoved = HC_SpikeTimes_BISRemoved[10000:100001]
				HC_SpikeTimes_BISRemoved2 = numpy.array(h.apctimes,dtype=numpy.float)
			elif y == 7:
				HC_Trace_IS1Removed = HC_Trace[10000:100001]
				HC_SpikeTimes_IS1Removed = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
				for i in range(0,len(h.apctimes)): HC_SpikeTimes_IS1Removed[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
				HC_SpikeTimes_IS1Removed = HC_SpikeTimes_IS1Removed[10000:100001]
				HC_SpikeTimes_IS1Removed2 = numpy.array(h.apctimes,dtype=numpy.float)
			
			timevec = numpy.arange(0,10000.1,0.1)
			if y == 0:
				f, axarr = matplotlib.pyplot.subplots(8, sharex=True)
				axarr[0].plot(timevec,voltvec,'b',label='Base')
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
			if y == 1:
				axarr[1].plot(timevec,voltvec,'r',label='Theta')
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
			if y == 2:
				axarr[2].plot(timevec,voltvec,'g',label='-CA3')
				axarr[2].set_ylim(-85,30)
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
			if y == 3:
				axarr[3].plot(timevec,voltvec,'c',label='-EC3')
				axarr[3].set_ylim(-85,30)
				axarr[3].set_xlim(8000,10000)
				axarr[3].set_ylabel('Voltage (mV)         ',fontsize=font_size-2)
				axarr[3].spines['right'].set_visible(False)
				axarr[3].spines['top'].set_visible(False)
				axarr[3].spines['bottom'].set_visible(False)
				for tic in axarr[3].xaxis.get_major_ticks():
					tic.tick1On = tic.tick2On = False
				leg = axarr[3].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
				leg.get_frame().set_alpha(1)
				for item in leg.legendHandles:
					item.set_visible(False)
			if y == 4:
				axarr[4].plot(timevec,voltvec,'m',label='-OLM')
				axarr[4].set_ylim(-85,30)
				axarr[4].set_xlim(8000,10000)
				axarr[4].spines['right'].set_visible(False)
				axarr[4].spines['top'].set_visible(False)				
				axarr[4].spines['bottom'].set_visible(False)
				for tic in axarr[4].xaxis.get_major_ticks():
					tic.tick1On = tic.tick2On = False
				leg = axarr[4].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
				leg.get_frame().set_alpha(1)
				for item in leg.legendHandles:
					item.set_visible(False)
			if y == 5:
				axarr[5].plot(timevec,voltvec,'y',label='-IS2/NGF')
				axarr[5].set_ylim(-85,30)
				axarr[5].set_xlim(8000,10000)
				axarr[5].spines['right'].set_visible(False)
				axarr[5].spines['top'].set_visible(False)
				axarr[5].spines['bottom'].set_visible(False)
				for tic in axarr[5].xaxis.get_major_ticks():
					tic.tick1On = tic.tick2On = False
				leg = axarr[5].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
				leg.get_frame().set_alpha(1)
				for item in leg.legendHandles:
					item.set_visible(False)
			if y == 6:
				axarr[6].plot(timevec,voltvec,'k',label='-BIS')
				axarr[6].set_ylim(-85,30)
				axarr[6].set_xlim(8000,10000)
				axarr[6].spines['right'].set_visible(False)
				axarr[6].spines['top'].set_visible(False)
				axarr[6].spines['bottom'].set_visible(False)
				for tic in axarr[6].xaxis.get_major_ticks():
					tic.tick1On = tic.tick2On = False
				leg = axarr[6].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
				leg.get_frame().set_alpha(1)
				for item in leg.legendHandles:
					item.set_visible(False)
			if y == 7:
				axarr[7].plot(timevec,voltvec,'orange',label='-IS1')
				axarr[7].set_ylim(-85,30)
				axarr[7].set_xlim(8000,10000)
				axarr[7].set_xlabel('Time (ms)',fontsize=font_size-2)
				axarr[7].spines['right'].set_visible(False)
				axarr[7].spines['top'].set_visible(False)
				leg = axarr[7].legend(loc="upper right", handlelength=0, handletextpad=0, fancybox=True)
				leg.get_frame().set_alpha(1)
				for item in leg.legendHandles:
					item.set_visible(False)
				
				pyplot.savefig('PLOTfiles/' + Case + '_Trace_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
				pyplot.savefig('PLOTfiles/' + Case + '_Trace_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
				pyplot.gcf().clear()
				pyplot.cla()
				pyplot.clf()
				pyplot.close()
		f, axarr = matplotlib.pyplot.subplots(2, sharex=False) 
		f1, Pxx_den1 = signal.welch(HC_SpikeTimes_Baseline, 1/(dt/1000), nperseg=25000)
		f2, Pxx_den2 = signal.welch(HC_SpikeTimes_Rhythm, 1/(dt/1000), nperseg=25000)
		f3, Pxx_den3 = signal.welch(HC_SpikeTimes_CA3Removed, 1/(dt/1000), nperseg=25000)
		f4, Pxx_den4 = signal.welch(HC_SpikeTimes_EC3Removed, 1/(dt/1000), nperseg=25000)
		f5, Pxx_den5 = signal.welch(HC_SpikeTimes_OLMRemoved, 1/(dt/1000), nperseg=25000)
		f6, Pxx_den6 = signal.welch(HC_SpikeTimes_IS2NGFRemoved, 1/(dt/1000), nperseg=25000)
		f7, Pxx_den7 = signal.welch(HC_SpikeTimes_BISRemoved, 1/(dt/1000), nperseg=25000)
		f8, Pxx_den8 = signal.welch(HC_SpikeTimes_IS1Removed, 1/(dt/1000), nperseg=25000)
		numpy.save('NPYfiles/' + Case + '_SpikeTimesBaseline_' + str(HCNumber) + '_HCNumber_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',HC_SpikeTimes_Baseline2)
		numpy.save('NPYfiles/' + Case + '_SpikeTimesRhythm_' + str(HCNumber) + '_HCNumber_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',HC_SpikeTimes_Rhythm2)
		numpy.save('NPYfiles/' + Case + '_SpikeTimesRhythm_' + str(HCNumber) + '_HCNumber_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',HC_SpikeTimes_CA3Removed2)
		numpy.save('NPYfiles/' + Case + '_SpikeTimesRhythm_' + str(HCNumber) + '_HCNumber_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',HC_SpikeTimes_EC3Removed2)
		numpy.save('NPYfiles/' + Case + '_SpikeTimesRhythm_' + str(HCNumber) + '_HCNumber_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',HC_SpikeTimes_OLMRemoved2)
		numpy.save('NPYfiles/' + Case + '_SpikeTimesRhythm_' + str(HCNumber) + '_HCNumber_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',HC_SpikeTimes_IS2NGFRemoved2)
		numpy.save('NPYfiles/' + Case + '_SpikeTimesRhythm_' + str(HCNumber) + '_HCNumber_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',HC_SpikeTimes_BISRemoved2)
		numpy.save('NPYfiles/' + Case + '_SpikeTimesRhythm_' + str(HCNumber) + '_HCNumber_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',HC_SpikeTimes_IS1Removed2)
		axarr[0].loglog(f1, Pxx_den1,'b')
		axarr[0].loglog(f2, Pxx_den2,'r')
		axarr[0].loglog(f3, Pxx_den3,'g')
		axarr[0].loglog(f4, Pxx_den4,'c')
		axarr[0].loglog(f5, Pxx_den5,'m')
		axarr[0].loglog(f6, Pxx_den6,'y')
		axarr[0].loglog(f7, Pxx_den7,'k')
		axarr[0].loglog(f8, Pxx_den8,color='orange')
		axarr[0].hlines(numpy.amax(Pxx_den2),4,12,'k',linestyles='solid')
		axarr[0].text(4.05,numpy.amax(Pxx_den2)+30,'Theta (4-12Hz)')
		axarr[0].axvline(numpy.array([4]),ymin=0,ymax=0.95,color='k',linestyle='solid')
		axarr[0].axvline(numpy.array([12]),ymin=0,ymax=0.95,color='k',linestyle='solid')
		axarr[0].axvline(numpy.array([8]),ymin=0,ymax=0.95,color='k',linestyle='dashed')
		axarr[0].set_xlim(0,100)
		axarr[0].set_xlabel('frequency (Hz)')
		axarr[0].set_ylabel(r'$PSD (Spikes^2 / Hz)$')
		axarr[0].spines['right'].set_visible(False)
		axarr[0].spines['top'].set_visible(False)
		
		ind = numpy.arange(8)
		width = 0.4
		Area1 = numpy.trapz(Pxx_den1[(f1>4) & (f1<12)],x=f1[(f1>4) & (f1<12)])
		Area2 = numpy.trapz(Pxx_den2[(f2>4) & (f2<12)],x=f2[(f2>4) & (f2<12)])
		Area3 = numpy.trapz(Pxx_den3[(f3>4) & (f3<12)],x=f3[(f3>4) & (f3<12)])
		Area4 = numpy.trapz(Pxx_den4[(f4>4) & (f4<12)],x=f4[(f4>4) & (f4<12)])
		Area5 = numpy.trapz(Pxx_den5[(f5>4) & (f5<12)],x=f5[(f5>4) & (f5<12)])
		Area6 = numpy.trapz(Pxx_den6[(f6>4) & (f6<12)],x=f6[(f6>4) & (f6<12)])
		Area7 = numpy.trapz(Pxx_den7[(f7>4) & (f7<12)],x=f7[(f7>4) & (f7<12)])
		Area8 = numpy.trapz(Pxx_den8[(f8>4) & (f8<12)],x=f8[(f8>4) & (f8<12)])
		e8Hz1 = Pxx_den1[f1==8]
		e8Hz2 = Pxx_den2[f2==8]
		e8Hz3 = Pxx_den3[f3==8]
		e8Hz4 = Pxx_den4[f4==8]
		e8Hz5 = Pxx_den5[f5==8]
		e8Hz6 = Pxx_den6[f6==8]
		e8Hz7 = Pxx_den7[f7==8]
		e8Hz8 = Pxx_den8[f8==8]
		axarr[1].bar(ind+width, [e8Hz1, e8Hz2, e8Hz3, e8Hz4, e8Hz5, e8Hz6, e8Hz7, e8Hz8], width, color='k')
		axarr[1].set_xticks(ind+width)
		axarr[1].set_xticklabels(('Base','Theta','-CA3','-EC3','-OLM','-IS2/NGF','-BIS','-IS1'),fontsize=font_size-3, fontweight='bold', rotation=45)
		axarr[1].set_ylabel('PSD Magnitude At 8Hz')
		axarr[1].set_xlim(0,8+width)
		axarr[1].spines['right'].set_visible(False)
		axarr[1].spines['top'].set_visible(False)
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PSD_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PSD_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
		
		# Instantaneous Frequency Analyses (Note this is converting the ISIs into seconds and then instantaneous frequencies)
		IF_Baseline = numpy.concatenate([numpy.array([0],dtype=numpy.float),1000/numpy.diff(HC_SpikeTimes_Baseline2)])
		IF_ThetaX1 = numpy.concatenate([numpy.array([0],dtype=numpy.float),1000/numpy.diff(HC_SpikeTimes_Rhythm2)])
		IF_CA3Removed = numpy.concatenate([numpy.array([0],dtype=numpy.float),1000/numpy.diff(HC_SpikeTimes_CA3Removed2)])
		IF_EC3Removed = numpy.concatenate([numpy.array([0],dtype=numpy.float),1000/numpy.diff(HC_SpikeTimes_EC3Removed2)])
		IF_OLMRemoved = numpy.concatenate([numpy.array([0],dtype=numpy.float),1000/numpy.diff(HC_SpikeTimes_OLMRemoved2)])
		IF_IS2NGFRemoved = numpy.concatenate([numpy.array([0],dtype=numpy.float),1000/numpy.diff(HC_SpikeTimes_IS2NGFRemoved2)])
		IF_BISRemoved = numpy.concatenate([numpy.array([0],dtype=numpy.float),1000/numpy.diff(HC_SpikeTimes_BISRemoved2)])
		IF_IS1Removed = numpy.concatenate([numpy.array([0],dtype=numpy.float),1000/numpy.diff(HC_SpikeTimes_IS1Removed2)])
		
		range_if = (0,100)
		heights1,bins1 = numpy.histogram(IF_Baseline,bins=100,range=range_if)
		heights2,bins2 = numpy.histogram(IF_ThetaX1,bins=100,range=range_if)
		heights3,bins3 = numpy.histogram(IF_CA3Removed,bins=100,range=range_if)
		heights4,bins4 = numpy.histogram(IF_EC3Removed,bins=100,range=range_if)
		heights5,bins5 = numpy.histogram(IF_OLMRemoved,bins=100,range=range_if)
		heights6,bins6 = numpy.histogram(IF_IS2NGFRemoved,bins=100,range=range_if)
		heights7,bins7 = numpy.histogram(IF_BISRemoved,bins=100,range=range_if)
		heights8,bins8 = numpy.histogram(IF_IS1Removed,bins=100,range=range_if)
		
		# Normalize
		heights1 = heights1/float(sum(heights1))
		heights2 = heights2/float(sum(heights2))
		heights3 = heights3/float(sum(heights3))
		heights4 = heights4/float(sum(heights4))
		heights5 = heights5/float(sum(heights5))
		heights6 = heights6/float(sum(heights6))
		heights7 = heights7/float(sum(heights7))
		heights8 = heights8/float(sum(heights8))
		bin1=bins1[:-1]+numpy.diff(bins1)/2.
		bin2=bins2[:-1]+numpy.diff(bins2)/2.
		bin3=bins3[:-1]+numpy.diff(bins3)/2.
		bin4=bins4[:-1]+numpy.diff(bins4)/2.
		bin5=bins5[:-1]+numpy.diff(bins5)/2.
		bin6=bins6[:-1]+numpy.diff(bins6)/2.
		bin7=bins7[:-1]+numpy.diff(bins7)/2.
		bin8=bins8[:-1]+numpy.diff(bins8)/2.
		binMids1 = bin1[~numpy.isnan(bin1)]
		binMids2 = bin2[~numpy.isnan(bin2)]
		binMids3 = bin3[~numpy.isnan(bin3)]
		binMids4 = bin4[~numpy.isnan(bin4)]
		binMids5 = bin5[~numpy.isnan(bin5)]
		binMids6 = bin6[~numpy.isnan(bin6)]
		binMids7 = bin7[~numpy.isnan(bin7)]
		binMids8 = bin8[~numpy.isnan(bin8)]
		heights1 = heights1[~numpy.isnan(bin1)]
		heights2 = heights2[~numpy.isnan(bin2)]
		heights3 = heights3[~numpy.isnan(bin3)]
		heights4 = heights4[~numpy.isnan(bin4)]
		heights5 = heights5[~numpy.isnan(bin5)]
		heights6 = heights6[~numpy.isnan(bin6)]
		heights7 = heights7[~numpy.isnan(bin7)]
		heights8 = heights8[~numpy.isnan(bin8)]
		
		f, axarr = matplotlib.pyplot.subplots(2, sharex=False) 
		axarr[0].semilogx(binMids1,heights1,'b')
		axarr[0].semilogx(binMids2,heights2,'r')
		axarr[0].semilogx(binMids3,heights3,'g')
		axarr[0].semilogx(binMids4,heights4,'c')
		axarr[0].semilogx(binMids5,heights5,'m')
		axarr[0].semilogx(binMids6,heights6,'y')
		axarr[0].semilogx(binMids7,heights7,'k')
		axarr[0].semilogx(binMids8,heights8,color='orange')
		axarr[0].vlines(numpy.array([4,12]),0,numpy.amax(heights2)+0.01,'k',linestyles='solid')
		axarr[0].vlines(numpy.array([8]),0,numpy.amax(heights2)+0.01,'k',linestyles='dashed')
		axarr[0].hlines(numpy.amax(heights2)+0.01,4,12,'k',linestyles='solid')
		axarr[0].text(4.3,numpy.amax(heights2)+0.02,'Theta (4-12Hz)')
		axarr[0].set_xlabel('Frequency (Hz)')
		axarr[0].set_ylabel('Probability')
		axarr[0].set_xlim(0,130)
		axarr[0].set_ylim(0,0.19)
		axarr[0].spines['right'].set_visible(False)
		axarr[0].spines['top'].set_visible(False)
		
		ind = numpy.arange(8)
		width = 0.4
		Area11 = numpy.trapz(heights1[(binMids1>4) & (binMids1<8)],x=binMids1[(binMids1>4) & (binMids1<8)])
		Area22 = numpy.trapz(heights2[(binMids2>4) & (binMids2<8)],x=binMids2[(binMids2>4) & (binMids2<8)])
		Area33 = numpy.trapz(heights3[(binMids3>4) & (binMids3<8)],x=binMids3[(binMids3>4) & (binMids3<8)])
		Area44 = numpy.trapz(heights4[(binMids4>4) & (binMids4<8)],x=binMids4[(binMids4>4) & (binMids4<8)])
		Area55 = numpy.trapz(heights5[(binMids5>4) & (binMids5<8)],x=binMids5[(binMids5>4) & (binMids5<8)])
		Area66 = numpy.trapz(heights6[(binMids6>4) & (binMids6<8)],x=binMids6[(binMids6>4) & (binMids6<8)])
		Area77 = numpy.trapz(heights7[(binMids7>4) & (binMids7<8)],x=binMids7[(binMids7>4) & (binMids7<8)])
		Area88 = numpy.trapz(heights8[(binMids8>4) & (binMids8<8)],x=binMids8[(binMids8>4) & (binMids8<8)])
		e8Hz11 = numpy.trapz(heights1[(binMids1>8) & (binMids1<12)],x=binMids1[(binMids1>8) & (binMids1<12)]) #IF NOT THIS TRY NUMPY.AMAX BETWEEN 7 AND 9
		e8Hz22 = numpy.trapz(heights2[(binMids2>8) & (binMids2<12)],x=binMids2[(binMids2>8) & (binMids2<12)])
		e8Hz33 = numpy.trapz(heights3[(binMids3>8) & (binMids3<12)],x=binMids3[(binMids3>8) & (binMids3<12)])
		e8Hz44 = numpy.trapz(heights4[(binMids4>8) & (binMids4<12)],x=binMids4[(binMids4>8) & (binMids4<12)])
		e8Hz55 = numpy.trapz(heights5[(binMids5>8) & (binMids5<12)],x=binMids5[(binMids5>8) & (binMids5<12)])
		e8Hz66 = numpy.trapz(heights6[(binMids6>8) & (binMids6<12)],x=binMids6[(binMids6>8) & (binMids6<12)])
		e8Hz77 = numpy.trapz(heights7[(binMids7>8) & (binMids7<12)],x=binMids7[(binMids7>8) & (binMids7<12)])
		e8Hz88 = numpy.trapz(heights8[(binMids8>8) & (binMids8<12)],x=binMids8[(binMids8>8) & (binMids8<12)])
		axarr[1].bar(ind+width, [e8Hz11, e8Hz22, e8Hz33, e8Hz44, e8Hz55, e8Hz66, e8Hz77, e8Hz88], width, color='k')
		axarr[1].set_xticks(ind+width)
		axarr[1].set_xticklabels(('Base','Theta','-CA3','-EC3','-OLM','-IS2/NGF','-BIS','-IS1'),fontsize=font_size-3, fontweight='bold', rotation=45)
		axarr[1].set_ylabel('Probability At 8-12Hz')
		axarr[1].set_xlim(0,8+width)
		axarr[1].spines['right'].set_visible(False)
		axarr[1].spines['top'].set_visible(False)
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_IFDistribution_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_IFDistribution_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
		
		# Polar Distribution Plots
		STX0 = HC_SpikeTimes_Baseline2/125
		STX1 = HC_SpikeTimes_Rhythm2/125
		STX2 = HC_SpikeTimes_CA3Removed2/125
		STX3 = HC_SpikeTimes_EC3Removed2/125
		STX4 = HC_SpikeTimes_OLMRemoved2/125
		STX5 = HC_SpikeTimes_IS2NGFRemoved2/125
		STX6 = HC_SpikeTimes_BISRemoved2/125
		STX7 = HC_SpikeTimes_IS1Removed2/125
		Rads_Baseline = 2*numpy.pi*(STX0-STX0.astype(int))
		Rads_1XRhythm = 2*numpy.pi*(STX1-STX1.astype(int))
		Rads_CA3Removed = 2*numpy.pi*(STX2-STX2.astype(int))
		Rads_EC3Removed = 2*numpy.pi*(STX3-STX3.astype(int))
		Rads_OLMRemoved = 2*numpy.pi*(STX4-STX4.astype(int))
		Rads_IS2NGFRemoved = 2*numpy.pi*(STX5-STX5.astype(int))
		Rads_BISRemoved = 2*numpy.pi*(STX6-STX6.astype(int))
		Rads_IS1Removed = 2*numpy.pi*(STX7-STX7.astype(int))
		
		bin_size = 25		
		range_if = (0,100)
		range_rads = (0,2*numpy.pi)
		
		heights11,be11 = numpy.histogram(Rads_Baseline,bins=bin_size,range=range_rads)
		bins11 = be11[:-1]+numpy.diff(be11)/2.
		PrefPhase_Baseline = bins11[heights11 == numpy.amax(heights11)]
		heights22,be22 = numpy.histogram(Rads_1XRhythm,bins=bin_size,range=range_rads)
		bins22 = be22[:-1]+numpy.diff(be22)/2.
		PrefPhase_ThetaX1 = bins22[heights22 == numpy.amax(heights22)]
		heights33,be33 = numpy.histogram(Rads_CA3Removed,bins=bin_size,range=range_rads)
		bins33 = be33[:-1]+numpy.diff(be33)/2.
		PrefPhase_CA3Removed = bins33[heights33 == numpy.amax(heights33)]
		heights44,be44 = numpy.histogram(Rads_EC3Removed,bins=bin_size,range=range_rads)
		bins44 = be44[:-1]+numpy.diff(be44)/2.
		PrefPhase_EC3Removed = bins44[heights44 == numpy.amax(heights44)]
		heights55,be55 = numpy.histogram(Rads_OLMRemoved,bins=bin_size,range=range_rads)
		bins55 = be55[:-1]+numpy.diff(be55)/2.
		PrefPhase_OLMRemoved = bins55[heights55 == numpy.amax(heights55)]
		heights66,be66 = numpy.histogram(Rads_IS2NGFRemoved,bins=bin_size,range=range_rads)
		bins66 = be66[:-1]+numpy.diff(be66)/2.
		PrefPhase_IS2NGFRemoved = bins66[heights66 == numpy.amax(heights66)]
		heights77,be77 = numpy.histogram(Rads_BISRemoved,bins=bin_size,range=range_rads)
		bins77 = be77[:-1]+numpy.diff(be77)/2.
		PrefPhase_BISRemoved = bins77[heights77 == numpy.amax(heights77)]
		heights88,be88 = numpy.histogram(Rads_IS1Removed,bins=bin_size,range=range_rads)
		bins88 = be88[:-1]+numpy.diff(be88)/2.
		PrefPhase_IS1Removed = bins88[heights88 == numpy.amax(heights88)]
		
		Rads_Baseline_Sorted = sorted(Rads_Baseline)
		Rads_1XRhythm_Sorted = sorted(Rads_1XRhythm)
		Rads_CA3Removed_Sorted = sorted(Rads_CA3Removed)
		Rads_EC3Removed_Sorted = sorted(Rads_EC3Removed)
		Rads_OLMRemoved_Sorted = sorted(Rads_OLMRemoved)
		Rads_IS2NGFRemoved_Sorted = sorted(Rads_IS2NGFRemoved)
		Rads_BISRemoved_Sorted = sorted(Rads_BISRemoved)
		Rads_IS1Removed_Sorted = sorted(Rads_IS1Removed)
		
		IF_Baseline_Sorted = [x for i, x in sorted(zip(Rads_Baseline,IF_Baseline))]
		IF_ThetaX1_Sorted = [x for i, x in sorted(zip(Rads_1XRhythm,IF_ThetaX1))]
		IF_CA3Removed_Sorted = [x for i, x in sorted(zip(Rads_CA3Removed,IF_CA3Removed))]
		IF_EC3Removed_Sorted = [x for i, x in sorted(zip(Rads_EC3Removed,IF_EC3Removed))]
		IF_OLMRemoved_Sorted = [x for i, x in sorted(zip(Rads_OLMRemoved,IF_OLMRemoved))]
		IF_IS2NGFRemoved_Sorted = [x for i, x in sorted(zip(Rads_IS2NGFRemoved,IF_IS2NGFRemoved))]
		IF_BISRemoved_Sorted = [x for i, x in sorted(zip(Rads_BISRemoved,IF_BISRemoved))]
		IF_IS1Removed_Sorted = [x for i, x in sorted(zip(Rads_IS1Removed,IF_IS1Removed))]
		
		Rads_Baseline_MeanBins,be11,bn11 = scipy.stats.binned_statistic(Rads_Baseline_Sorted,Rads_Baseline_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		_BMeans = Rads_Baseline_MeanBins
		Rads_Baseline_MeanBins = Rads_Baseline_MeanBins[~numpy.isnan(Rads_Baseline_MeanBins)]
		Rads_Baseline_MeanBins = numpy.append(Rads_Baseline_MeanBins,Rads_Baseline_MeanBins[0])
		Rads_1XRhythm_MeanBins,be21,bn21 = scipy.stats.binned_statistic(Rads_1XRhythm_Sorted,Rads_1XRhythm_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		_1Means = Rads_1XRhythm_MeanBins
		Rads_1XRhythm_MeanBins = Rads_1XRhythm_MeanBins[~numpy.isnan(Rads_1XRhythm_MeanBins)]
		Rads_1XRhythm_MeanBins = numpy.append(Rads_1XRhythm_MeanBins,Rads_1XRhythm_MeanBins[0])
		Rads_CA3Removed_MeanBins,be31,bn31 = scipy.stats.binned_statistic(Rads_CA3Removed_Sorted,Rads_CA3Removed_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		_2Means = Rads_CA3Removed_MeanBins
		Rads_CA3Removed_MeanBins = Rads_CA3Removed_MeanBins[~numpy.isnan(Rads_CA3Removed_MeanBins)]
		Rads_CA3Removed_MeanBins = numpy.append(Rads_CA3Removed_MeanBins,Rads_CA3Removed_MeanBins[0])
		Rads_EC3Removed_MeanBins,be41,bn41 = scipy.stats.binned_statistic(Rads_EC3Removed_Sorted,Rads_EC3Removed_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		_3Means = Rads_EC3Removed_MeanBins
		Rads_EC3Removed_MeanBins = Rads_EC3Removed_MeanBins[~numpy.isnan(Rads_EC3Removed_MeanBins)]
		Rads_EC3Removed_MeanBins = numpy.append(Rads_EC3Removed_MeanBins,Rads_EC3Removed_MeanBins[0])
		Rads_OLMRemoved_MeanBins,be51,bn51 = scipy.stats.binned_statistic(Rads_OLMRemoved_Sorted,Rads_OLMRemoved_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		_4Means = Rads_OLMRemoved_MeanBins
		Rads_OLMRemoved_MeanBins = Rads_OLMRemoved_MeanBins[~numpy.isnan(Rads_OLMRemoved_MeanBins)]
		Rads_OLMRemoved_MeanBins = numpy.append(Rads_OLMRemoved_MeanBins,Rads_OLMRemoved_MeanBins[0])
		Rads_IS2NGFRemoved_MeanBins,be61,bn61 = scipy.stats.binned_statistic(Rads_IS2NGFRemoved_Sorted,Rads_IS2NGFRemoved_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		_5Means = Rads_IS2NGFRemoved_MeanBins
		Rads_IS2NGFRemoved_MeanBins = Rads_IS2NGFRemoved_MeanBins[~numpy.isnan(Rads_IS2NGFRemoved_MeanBins)]
		Rads_IS2NGFRemoved_MeanBins = numpy.append(Rads_IS2NGFRemoved_MeanBins,Rads_IS2NGFRemoved_MeanBins[0])
		Rads_BISRemoved_MeanBins,be71,bn71 = scipy.stats.binned_statistic(Rads_BISRemoved_Sorted,Rads_BISRemoved_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		_6Means = Rads_BISRemoved_MeanBins
		Rads_BISRemoved_MeanBins = Rads_BISRemoved_MeanBins[~numpy.isnan(Rads_BISRemoved_MeanBins)]
		Rads_BISRemoved_MeanBins = numpy.append(Rads_BISRemoved_MeanBins,Rads_BISRemoved_MeanBins[0])
		Rads_IS1Removed_MeanBins,be81,bn81 = scipy.stats.binned_statistic(Rads_IS1Removed_Sorted,Rads_IS1Removed_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		_7Means = Rads_IS1Removed_MeanBins
		Rads_IS1Removed_MeanBins = Rads_IS1Removed_MeanBins[~numpy.isnan(Rads_IS1Removed_MeanBins)]
		Rads_IS1Removed_MeanBins = numpy.append(Rads_IS1Removed_MeanBins,Rads_IS1Removed_MeanBins[0])
		
		IF_Baseline_MeanBins,be12,bn12 = scipy.stats.binned_statistic(Rads_Baseline_Sorted,IF_Baseline_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		IF_Baseline_MeanBins = IF_Baseline_MeanBins[~numpy.isnan(_BMeans)]
		IF_Baseline_MeanBins = numpy.append(IF_Baseline_MeanBins,IF_Baseline_MeanBins[0])
		IF_1XRhythm_MeanBins,be22,bn22 = scipy.stats.binned_statistic(Rads_1XRhythm_Sorted,IF_ThetaX1_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		IF_1XRhythm_MeanBins = IF_1XRhythm_MeanBins[~numpy.isnan(_1Means)]
		IF_1XRhythm_MeanBins = numpy.append(IF_1XRhythm_MeanBins,IF_1XRhythm_MeanBins[0])
		IF_CA3Removed_MeanBins,be32,bn32 = scipy.stats.binned_statistic(Rads_CA3Removed_Sorted,IF_CA3Removed_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		IF_CA3Removed_MeanBins = IF_CA3Removed_MeanBins[~numpy.isnan(_2Means)]
		IF_CA3Removed_MeanBins = numpy.append(IF_CA3Removed_MeanBins,IF_CA3Removed_MeanBins[0])
		IF_EC3Removed_MeanBins,be42,bn42 = scipy.stats.binned_statistic(Rads_EC3Removed_Sorted,IF_EC3Removed_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		IF_EC3Removed_MeanBins = IF_EC3Removed_MeanBins[~numpy.isnan(_3Means)]
		IF_EC3Removed_MeanBins = numpy.append(IF_EC3Removed_MeanBins,IF_EC3Removed_MeanBins[0])
		IF_OLMRemoved_MeanBins,be52,bn52 = scipy.stats.binned_statistic(Rads_OLMRemoved_Sorted,IF_OLMRemoved_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		IF_OLMRemoved_MeanBins = IF_OLMRemoved_MeanBins[~numpy.isnan(_4Means)]
		IF_OLMRemoved_MeanBins = numpy.append(IF_OLMRemoved_MeanBins,IF_OLMRemoved_MeanBins[0])
		IF_IS2NGFRemoved_MeanBins,be62,bn62 = scipy.stats.binned_statistic(Rads_IS2NGFRemoved_Sorted,IF_IS2NGFRemoved_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		IF_IS2NGFRemoved_MeanBins = IF_IS2NGFRemoved_MeanBins[~numpy.isnan(_5Means)]
		IF_IS2NGFRemoved_MeanBins = numpy.append(IF_IS2NGFRemoved_MeanBins,IF_IS2NGFRemoved_MeanBins[0])
		IF_BISRemoved_MeanBins,be72,bn72 = scipy.stats.binned_statistic(Rads_BISRemoved_Sorted,IF_BISRemoved_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		IF_BISRemoved_MeanBins = IF_BISRemoved_MeanBins[~numpy.isnan(_6Means)]
		IF_BISRemoved_MeanBins = numpy.append(IF_BISRemoved_MeanBins,IF_BISRemoved_MeanBins[0])
		IF_IS1Removed_MeanBins,be82,bn82 = scipy.stats.binned_statistic(Rads_IS1Removed_Sorted,IF_IS1Removed_Sorted,statistic='mean',bins=bin_size,range=range_rads)
		IF_IS1Removed_MeanBins = IF_IS1Removed_MeanBins[~numpy.isnan(_7Means)]
		IF_IS1Removed_MeanBins = numpy.append(IF_IS1Removed_MeanBins,IF_IS1Removed_MeanBins[0])
		
		IF_Baseline_MinsBins,be111,bn111 = scipy.stats.binned_statistic(Rads_Baseline_Sorted,IF_Baseline_Sorted,statistic='min',bins=bin_size,range=range_rads)
		IF_Baseline_MinsBins = IF_Baseline_MinsBins[~numpy.isnan(_BMeans)]
		IF_Baseline_MinsBins = numpy.append(IF_Baseline_MinsBins,IF_Baseline_MinsBins[0])
		IF_1XRhythm_MinsBins,be211,bn211 = scipy.stats.binned_statistic(Rads_1XRhythm_Sorted,IF_ThetaX1_Sorted,statistic='min',bins=bin_size,range=range_rads)
		IF_1XRhythm_MinsBins = IF_1XRhythm_MinsBins[~numpy.isnan(_1Means)]
		IF_1XRhythm_MinsBins = numpy.append(IF_1XRhythm_MinsBins,IF_1XRhythm_MinsBins[0])
		IF_CA3Removed_MinsBins,be32,bn32 = scipy.stats.binned_statistic(Rads_CA3Removed_Sorted,IF_CA3Removed_Sorted,statistic='min',bins=bin_size,range=range_rads)
		IF_CA3Removed_MinsBins = IF_CA3Removed_MinsBins[~numpy.isnan(_2Means)]
		IF_CA3Removed_MinsBins = numpy.append(IF_CA3Removed_MinsBins,IF_CA3Removed_MinsBins[0])
		IF_EC3Removed_MinsBins,be42,bn42 = scipy.stats.binned_statistic(Rads_EC3Removed_Sorted,IF_EC3Removed_Sorted,statistic='min',bins=bin_size,range=range_rads)
		IF_EC3Removed_MinsBins = IF_EC3Removed_MinsBins[~numpy.isnan(_3Means)]
		IF_EC3Removed_MinsBins = numpy.append(IF_EC3Removed_MinsBins,IF_EC3Removed_MinsBins[0])
		IF_OLMRemoved_MinsBins,be52,bn52 = scipy.stats.binned_statistic(Rads_OLMRemoved_Sorted,IF_OLMRemoved_Sorted,statistic='min',bins=bin_size,range=range_rads)
		IF_OLMRemoved_MinsBins = IF_OLMRemoved_MinsBins[~numpy.isnan(_4Means)]
		IF_OLMRemoved_MinsBins = numpy.append(IF_OLMRemoved_MinsBins,IF_OLMRemoved_MinsBins[0])
		IF_IS2NGFRemoved_MinsBins,be62,bn62 = scipy.stats.binned_statistic(Rads_IS2NGFRemoved_Sorted,IF_IS2NGFRemoved_Sorted,statistic='min',bins=bin_size,range=range_rads)
		IF_IS2NGFRemoved_MinsBins = IF_IS2NGFRemoved_MinsBins[~numpy.isnan(_5Means)]
		IF_IS2NGFRemoved_MinsBins = numpy.append(IF_IS2NGFRemoved_MinsBins,IF_IS2NGFRemoved_MinsBins[0])
		IF_BISRemoved_MinsBins,be72,bn72 = scipy.stats.binned_statistic(Rads_BISRemoved_Sorted,IF_BISRemoved_Sorted,statistic='min',bins=bin_size,range=range_rads)
		IF_BISRemoved_MinsBins = IF_BISRemoved_MinsBins[~numpy.isnan(_6Means)]
		IF_BISRemoved_MinsBins = numpy.append(IF_BISRemoved_MinsBins,IF_BISRemoved_MinsBins[0])
		IF_IS1Removed_MinsBins,be82,bn82 = scipy.stats.binned_statistic(Rads_IS1Removed_Sorted,IF_IS1Removed_Sorted,statistic='min',bins=bin_size,range=range_rads)
		IF_IS1Removed_MinsBins = IF_IS1Removed_MinsBins[~numpy.isnan(_7Means)]
		IF_IS1Removed_MinsBins = numpy.append(IF_IS1Removed_MinsBins,IF_IS1Removed_MinsBins[0])
		
		IF_Baseline_MaxBins,be111,bn111 = scipy.stats.binned_statistic(Rads_Baseline_Sorted,IF_Baseline_Sorted,statistic='max',bins=bin_size,range=range_rads)
		IF_Baseline_MaxBins = IF_Baseline_MaxBins[~numpy.isnan(_BMeans)]
		IF_Baseline_MaxBins = numpy.append(IF_Baseline_MaxBins,IF_Baseline_MaxBins[0])
		IF_1XRhythm_MaxBins,be211,bn211 = scipy.stats.binned_statistic(Rads_1XRhythm_Sorted,IF_ThetaX1_Sorted,statistic='max',bins=bin_size,range=range_rads)
		IF_1XRhythm_MaxBins = IF_1XRhythm_MaxBins[~numpy.isnan(_1Means)]
		IF_1XRhythm_MaxBins = numpy.append(IF_1XRhythm_MaxBins,IF_1XRhythm_MaxBins[0])
		IF_CA3Removed_MaxBins,be32,bn32 = scipy.stats.binned_statistic(Rads_CA3Removed_Sorted,IF_CA3Removed_Sorted,statistic='max',bins=bin_size,range=range_rads)
		IF_CA3Removed_MaxBins = IF_CA3Removed_MaxBins[~numpy.isnan(_2Means)]
		IF_CA3Removed_MaxBins = numpy.append(IF_CA3Removed_MaxBins,IF_CA3Removed_MaxBins[0])
		IF_EC3Removed_MaxBins,be42,bn42 = scipy.stats.binned_statistic(Rads_EC3Removed_Sorted,IF_EC3Removed_Sorted,statistic='max',bins=bin_size,range=range_rads)
		IF_EC3Removed_MaxBins = IF_EC3Removed_MaxBins[~numpy.isnan(_3Means)]
		IF_EC3Removed_MaxBins = numpy.append(IF_EC3Removed_MaxBins,IF_EC3Removed_MaxBins[0])
		IF_OLMRemoved_MaxBins,be52,bn52 = scipy.stats.binned_statistic(Rads_OLMRemoved_Sorted,IF_OLMRemoved_Sorted,statistic='max',bins=bin_size,range=range_rads)
		IF_OLMRemoved_MaxBins = IF_OLMRemoved_MaxBins[~numpy.isnan(_4Means)]
		IF_OLMRemoved_MaxBins = numpy.append(IF_OLMRemoved_MaxBins,IF_OLMRemoved_MaxBins[0])
		IF_IS2NGFRemoved_MaxBins,be62,bn62 = scipy.stats.binned_statistic(Rads_IS2NGFRemoved_Sorted,IF_IS2NGFRemoved_Sorted,statistic='max',bins=bin_size,range=range_rads)
		IF_IS2NGFRemoved_MaxBins = IF_IS2NGFRemoved_MaxBins[~numpy.isnan(_5Means)]
		IF_IS2NGFRemoved_MaxBins = numpy.append(IF_IS2NGFRemoved_MaxBins,IF_IS2NGFRemoved_MaxBins[0])
		IF_BISRemoved_MaxBins,be72,bn72 = scipy.stats.binned_statistic(Rads_BISRemoved_Sorted,IF_BISRemoved_Sorted,statistic='max',bins=bin_size,range=range_rads)
		IF_BISRemoved_MaxBins = IF_BISRemoved_MaxBins[~numpy.isnan(_6Means)]
		IF_BISRemoved_MaxBins = numpy.append(IF_BISRemoved_MaxBins,IF_BISRemoved_MaxBins[0])
		IF_IS1Removed_MaxBins,be82,bn82 = scipy.stats.binned_statistic(Rads_IS1Removed_Sorted,IF_IS1Removed_Sorted,statistic='max',bins=bin_size,range=range_rads)
		IF_IS1Removed_MaxBins = IF_IS1Removed_MaxBins[~numpy.isnan(_7Means)]
		IF_IS1Removed_MaxBins = numpy.append(IF_IS1Removed_MaxBins,IF_IS1Removed_MaxBins[0])
		
		IF_Baseline_StdBins,be111,bn111 = scipy.stats.binned_statistic(Rads_Baseline_Sorted,IF_Baseline_Sorted,statistic='std',bins=bin_size,range=range_rads)
		IF_Baseline_StdBins = IF_Baseline_StdBins[~numpy.isnan(_BMeans)]
		IF_Baseline_StdBins = numpy.append(IF_Baseline_StdBins,IF_Baseline_StdBins[0])
		IF_1XRhythm_StdBins,be211,bn211 = scipy.stats.binned_statistic(Rads_1XRhythm_Sorted,IF_ThetaX1_Sorted,statistic='std',bins=bin_size,range=range_rads)
		IF_1XRhythm_StdBins = IF_1XRhythm_StdBins[~numpy.isnan(_1Means)]
		IF_1XRhythm_StdBins = numpy.append(IF_1XRhythm_StdBins,IF_1XRhythm_StdBins[0])
		IF_CA3Removed_StdBins,be32,bn32 = scipy.stats.binned_statistic(Rads_CA3Removed_Sorted,IF_CA3Removed_Sorted,statistic='std',bins=bin_size,range=range_rads)
		IF_CA3Removed_StdBins = IF_CA3Removed_StdBins[~numpy.isnan(_2Means)]
		IF_CA3Removed_StdBins = numpy.append(IF_CA3Removed_StdBins,IF_CA3Removed_StdBins[0])
		IF_EC3Removed_StdBins,be42,bn42 = scipy.stats.binned_statistic(Rads_EC3Removed_Sorted,IF_EC3Removed_Sorted,statistic='std',bins=bin_size,range=range_rads)
		IF_EC3Removed_StdBins = IF_EC3Removed_StdBins[~numpy.isnan(_3Means)]
		IF_EC3Removed_StdBins = numpy.append(IF_EC3Removed_StdBins,IF_EC3Removed_StdBins[0])
		IF_OLMRemoved_StdBins,be52,bn52 = scipy.stats.binned_statistic(Rads_OLMRemoved_Sorted,IF_OLMRemoved_Sorted,statistic='std',bins=bin_size,range=range_rads)
		IF_OLMRemoved_StdBins = IF_OLMRemoved_StdBins[~numpy.isnan(_4Means)]
		IF_OLMRemoved_StdBins = numpy.append(IF_OLMRemoved_StdBins,IF_OLMRemoved_StdBins[0])
		IF_IS2NGFRemoved_StdBins,be62,bn62 = scipy.stats.binned_statistic(Rads_IS2NGFRemoved_Sorted,IF_IS2NGFRemoved_Sorted,statistic='std',bins=bin_size,range=range_rads)
		IF_IS2NGFRemoved_StdBins = IF_IS2NGFRemoved_StdBins[~numpy.isnan(_5Means)]
		IF_IS2NGFRemoved_StdBins = numpy.append(IF_IS2NGFRemoved_StdBins,IF_IS2NGFRemoved_StdBins[0])
		IF_BISRemoved_StdBins,be72,bn72 = scipy.stats.binned_statistic(Rads_BISRemoved_Sorted,IF_BISRemoved_Sorted,statistic='std',bins=bin_size,range=range_rads)
		IF_BISRemoved_StdBins = IF_BISRemoved_StdBins[~numpy.isnan(_6Means)]
		IF_BISRemoved_StdBins = numpy.append(IF_BISRemoved_StdBins,IF_BISRemoved_StdBins[0])
		IF_IS1Removed_StdBins,be82,bn82 = scipy.stats.binned_statistic(Rads_IS1Removed_Sorted,IF_IS1Removed_Sorted,statistic='std',bins=bin_size,range=range_rads)
		IF_IS1Removed_StdBins = IF_IS1Removed_StdBins[~numpy.isnan(_7Means)]
		IF_IS1Removed_StdBins = numpy.append(IF_IS1Removed_StdBins,IF_IS1Removed_StdBins[0])
		
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_Baseline_Sorted,IF_Baseline_Sorted,'b',label='Base')
		axarr.plot(Rads_1XRhythm_Sorted,IF_ThetaX1_Sorted,'r',label='Theta')
		axarr.plot(Rads_CA3Removed_Sorted,IF_CA3Removed_Sorted,'g',label='-CA3')
		axarr.plot(Rads_EC3Removed_Sorted,IF_EC3Removed_Sorted,'c',label='-EC3')
		axarr.plot(Rads_OLMRemoved_Sorted,IF_OLMRemoved_Sorted,'m',label='-OLM')
		axarr.plot(Rads_IS2NGFRemoved_Sorted,IF_IS2NGFRemoved_Sorted,'y',label='-IS2/NGF')
		axarr.plot(Rads_BISRemoved_Sorted,IF_BISRemoved_Sorted,'k',label='-BIS')
		axarr.plot(Rads_IS1Removed_Sorted,IF_IS1Removed_Sorted,color='orange',label='-IS1')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlot_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlot_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
		
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_Baseline_MeanBins,IF_Baseline_MeanBins,'b',label='Base')
		axarr.fill_between(Rads_Baseline_MeanBins,numpy.clip(IF_Baseline_MeanBins-IF_Baseline_StdBins,0,1000),numpy.clip(IF_Baseline_MeanBins+IF_Baseline_StdBins,0,1000),alpha=0.5, edgecolor='b', facecolor='b')
		axarr.plot(Rads_1XRhythm_MeanBins,IF_1XRhythm_MeanBins,'r',label='Theta')
		axarr.fill_between(Rads_1XRhythm_MeanBins,numpy.clip(IF_1XRhythm_MeanBins-IF_1XRhythm_StdBins,0,1000),numpy.clip(IF_1XRhythm_MeanBins+IF_1XRhythm_StdBins,0,1000),alpha=0.5, edgecolor='r', facecolor='r')
		axarr.plot(Rads_CA3Removed_MeanBins,IF_CA3Removed_MeanBins,'g',label='-CA3')
		axarr.fill_between(Rads_CA3Removed_MeanBins,numpy.clip(IF_CA3Removed_MeanBins-IF_CA3Removed_StdBins,0,1000),numpy.clip(IF_CA3Removed_MeanBins+IF_CA3Removed_StdBins,0,1000),alpha=0.5, edgecolor='g', facecolor='g')
		axarr.plot(Rads_EC3Removed_MeanBins,IF_EC3Removed_MeanBins,'c',label='-EC3')
		axarr.fill_between(Rads_EC3Removed_MeanBins,numpy.clip(IF_EC3Removed_MeanBins-IF_EC3Removed_StdBins,0,1000),numpy.clip(IF_EC3Removed_MeanBins+IF_EC3Removed_StdBins,0,1000),alpha=0.5, edgecolor='c', facecolor='c')
		axarr.plot(Rads_OLMRemoved_MeanBins,IF_OLMRemoved_MeanBins,'m',label='-OLM')
		axarr.fill_between(Rads_OLMRemoved_MeanBins,numpy.clip(IF_OLMRemoved_MeanBins-IF_OLMRemoved_StdBins,0,1000),numpy.clip(IF_OLMRemoved_MeanBins+IF_OLMRemoved_StdBins,0,1000),alpha=0.5, edgecolor='m', facecolor='m')
		axarr.plot(Rads_IS2NGFRemoved_MeanBins,IF_IS2NGFRemoved_MeanBins,'y',label='-IS2/NGF')
		axarr.fill_between(Rads_IS2NGFRemoved_MeanBins,numpy.clip(IF_IS2NGFRemoved_MeanBins-IF_IS2NGFRemoved_StdBins,0,1000),numpy.clip(IF_IS2NGFRemoved_MeanBins+IF_IS2NGFRemoved_StdBins,0,1000),alpha=0.5, edgecolor='y', facecolor='y')
		axarr.plot(Rads_BISRemoved_MeanBins,IF_BISRemoved_MeanBins,'k',label='-BIS')
		axarr.fill_between(Rads_BISRemoved_MeanBins,numpy.clip(IF_BISRemoved_MeanBins-IF_BISRemoved_StdBins,0,1000),numpy.clip(IF_BISRemoved_MeanBins+IF_BISRemoved_StdBins,0,1000),alpha=0.5, edgecolor='k', facecolor='k')
		axarr.plot(Rads_IS1Removed_MeanBins,IF_IS1Removed_MeanBins,color='orange',label='-IS1')
		axarr.fill_between(Rads_IS1Removed_MeanBins,numpy.clip(IF_IS1Removed_MeanBins-IF_IS1Removed_StdBins,0,1000),numpy.clip(IF_IS1Removed_MeanBins+IF_IS1Removed_StdBins,0,1000),alpha=0.5, edgecolor='orange', facecolor='orange')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinned_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinned_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
		
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_Baseline_MeanBins,IF_Baseline_MeanBins,'b',label='Base')
		axarr.fill_between(Rads_Baseline_MeanBins,numpy.clip(IF_Baseline_MeanBins-IF_Baseline_StdBins,0,1000),numpy.clip(IF_Baseline_MeanBins+IF_Baseline_StdBins,0,1000),alpha=0.5, edgecolor='b', facecolor='b')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		bottom = numpy.amax(numpy.clip(IF_Baseline_MeanBins+IF_Baseline_StdBins,0,1000))+5
		width = range_rads[1]/(bin_size+1)
		axarr.bar(_BMeans, heights11, width=width, bottom=bottom,color='b')
		# for ph in range(0,len(PrefPhase_Baseline)):
		#     axarr.annotate(' ', xy=(PrefPhase_Baseline[ph], numpy.amax(numpy.clip(IF_Baseline_MeanBins+IF_Baseline_StdBins,0,1000))), xytext=(0, 0),arrowprops=dict(facecolor='black', shrink=0.05),)
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedBaseline_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedBaseline_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
		
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_1XRhythm_MeanBins,IF_1XRhythm_MeanBins,'r',label='Theta')
		axarr.fill_between(Rads_1XRhythm_MeanBins,numpy.clip(IF_1XRhythm_MeanBins-IF_1XRhythm_StdBins,0,1000),numpy.clip(IF_1XRhythm_MeanBins+IF_1XRhythm_StdBins,0,1000),alpha=0.5, edgecolor='r', facecolor='r')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		bottom = numpy.amax(numpy.clip(IF_1XRhythm_MeanBins+IF_1XRhythm_StdBins,0,1000))+5
		width = range_rads[1]/(bin_size+1)
		axarr.bar(_1Means, heights22, width=width, bottom=bottom,color='r')
		# for ph in range(0,len(PrefPhase_ThetaX1)):
		#     axarr.annotate(' ', xy=(PrefPhase_ThetaX1[ph], numpy.amax(numpy.clip(IF_1XRhythm_MeanBins+IF_1XRhythm_StdBins,0,1000))), xytext=(0, 0),arrowprops=dict(facecolor='black', shrink=0.05),)
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinned1XTheta_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinned1XTheta_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
	
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_CA3Removed_MeanBins,IF_CA3Removed_MeanBins,'g',label='-CA3')
		axarr.fill_between(Rads_CA3Removed_MeanBins,numpy.clip(IF_CA3Removed_MeanBins-IF_CA3Removed_StdBins,0,1000),numpy.clip(IF_CA3Removed_MeanBins+IF_CA3Removed_StdBins,0,1000),alpha=0.5, edgecolor='g', facecolor='g')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		bottom = numpy.amax(numpy.clip(IF_CA3Removed_MeanBins+IF_CA3Removed_StdBins,0,1000))+5
		width = range_rads[1]/(bin_size+1)
		axarr.bar(_2Means, heights33, width=width, bottom=bottom,color='g')
		# for ph in range(0,len(PrefPhase_CA3Removed)):
		#     axarr.annotate(' ', xy=(PrefPhase_CA3Removed[ph], numpy.amax(numpy.clip(IF_CA3Removed_MeanBins+IF_CA3Removed_StdBins,0,1000))), xytext=(0, 0),arrowprops=dict(facecolor='black', shrink=0.05),)
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedCA3Removed_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedCA3Removed_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
	
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_EC3Removed_MeanBins,IF_EC3Removed_MeanBins,'c',label='-EC3')
		axarr.fill_between(Rads_EC3Removed_MeanBins,numpy.clip(IF_EC3Removed_MeanBins-IF_EC3Removed_StdBins,0,1000),numpy.clip(IF_EC3Removed_MeanBins+IF_EC3Removed_StdBins,0,1000),alpha=0.5, edgecolor='c', facecolor='c')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		bottom = numpy.amax(numpy.clip(IF_EC3Removed_MeanBins+IF_EC3Removed_StdBins,0,1000))+5
		width = range_rads[1]/(bin_size+1)
		axarr.bar(_3Means, heights44, width=width, bottom=bottom,color='c')
		# for ph in range(0,len(PrefPhase_EC3Removed)):
		#     axarr.annotate(' ', xy=(PrefPhase_EC3Removed[ph], numpy.amax(numpy.clip(IF_EC3Removed_MeanBins+IF_EC3Removed_StdBins,0,1000))), xytext=(0, 0),arrowprops=dict(facecolor='black', shrink=0.05),)
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedEC3Removed_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedEC3Removed_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
	
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_OLMRemoved_MeanBins,IF_OLMRemoved_MeanBins,'m',label='-OLM')
		axarr.fill_between(Rads_OLMRemoved_MeanBins,numpy.clip(IF_OLMRemoved_MeanBins-IF_OLMRemoved_StdBins,0,1000),numpy.clip(IF_OLMRemoved_MeanBins+IF_OLMRemoved_StdBins,0,1000),alpha=0.5, edgecolor='m', facecolor='m')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		bottom = numpy.amax(numpy.clip(IF_OLMRemoved_MeanBins+IF_OLMRemoved_StdBins,0,1000))+5
		width = range_rads[1]/(bin_size+1)
		axarr.bar(_4Means, heights55, width=width, bottom=bottom,color='m')
		# for ph in range(0,len(PrefPhase_OLMRemoved)):
		#     axarr.annotate(' ', xy=(PrefPhase_OLMRemoved[ph], numpy.amax(numpy.clip(IF_OLMRemoved_MeanBins+IF_OLMRemoved_StdBins,0,1000))), xytext=(0, 0),arrowprops=dict(facecolor='black', shrink=0.05),)
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedOLMRemoved_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedOLMRemoved_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
	
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_IS2NGFRemoved_MeanBins,IF_IS2NGFRemoved_MeanBins,'y',label='-IS2/NGF')
		axarr.fill_between(Rads_IS2NGFRemoved_MeanBins,numpy.clip(IF_IS2NGFRemoved_MeanBins-IF_IS2NGFRemoved_StdBins,0,1000),numpy.clip(IF_IS2NGFRemoved_MeanBins+IF_IS2NGFRemoved_StdBins,0,1000),alpha=0.5, edgecolor='y', facecolor='y')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		bottom = numpy.amax(numpy.clip(IF_IS2NGFRemoved_MeanBins+IF_IS2NGFRemoved_StdBins,0,1000))+5
		width = range_rads[1]/(bin_size+1)
		axarr.bar(_5Means, heights66, width=width, bottom=bottom,color='y')
		# for ph in range(0,len(PrefPhase_IS2NGFRemoved)):
		#     axarr.annotate(' ', xy=(PrefPhase_IS2NGFRemoved[ph], numpy.amax(numpy.clip(IF_IS2NGFRemoved_MeanBins+IF_IS2NGFRemoved_StdBins,0,1000))), xytext=(0, 0),arrowprops=dict(facecolor='black', shrink=0.05),)
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedIS2NGFRemoved_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedIS2NGFRemoved_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
	
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_BISRemoved_MeanBins,IF_BISRemoved_MeanBins,'k',label='-BIS')
		axarr.fill_between(Rads_BISRemoved_MeanBins,numpy.clip(IF_BISRemoved_MeanBins-IF_BISRemoved_StdBins,0,1000),numpy.clip(IF_BISRemoved_MeanBins+IF_BISRemoved_StdBins,0,1000),alpha=0.5, edgecolor='k', facecolor='k')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		bottom = numpy.amax(numpy.clip(IF_BISRemoved_MeanBins+IF_BISRemoved_StdBins,0,1000))+5
		width = range_rads[1]/(bin_size+1)
		axarr.bar(_6Means, heights77, width=width, bottom=bottom,color='k')
		# for ph in range(0,len(PrefPhase_BISRemoved)):
		#     axarr.annotate(' ', xy=(PrefPhase_BISRemoved[ph], numpy.amax(numpy.clip(IF_BISRemoved_MeanBins+IF_BISRemoved_StdBins,0,1000))), xytext=(0, 0),arrowprops=dict(facecolor='black', shrink=0.05),)
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedBISRemoved_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedBISRemoved_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
	
		axarr = pyplot.subplot(111, projection='polar')
		axarr.plot(Rads_IS1Removed_MeanBins,IF_IS1Removed_MeanBins,color='orange',label='-IS1')
		axarr.fill_between(Rads_IS1Removed_MeanBins,numpy.clip(IF_IS1Removed_MeanBins-IF_IS1Removed_StdBins,0,1000),numpy.clip(IF_IS1Removed_MeanBins+IF_IS1Removed_StdBins,0,1000),alpha=0.5, edgecolor='orange', facecolor='orange')
		position = 292.5
		axarr._r_label_position._t = (position, 0)
		axarr._r_label_position.invalidate()
		bottom = numpy.amax(numpy.clip(IF_IS1Removed_MeanBins+IF_IS1Removed_StdBins,0,1000))+5
		width = range_rads[1]/(bin_size+1)
		axarr.bar(_7Means, heights88, width=width, bottom=bottom,color='orange')
		# for ph in range(0,len(PrefPhase_IS1Removed)):
		#     axarr.annotate(' ', xy=(PrefPhase_IS1Removed[ph], numpy.amax(numpy.clip(IF_IS1Removed_MeanBins+IF_IS1Removed_StdBins,0,1000))), xytext=(0, 0),arrowprops=dict(facecolor='black', shrink=0.05),)
		axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
		pyplot.tight_layout()
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedIS1Removed_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.pdf', bbox_inches='tight')
		pyplot.savefig('PLOTfiles/' + Case + '_PolarPlotBinnedIS1Removed_' + ExampleString + '_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.png', bbox_inches='tight')
		pyplot.gcf().clear()
		pyplot.cla()
		pyplot.clf()
		pyplot.close()
	
	numpy.save('NPYfiles/' + Case + '_Areas_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',numpy.array([Area1,Area2,Area3,Area4,Area5,Area6,Area7,Area8],dtype=numpy.float))
	numpy.save('NPYfiles/' + Case + '_e8Hz_' + str('%0.2f' %h.prethetanoise) + '_prethetanoise.npy',numpy.array([e8Hz1,e8Hz2,e8Hz3,e8Hz4,e8Hz5,e8Hz6,e8Hz7,e8Hz8],dtype=numpy.float))

# LNI_LNE_LIS_LES
# HNI_LNE_LIS_LES
# LNI_HNE_LIS_LES
# HNI_HNE_LIS_LES
# LNI_LNE_HIS_LES
# HNI_LNE_HIS_LES
# LNI_HNE_HIS_LES
# HNI_HNE_HIS_LES
# LNI_LNE_LIS_HES
# HNI_LNE_LIS_HES
# LNI_HNE_LIS_HES
# HNI_HNE_LIS_HES
# LNI_LNE_HIS_HES
# HNI_LNE_HIS_HES
# LNI_HNE_HIS_HES
# HNI_HNE_HIS_HES
