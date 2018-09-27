### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
from scipy import signal

Case = 'SDprox2_E_COM_I_COM'
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
randseedsynspikes1 = 10 # if using fixed random seeds
randseedsynspikes2 = 15
thetaSynMultiplier = numpy.array([0, 1])

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
		print 'Simulating... ' + str(ExampleStrings[x]) + ' #' + str(y+1)
		ExampleString = ExampleStrings[x]
		HCNumber = x
		# Run Simulation of Example
		h.randomize_syns(5,2) # i.e. same random seeds when comparing runs
		h.f(Examples[0][x],Examples[1][x],Examples[2][x],Examples[3][x],SaveExample,randseedsynspikes1,randseedsynspikes2,1,INH*numInhThetaSyns*thetaSynMultiplier[y],EXC*numExcThetaSyns*thetaSynMultiplier[y],EXCSLM,EXCSR,OLMSLM,NGFSLM,IS2SLM,BISSR,IS1SR) # i.e. same random seeds when comparing runs
		
		HC_Trace = numpy.fromfile("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('model_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon_X',str(thetaSynMultiplier[y]),'_ThetaMultiplier.dat'),dtype=float)
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
			f, axarr = matplotlib.pyplot.subplots(2, sharex=True)
			axarr[0].plot(timevec,voltvec,'g')
			axarr[0].set_title("%s%s%s%s%s%s%s%s%s" % ('InhSyns: ',str(Examples[0][x]),', ExcSyns: ',str(Examples[1][x]),',\nInhSpikes: ',str(Examples[2][x]/tstop),'Hz, ExcSpikes: ',str(Examples[3][x]/tstop),'Hz'))
			axarr[0].set_ylim(-90,30)
			axarr[0].set_xlim(8000,10000)
			axarr[0].set_ylabel('Voltage (mV)',fontsize=font_size)
		if y == 1:
			axarr[1].plot(timevec,voltvec,'m')
			axarr[1].set_title('Theta Input',fontsize=font_size)
			axarr[1].set_ylim(-90,30)
			axarr[1].set_xlim(8000,10000)
			axarr[1].set_ylabel('Voltage (mV)',fontsize=font_size)
			pyplot.savefig('PLOTfiles/' + Case + '_Trace_' + ExampleString + '.pdf', bbox_inches='tight')
			pyplot.savefig('PLOTfiles/' + Case + '_Trace_' + ExampleString + '.png', bbox_inches='tight')
			pyplot.gcf().clear()
			pyplot.cla()
			pyplot.clf()
			pyplot.close()
	f, axarr = matplotlib.pyplot.subplots(2, sharex=False)
	f1, Pxx_den1 = signal.welch(HC_SpikeTimes_Baseline, 1/(dt/1000), nperseg=25000)
	f2, Pxx_den2 = signal.welch(HC_SpikeTimes_Rhythm, 1/(dt/1000), nperseg=25000)
	numpy.save('NPYfiles/' + Case + '_SpikeTimesBaseline_' + str(HCNumber) + '_HCNumber.npy',HC_SpikeTimes_Baseline)
	numpy.save('NPYfiles/' + Case + '_SpikeTimesRhythm_' + str(HCNumber) + '_HCNumber.npy',HC_SpikeTimes_Rhythm)
	axarr[0].semilogy(f1, Pxx_den1,'g')
	axarr[0].semilogy(f2, Pxx_den2,'m')
	axarr[0].set_xlim(0,100)
	axarr[0].set_xlabel('Frequency (Hz)')
	axarr[0].set_ylabel(r'$PSD (Spikes^2 / Hz)$')
	
	ind = numpy.arange(4)
	width = 0.5
	area1 = numpy.trapz(Pxx_den1[(f1>4) & (f1<12)],x=f1[(f1>4) & (f1<12)])
	area2 = numpy.trapz(Pxx_den2[(f2>4) & (f2<12)],x=f2[(f2>4) & (f2<12)])
	e8Hz1[x] = Pxx_den1[f1==8]
	e8Hz2[x] = Pxx_den2[f2==8]
	Areas1[x] = area1
	Areas2[x] = area2
	axarr[1].bar(ind+width+width/2, [area1, area2, e8Hz1[x], e8Hz2[x]], width, color=['green', 'magenta'])
	axarr[1].set_xticks(ind+width+width/2)
	axarr[1].set_xticklabels(('Base\n(4-12Hz)','Theta\n(4-12Hz)','Base\n(8Hz)','Theta\n(8Hz)'))
	axarr[1].set_ylabel('PSD Magnitude')
	axarr[1].set_xlim(0,4+width)
	pyplot.tight_layout()
	pyplot.savefig('PLOTfiles/' + Case + '_PSD_' + ExampleString + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_PSD_' + ExampleString + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
h.spTheta.printfile("ThetaSynLocationsShapePlot.ps")
h.spTheta.erase()
numpy.save('NPYfiles/' + Case + '_Areas1.npy',Areas1)
numpy.save('NPYfiles/' + Case + '_Areas2.npy',Areas2)
numpy.save('NPYfiles/' + Case + '_e8Hz1.npy',e8Hz1)
numpy.save('NPYfiles/' + Case + '_e8Hz2.npy',e8Hz2)
# e8Hz1 = numpy.load('NPYfiles/' + Case + '_e8Hz1.npy')
# e8Hz2 = numpy.load('NPYfiles/' + Case + '_e8Hz2.npy')

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

ind = numpy.arange(16)
width = 0.2
f, axarr = matplotlib.pyplot.subplots(1)
rects1 = axarr.bar(ind+width,e8Hz1,width,color='g')
rects2 = axarr.bar(ind+2*width,e8Hz2,width,color='m')
axarr.set_xticks(ind-width+width/2)
axarr.set_xticklabels(ExampleStrings,fontsize=6, fontweight='bold', rotation=45)
axarr.set_ylabel(r'PSD Magnitude at 8 Hz $(Spikes^2 / Hz)$')
axarr.legend((rects1[0], rects2[0]), ('Base', 'Theta'))
pyplot.savefig('PLOTfiles/' + Case + '_PSDAllBars.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_PSDAllBars.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

ind = numpy.arange(4)
width = 0.4
fig, axarr = pyplot.subplots()
barlist = axarr.bar(ind+width, [MeanAreas1, MeanAreas2, Meane8Hz1, Meane8Hz2], width, color='k', yerr=[StdAreas1, StdAreas2, Stde8Hz1, Stde8Hz2], ecolor='k')
barlist[0].set_color('g')
barlist[1].set_color('m')
barlist[2].set_color('g')
barlist[3].set_color('m')
axarr.set_xticks(ind+width+width/2)
axarr.set_xticklabels(('Base\n(4-12Hz)','Theta\n(4-12Hz)','Base\n(8Hz)','Theta\n(8Hz)'))
axarr.set_ylabel('PSD Magnitude')
axarr.set_xlim(0,4+width)
pyplot.savefig('PLOTfiles/' + Case + '_MeanPSD.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_MeanPSD.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

indices = numpy.arange(0,len(Examples[0]))
inhsyncount = numpy.delete(Examples[0],indices[Examples[0]==0],None)
excsyncount = numpy.delete(Examples[1],indices[Examples[1]==0],None)
inhspikes = numpy.delete(Examples[2],indices[Examples[2]==0],None)/tstop
excspikes = numpy.delete(Examples[3],indices[Examples[3]==0],None)/tstop

ChangeInTheta = e8Hz2_post - e8Hz1_post
colormap = numpy.random.rand(3,len(inhsyncount))

fig, axarr = pyplot.subplots(2, sharex=False)

for x in range(0,len(inhsyncount)):
	axarr[0].scatter(inhsyncount[x], ChangeInTheta[x], s=50, c=[colormap[0][x],colormap[1][x],colormap[2][x]])
	axarr[0].set_xlabel('HC Number of Inhibitory Synapses')
	axarr[0].set_ylabel(r'$\Delta PSD_{8Hz}  (Spikes^2/Hz)$')
	
	axarr[1].scatter(excsyncount[x], ChangeInTheta[x], s=50, c=[colormap[0][x],colormap[1][x],colormap[2][x]])
	axarr[1].set_xlabel('HC Number of Excitatory Synapses')
	axarr[1].set_ylabel(r'$\Delta PSD_{8Hz}  (Spikes^2/Hz)$')

pyplot.savefig('PLOTfiles/' + Case + '_HCsynsvsTheta.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_HCsynsvsTheta.png', bbox_inches='tight')

fig, axarr = pyplot.subplots(2, sharex=False)

for x in range(0,len(inhsyncount)):
	axarr[0].scatter(inhspikes[x], ChangeInTheta[x], s=50, c=[colormap[0][x],colormap[1][x],colormap[2][x]])
	axarr[0].set_xlabel('HC Inhibitory Spike Rate (Hz)')
	axarr[0].set_ylabel(r'$\Delta PSD_{8Hz}  (Spikes^2/Hz)$')
	
	axarr[1].scatter(excspikes[x], ChangeInTheta[x], s=50, c=[colormap[0][x],colormap[1][x],colormap[2][x]])
	axarr[1].set_xlabel('HC Excitatory Spike Rate (Hz)')
	axarr[1].set_ylabel(r'$\Delta PSD_{8Hz}  (Spikes^2/Hz)$')

pyplot.savefig('PLOTfiles/' + Case + '_HCspikesvsTheta.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_HCspikesvsTheta.png', bbox_inches='tight')

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
