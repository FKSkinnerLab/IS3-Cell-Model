### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
from scipy import signal

Case = 'SDprox2_E_COM_I_COM'
SLM = 1
SR = 1
EXC = 1
INH = 1

numThetaSyns = 27
numInhSyns = 8
SaveExample = 1
randseed1 = 10 # if using fixed random seeds
randseed2 = 15

# HC Treshold Measurement Values
tstop = 10 # seconds
font_size = 13

Examples = numpy.load('NPYfiles/' + Case + '_ExampleHCModelParams.npy')
ExampleStrings = numpy.load('NPYfiles/' + Case + '_ExampleHCModelStrings.npy')

tstop = 10
dt = 0.01
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
		
		HC_Trace = numpy.fromfile("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('model_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon_',str(y),'_AddRhythmTrue.dat'),dtype=float)
		voltvec = HC_Trace[1:len(HC_Trace)]
		timevec = numpy.arange(0,10000.1,0.1)
		if y == 0:
			f, axarr = matplotlib.pyplot.subplots(3, sharex=True)
			axarr[0].plot(timevec,voltvec,'b')
			axarr[0].set_title("%s%s%s%s%s%s%s%s%s" % ('InhSyns: ',str(Examples[0][x]),', ExcSyns: ',str(Examples[1][x]),',\nInhSpikes: ',str(Examples[2][x]/tstop),'Hz, ExcSpikes: ',str(Examples[3][x]/tstop),'Hz'))
			axarr[0].set_xlim(9000,10000)
			axarr[0].set_ylim(-90,30)
			axarr[0].set_ylabel('Voltage (mV)',fontsize=font_size)
		if y == 1:
			axarr[1].plot(timevec,voltvec,'r')
			axarr[1].set_title('Theta Input',fontsize=font_size)
			axarr[1].set_xlim(9000,10000)
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
			
			for l in range(63,71):
				axarr[2].vlines(Thetainputmat[l][:],i+j+k+(l-63)-0.25,i+j+k+(l-63)+0.25,'r') #SR inhibitory theta
			
			for m in range(55,63):
				axarr[2].vlines(Thetainputmat[m][:],i+j+k+(l-63)+(m-54)-0.25,i+j+k+(l-63)+(m-54)+0.25,'m') #SLM inhibitory theta
			
			for n in range(28,55):
				axarr[2].vlines(Thetainputmat[n][:],i+j+k+(l-63)+(m-54)+(n-27)-0.25,i+j+k+(l-63)+(m-54)+(n-27)+0.25,'b') #SR excitatory theta
			
			for o in range(1,28):
				axarr[2].vlines(Thetainputmat[o][:],i+j+k+(l-63)+(m-54)+(n-27)+o-0.25,i+j+k+(l-63)+(m-54)+(n-27)+o+0.25,'g') #SLM excitatory theta
			
			axarr[2].set_ylim(0,i+j+k+(l-63)+(m-54)+(n-27)+o+1)
			axarr[2].set_xlim(9000,10000)
			axarr[2].set_xlabel('Time (ms)',fontsize=font_size)
			axarr[2].set_ylabel('Synapse Index',fontsize=font_size)
			
			pyplot.savefig('PLOTfiles/' + Case + '_Trace_' + ExampleString + '.pdf', bbox_inches='tight')
			pyplot.savefig('PLOTfiles/' + Case + '_Trace_' + ExampleString + '.png', bbox_inches='tight')
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
