### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D

Case = 'SDprox1_E_COM_I_COM'

execfile("CutSpikes_HighConductanceMeasurements.py")

# HC Treshold Measurement Values
tstop = 10 # seconds
font_size = 13

Examples = zip(LNI_LNE_LIS_LES,HNI_LNE_LIS_LES,LNI_HNE_LIS_LES,HNI_HNE_LIS_LES,LNI_LNE_HIS_LES,HNI_LNE_HIS_LES,LNI_HNE_HIS_LES,HNI_HNE_HIS_LES,LNI_LNE_LIS_HES,HNI_LNE_LIS_HES,LNI_HNE_LIS_HES,HNI_HNE_LIS_HES,LNI_LNE_HIS_HES,HNI_LNE_HIS_HES,LNI_HNE_HIS_HES,HNI_HNE_HIS_HES)
ExampleStrings = ['LNI_LNE_LIS_LES','HNI_LNE_LIS_LES','LNI_HNE_LIS_LES','HNI_HNE_LIS_LES','LNI_LNE_HIS_LES','HNI_LNE_HIS_LES','LNI_HNE_HIS_LES','HNI_HNE_HIS_LES','LNI_LNE_LIS_HES','HNI_LNE_LIS_HES','LNI_HNE_LIS_HES','HNI_HNE_LIS_HES','LNI_LNE_HIS_HES','HNI_LNE_HIS_HES','LNI_HNE_HIS_HES','HNI_HNE_HIS_HES']
numpy.save('NPYfiles/' + Case + '_ExampleHCModelParams.npy',Examples)
numpy.save('NPYfiles/' + Case + '_ExampleHCModelStrings.npy',ExampleStrings)

for x in range(0,len(Examples[0])):
	if Examples[0][x] == 0:
		print str(ExampleStrings[x]) + ' is empty'
		continue
	ExampleString = ExampleStrings[x]
	
	# Run Simulation of Example
	# h.randomize_syns(x*18641,x*51202) # i.e. with new random seeds
	# h.f(Examples[0][x],Examples[1][x],Examples[2][x],Examples[3][x],1,x*123457,x*598723) # i.e. with new random seeds
	
	HC_Trace = numpy.fromfile("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('model_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon.dat'),dtype=float)
	voltvec = HC_Trace[1:len(HC_Trace)]
	
	HC_InhSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('InhPreSpikeTrains_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon.dat'),'r')
	inhinputmat = []
	inhinputmat = [ line.split() for line in HC_InhSpikeTrains] # inhinputmat[NumSyn][NumSpikes]
	
	HC_ExcSRSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('SRExcPreSpikeTrains_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon.dat'),'r')
	excSRinputmat = []
	excSRinputmat = [ line.split() for line in HC_ExcSRSpikeTrains] # excSRinputmat[NumSyn][NumSpikes]
	
	HC_ExcSLMSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('SLMExcPreSpikeTrains_',str(Examples[0][x]),'_NumInh_',str(Examples[1][x]),'_NumExc_',str(Examples[2][x]),'_InhSpikes_',str(Examples[3][x]),'_ExcSRSpikes_',str(Examples[3][x]),'_ExcSLMSpikes_',str(9),'_NumExcCommon_',str(4),'_NumInhCommon.dat'),'r')
	excSLMinputmat = []
	excSLMinputmat = [ line.split() for line in HC_ExcSLMSpikeTrains] # excSLMinputmat[NumSyn][NumSpikes]
	
	timevec = numpy.arange(0,10000.1,0.1)
	f, axarr = matplotlib.pyplot.subplots(2, sharex=True)
	axarr[0].plot(timevec,voltvec)
	axarr[0].set_title("%s%s%s%s%s%s%s%s%s" % ('InhSyns: ',str(Examples[0][x]),', ExcSyns: ',str(Examples[1][x]),',\nInhSpikes: ',str(Examples[2][x]/tstop),'Hz, ExcSpikes: ',str(Examples[3][x]/tstop),'Hz'))
	axarr[0].set_ylim(-75,30)
	axarr[0].set_ylabel('Voltage (mV)',fontsize=font_size)
	
	for i in range(1,len(inhinputmat)):
		axarr[1].vlines(inhinputmat[i][:],i-0.25,i+0.25,'r')
	
	for j in range(1,len(excSRinputmat)):
		axarr[1].vlines(excSRinputmat[j][:],i+j-0.25,i+j+0.25,'b')
	
	for k in range(1,len(excSLMinputmat)):
		axarr[1].vlines(excSLMinputmat[k][:],i+j+k-0.25,i+j+k+0.25,'g')
	
	axarr[1].set_ylim(0,i+j+k+1)
	axarr[1].set_xlabel('Time (ms)',fontsize=font_size)
	axarr[1].set_ylabel('Synapse Index',fontsize=font_size)
	
	pyplot.savefig('PLOTfiles/' + Case + '_' + ExampleString + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_' + ExampleString + '.png', bbox_inches='tight')


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