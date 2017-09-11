### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
from scipy import signal

Case = 'SDprox1_E_COM_I_COM'

# HC Treshold Measurement Values
tstop = 10 # seconds
font_size = 13

Examples = numpy.load('NPYfiles/' + Case + '_ExampleHCModelParams.npy')
ExampleStrings = numpy.load('NPYfiles/' + Case + '_ExampleHCModelStrings.npy')

tstop = h.tstop/1000
dt = h.dt
Areas1 = numpy.zeros((len(Examples[0]),),dtype=numpy.float)
Areas2 = numpy.zeros((len(Examples[0]),),dtype=numpy.float)
e8Hz1 = numpy.zeros((len(Examples[0]),),dtype=numpy.float)
e8Hz2 = numpy.zeros((len(Examples[0]),),dtype=numpy.float)
for x in range(0,len(Examples[0])):
	if Examples[0][x] == 0:
		print str(ExampleStrings[x]) + ' is empty'
		continue
	for y in range(0,2):
		ExampleString = ExampleStrings[x]
		
		# Run Simulation of Example
		h.randomize_syns(5,2) # i.e. same random seeds when comparing runs
		h.f(Examples[0][x],Examples[1][x],Examples[2][x],Examples[3][x],1,10,15,y) # i.e. same random seeds when comparing runs
		
		HC_Trace = numpy.fromfile("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('model_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon_',str(y),'_AddRhythmTrue.dat'),dtype=float)
		voltvec = HC_Trace[1:len(HC_Trace)]
		
		if y == 0:
			HC_Trace_Baseline = HC_Trace[10000:100001]
			HC_SpikeTimes_Baseline = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
			for i in range(0,len(h.apctimes)): HC_SpikeTimes_Baseline[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
			HC_SpikeTimes_Baseline = HC_SpikeTimes_Baseline[10000:100001]
		elif y == 1:
			HC_Trace_Rhythm = HC_Trace[10000:100001]
			HC_SpikeTimes_Rhythm = numpy.zeros((len(HC_Trace),), dtype=numpy.float)
			for i in range(0,len(h.apctimes)): HC_SpikeTimes_Rhythm[int(h.apctimes.x[i]/dt)] = h.apctimes.x[i]
			HC_SpikeTimes_Rhythm = HC_SpikeTimes_Rhythm[10000:100001]
		
		timevec = numpy.arange(0,10000.1,0.1)
		if y == 0:
			f, axarr = matplotlib.pyplot.subplots(3, sharex=True)
			axarr[0].plot(timevec,voltvec,'b')
			axarr[0].set_title("%s%s%s%s%s%s%s%s%s" % ('InhSyns: ',str(Examples[0][x]),', ExcSyns: ',str(Examples[1][x]),',\nInhSpikes: ',str(Examples[2][x]/tstop),'Hz, ExcSpikes: ',str(Examples[3][x]/tstop),'Hz'))
			axarr[0].set_ylim(-90,30)
			axarr[0].set_ylabel('Voltage (mV)',fontsize=font_size)
		if y == 1:
			axarr[1].plot(timevec,voltvec,'r')
			axarr[1].set_title('Theta Input',fontsize=font_size)
			axarr[1].set_ylim(-90,30)
			axarr[1].set_ylabel('Voltage (mV)',fontsize=font_size)
				
		if y == 1:
			HC_InhSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('InhPreSpikeTrains_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon_',str(y),'_AddRhythmTrue.dat'),'r')
			inhinputmat = []
			inhinputmat = [ line.split() for line in HC_InhSpikeTrains] # inhinputmat[NumSyn][NumSpikes]
			
			HC_ExcSRSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('SRExcPreSpikeTrains_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon_',str(y),'_AddRhythmTrue.dat'),'r')
			excSRinputmat = []
			excSRinputmat = [ line.split() for line in HC_ExcSRSpikeTrains] # excSRinputmat[NumSyn][NumSpikes]
			
			HC_ExcSLMSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('SLMExcPreSpikeTrains_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon_',str(y),'_AddRhythmTrue.dat'),'r')
			excSLMinputmat = []
			excSLMinputmat = [ line.split() for line in HC_ExcSLMSpikeTrains] # excSLMinputmat[NumSyn][NumSpikes]
				
			HC_ThetaSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('ThetaSpikeTrains_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon_',str(y),'_AddRhythmTrue.dat'),'r')
			Thetainputmat = []
			Thetainputmat = [ line.split() for line in HC_ThetaSpikeTrains] # excSLMinputmat[NumSyn][NumSpikes]
			
			for i in range(1,len(inhinputmat)):
				axarr[2].vlines(inhinputmat[i][:],i-0.25,i+0.25,'r')
			
			for j in range(1,len(excSRinputmat)):
				axarr[2].vlines(excSRinputmat[j][:],i+j-0.25,i+j+0.25,'b')
			
			for k in range(1,len(excSLMinputmat)):
				axarr[2].vlines(excSLMinputmat[k][:],i+j+k-0.25,i+j+k+0.25,'g')
			
			for l in range(23,27):
				axarr[2].vlines(Thetainputmat[l][:],i+j+k+(l-22)-0.25,i+j+k+(l-22)+0.25,'c') #SR inhibitory theta
			
			for m in range(19,23):
				axarr[2].vlines(Thetainputmat[m][:],i+j+k+(l-22)+(m-18)-0.25,i+j+k+(l-22)+(m-18)+0.25,'m') #SLM inhibitory theta
			
			for n in range(10,19):
				axarr[2].vlines(Thetainputmat[n][:],i+j+k+(l-22)+(m-18)+(n-9)-0.25,i+j+k+(l-22)+(m-18)+(n-9)+0.25,'b') #SR excitatory theta
			
			for o in range(1,10):
				axarr[2].vlines(Thetainputmat[o][:],i+j+k+(l-22)+(m-18)+(n-9)+o-0.25,i+j+k+(l-22)+(m-18)+(n-9)+o+0.25,'g') #SLM excitatory theta
			
			axarr[2].set_ylim(0,i+j+k+(l-22)+(m-18)+(n-9)+o+1)
			axarr[2].set_xlabel('Time (ms)',fontsize=font_size)
			axarr[2].set_ylabel('Synapse Index',fontsize=font_size)
			
			pyplot.savefig('PLOTfiles/' + Case + '_Trace_' + ExampleString + '.pdf', bbox_inches='tight')
			pyplot.savefig('PLOTfiles/' + Case + '_Trace_' + ExampleString + '.png', bbox_inches='tight')
			pyplot.gcf().clear()
			pyplot.cla()
			pyplot.clf()
			pyplot.close()
	f, axarr = matplotlib.pyplot.subplots(2, sharex=False)
	f1, Pxx_den1 = signal.welch(HC_SpikeTimes_Baseline, 1/(dt/1000), nperseg=25000)
	f2, Pxx_den2 = signal.welch(HC_SpikeTimes_Rhythm, 1/(dt/1000), nperseg=25000)
	axarr[0].semilogy(f1, Pxx_den1,'b')
	axarr[0].semilogy(f2, Pxx_den2,'r')
	axarr[0].set_xlim(0,100)
	axarr[0].set_xlabel('frequency (Hz)')
	axarr[0].set_ylabel(r'$PSD (Spikes^2 / Hz)$')
	
	ind = numpy.arange(4)
	width = 0.4
	area1 = numpy.trapz(Pxx_den1[(f1>4) & (f1<12)],x=f1[(f1>4) & (f1<12)])
	area2 = numpy.trapz(Pxx_den2[(f2>4) & (f2<12)],x=f2[(f2>4) & (f2<12)])
	e8Hz1[x] = Pxx_den1[f1==8]
	e8Hz2[x] = Pxx_den2[f2==8]
	Areas1[x] = area1
	Areas2[x] = area2
	axarr[1].bar(ind+width, [area1, area2, e8Hz1[x], e8Hz2[x]], width, color='k')
	axarr[1].set_xticks(ind+width+width/2)
	axarr[1].set_xticklabels(('Base\n(4-12Hz)','Sinusoid\n(4-12Hz)','Base\n(8Hz)','Sinusoid\n(8Hz)'))
	axarr[1].set_ylabel('PSD Magnitude')
	axarr[1].set_xlim(0,4+width)
	pyplot.savefig('PLOTfiles/' + Case + '_PSD_' + ExampleString + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_PSD_' + ExampleString + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
numpy.save('NPYfiles/' + Case + '_Areas1.npy',Areas1)
numpy.save('NPYfiles/' + Case + '_Areas2.npy',Areas2)
numpy.save('NPYfiles/' + Case + '_e8Hz1.npy',e8Hz1)
numpy.save('NPYfiles/' + Case + '_e8Hz2.npy',e8Hz2)
Area_ind = numpy.arange(0,len(Areas1))
Areas1_post = numpy.delete(Areas1,Area_ind[Areas1==0],None)
Areas2_post = numpy.delete(Areas2,Area_ind[Areas2==0],None)
MeanAreas1 = numpy.mean(Areas1_post)
MeanAreas2 = numpy.mean(Areas2_post)
StdAreas1 = numpy.std(Areas1_post)
StdAreas2 = numpy.std(Areas2_post)
e8Hz1_post = numpy.delete(e8Hz1,Area_ind[Areas1==0],None)
e8Hz2_post = numpy.delete(e8Hz2,Area_ind[Areas2==0],None)
Meane8Hz1 = numpy.mean(e8Hz1_post)
Meane8Hz2 = numpy.mean(e8Hz2_post)
Stde8Hz1 = numpy.std(e8Hz1_post)
Stde8Hz2 = numpy.std(e8Hz2_post)

ind = numpy.arange(4)
width = 0.4
fig, axarr = pyplot.subplots()
barlist = axarr.bar(ind+width, [MeanAreas1, MeanAreas2, Meane8Hz1, Meane8Hz2], width, color='k', yerr=[StdAreas1, StdAreas2, Stde8Hz1, Stde8Hz2], ecolor='k')
barlist[0].set_color('b')
barlist[1].set_color('r')
barlist[2].set_color('b')
barlist[3].set_color('r')
axarr.set_xticks(ind+width+width/2)
axarr.set_xticklabels(('Base\n(4-12Hz)','Sinusoid\n(4-12Hz)','Base\n(8Hz)','Sinusoid\n(8Hz)'))
axarr.set_ylabel('PSD Magnitude')
axarr.set_xlim(0,4+width)
pyplot.savefig('PLOTfiles/' + Case + '_MeanPSD.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_MeanPSD.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

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
