### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D

Case = 'SDprox1'

execfile("CutSpikes_HighConductanceMeasurements.py")

# If Saving Vectors
numpy.save('NPYfiles/' + Case + '_NumInh.npy', NumInhVec)
numpy.save('NPYfiles/' + Case + '_NumExc.npy', NumExcVec)
numpy.save('NPYfiles/' + Case + '_InhSpikes.npy', InhSpikesVec)
numpy.save('NPYfiles/' + Case + '_ExcSRSpikes.npy', ExcSRSpikesVec)
numpy.save('NPYfiles/' + Case + '_ExcSLMSpikes.npy', ExcSLMSpikesVec)
numpy.save('NPYfiles/' + Case + '_NumExcCommon.npy', NumExcCommonVec)
numpy.save('NPYfiles/' + Case + '_NumInhCommon.npy', NumInhCommonVec)
numpy.save('NPYfiles/' + Case + '_MeanVolt.npy', MeanVolt)
numpy.save('NPYfiles/' + Case + '_StdVolt.npy', StdVolt)
numpy.save('NPYfiles/' + Case + '_ISICV.npy', ISICV)
numpy.save('NPYfiles/' + Case + '_MeanAPamp.npy', MeanAPamp)
numpy.save('NPYfiles/' + Case + '_NumSpikes.npy', NumSpikes)

# If Loading Vectors
# NumInhVec = numpy.load('NPYfiles/' + Case + '_NumInh.npy')
# NumExcVec = numpy.load('NPYfiles/' + Case + '_NumExc.npy')
# InhSpikesVec = numpy.load('NPYfiles/' + Case + '_InhSpikes.npy')
# ExcSRSpikesVec = numpy.load('NPYfiles/' + Case + '_ExcSRSpikes.npy')
# ExcSLMSpikesVec = numpy.load('NPYfiles/' + Case + '_ExcSLMSpikes.npy')
# NumExcCommonVec = numpy.load('NPYfiles/' + Case + '_NumExcCommon.npy')
# NumInhCommonVec = numpy.load('NPYfiles/' + Case + '_NumInhCommon.npy')
# MeanVolt = numpy.load('NPYfiles/' + Case + '_MeanVolt.npy')
# StdVolt = numpy.load('NPYfiles/' + Case + '_StdVolt.npy')
# ISICV = numpy.load('NPYfiles/' + Case + '_ISICV.npy')
# MeanAPamp = numpy.load('NPYfiles/' + Case + '_MeanAPamp.npy')
# NumSpikes = numpy.load('NPYfiles/' + Case + '_NumSpikes.npy')

# HC Treshold Measurement Values
tstop = 10 # seconds
font_size = 13

AvgPot_Thresh = -66.7
StdPot_Thresh = 2.2
ISICV_Thresh = 0.8
AMP_DB_Thresh = 50

# Measure HC Metric In All Models
HC_MetricVec = numpy.zeros((len(NumInhVec),), dtype=numpy.int)
HC_MetricVec[MeanVolt >= AvgPot_Thresh] = HC_MetricVec[MeanVolt >= AvgPot_Thresh] + 1
HC_MetricVec[StdVolt >= StdPot_Thresh] = HC_MetricVec[StdVolt >= StdPot_Thresh] + 1
HC_MetricVec[ISICV >= ISICV_Thresh] = HC_MetricVec[ISICV >= ISICV_Thresh] + 1
HC_MetricVec[MeanAPamp < AMP_DB_Thresh] = HC_MetricVec[MeanAPamp < AMP_DB_Thresh] - 4

# Move HC Models To New List
HC_NumInh = NumInhVec[HC_MetricVec == 3]
HC_NumExc = NumExcVec[HC_MetricVec == 3]
HC_InhSpikes = InhSpikesVec[HC_MetricVec == 3]
HC_ExcSRSpikes = ExcSRSpikesVec[HC_MetricVec == 3]
HC_ExcSLMSpikes = ExcSLMSpikesVec[HC_MetricVec == 3]
HC_NumExcCommon = NumExcCommonVec[HC_MetricVec == 3]
HC_NumInhCommon = NumInhCommonVec[HC_MetricVec == 3]

HC_InhRateVec = HC_InhSpikes/tstop
HC_ExcSRRateVec = HC_ExcSRSpikes/tstop
HC_ExcSLMRateVec = HC_ExcSLMSpikes/tstop

HC_Index = numpy.arange(0,len(HC_NumInh))
HC_Index = numpy.random.permutation(HC_Index)

# Plot Example HC Models
num_examples = 4
for l in range(0,num_examples):
	HC_Trace = numpy.fromfile("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('model_',str(HC_NumInh[HC_Index[l]]),'_NumInh_',str(HC_NumExc[HC_Index[l]]),'_NumExc_',str(HC_InhSpikes[HC_Index[l]]),'_InhSpikes_',str(HC_ExcSRSpikes[HC_Index[l]]),'_ExcSRSpikes_',str(HC_ExcSLMSpikes[HC_Index[l]]),'_ExcSLMSpikes_',str(HC_NumExcCommon[HC_Index[l]]),'_NumExcCommon_',str(HC_NumInhCommon[HC_Index[l]]),'_NumInhCommon.dat'),dtype=float)
	voltvec = HC_Trace[1:len(HC_Trace)]
	
	HC_InhSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('InhPreSpikeTrains_',str(HC_NumInh[HC_Index[l]]),'_NumInh_',str(HC_NumExc[HC_Index[l]]),'_NumExc_',str(HC_InhSpikes[HC_Index[l]]),'_InhSpikes_',str(HC_ExcSRSpikes[HC_Index[l]]),'_ExcSRSpikes_',str(HC_ExcSLMSpikes[HC_Index[l]]),'_ExcSLMSpikes_',str(HC_NumExcCommon[HC_Index[l]]),'_NumExcCommon_',str(HC_NumInhCommon[HC_Index[l]]),'_NumInhCommon.dat'),'r')
	inhinputmat = []
	inhinputmat = [ line.split() for line in HC_InhSpikeTrains] # inhinputmat[NumSyn][NumSpikes]
	
	HC_ExcSRSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('SRExcPreSpikeTrains_',str(HC_NumInh[HC_Index[l]]),'_NumInh_',str(HC_NumExc[HC_Index[l]]),'_NumExc_',str(HC_InhSpikes[HC_Index[l]]),'_InhSpikes_',str(HC_ExcSRSpikes[HC_Index[l]]),'_ExcSRSpikes_',str(HC_ExcSLMSpikes[HC_Index[l]]),'_ExcSLMSpikes_',str(HC_NumExcCommon[HC_Index[l]]),'_NumExcCommon_',str(HC_NumInhCommon[HC_Index[l]]),'_NumInhCommon.dat'),'r')
	excSRinputmat = []
	excSRinputmat = [ line.split() for line in HC_ExcSRSpikeTrains] # excSRinputmat[NumSyn][NumSpikes]
	
	HC_ExcSLMSpikeTrains = open("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('SLMExcPreSpikeTrains_',str(HC_NumInh[HC_Index[l]]),'_NumInh_',str(HC_NumExc[HC_Index[l]]),'_NumExc_',str(HC_InhSpikes[HC_Index[l]]),'_InhSpikes_',str(HC_ExcSRSpikes[HC_Index[l]]),'_ExcSRSpikes_',str(HC_ExcSLMSpikes[HC_Index[l]]),'_ExcSLMSpikes_',str(HC_NumExcCommon[HC_Index[l]]),'_NumExcCommon_',str(HC_NumInhCommon[HC_Index[l]]),'_NumInhCommon.dat'),'r')
	excSLMinputmat = []
	excSLMinputmat = [ line.split() for line in HC_ExcSLMSpikeTrains] # excSLMinputmat[NumSyn][NumSpikes]
	
	timevec = numpy.arange(0,10000.1,0.1)
	f, axarr = matplotlib.pyplot.subplots(2, sharex=True)
	axarr[0].plot(timevec,voltvec)
	axarr[0].set_title("%s%s%s%s%s%s%s%s%s%s%s%s" % ('InhSyns: ',str(HC_NumInh[HC_Index[l]]),', ExcSyns: ',str(HC_NumExc[HC_Index[l]]),', InhSpikes: ',str(HC_InhSpikes[HC_Index[l]]/tstop),'Hz,\nExcSpikes: ',str(HC_ExcSRSpikes[HC_Index[l]]/tstop),'Hz, ExcCommon: ',str(HC_NumExcCommon[HC_Index[l]]),', InhCommon: ',str(HC_NumInhCommon[HC_Index[l]])))
	axarr[0].set_ylim(-75,30)
	axarr[0].set_ylabel('Voltage (mV)',fontsize=font_size)
	
	for i in range(0,len(inhinputmat)):
	    axarr[1].vlines(inhinputmat[i][:],i+0.75,i+1.25,'r')
	
	for j in range(0,len(excSRinputmat)):
	    axarr[1].vlines(excSRinputmat[j][:],i+j+0.75,i+j+1.25,'b')
	
	for k in range(0,len(excSLMinputmat)):
	    axarr[1].vlines(excSLMinputmat[k][:],i+j+k+0.75,i+j+k+1.25,'g')
	
	axarr[1].set_ylim(0,i+j+k)
	axarr[1].set_xlabel('Time (ms)',fontsize=font_size)
	axarr[1].set_ylabel('Neuron Index',fontsize=font_size)
	
	pyplot.savefig('PLOTfiles/' + Case + '_HCModelExample' + str(l+1) + '.pdf', bbox_inches='tight')
	pyplot.savefig('PLOTfiles/' + Case + '_HCModelExample' + str(l+1) + '.png', bbox_inches='tight')

# Plot High-Conductance Model I/E Ratio Parameters
SynIERatios = HC_NumInh/HC_NumExc
RateIERatios = HC_InhRateVec/HC_ExcSRRateVec

Edom_syn = SynIERatios[(SynIERatios<1) & (RateIERatios<1)]
Edom_rate = RateIERatios[(SynIERatios<1) & (RateIERatios<1)]
Idom_syn = SynIERatios[(SynIERatios>1) & (RateIERatios>1)]
Idom_rate = RateIERatios[(SynIERatios>1) & (RateIERatios>1)]
Esyndom_Iratedom_syn = SynIERatios[(SynIERatios<1) & (RateIERatios>1)]
Esyndom_Iratedom_rate = RateIERatios[(SynIERatios<1) & (RateIERatios>1)]
Eratedom_Isyndom_syn = SynIERatios[(SynIERatios>1) & (RateIERatios<1)]
Eratedom_Isyndom_rate = RateIERatios[(SynIERatios>1) & (RateIERatios<1)]

f, axarr = matplotlib.pyplot.subplots(2, sharex=False)
axarr[0].scatter(Edom_syn,Edom_rate,50,'b')
axarr[0].scatter(Idom_syn,Idom_rate,50,'r')
axarr[0].scatter(Esyndom_Iratedom_syn,Esyndom_Iratedom_rate,50,'g')
axarr[0].scatter(Eratedom_Isyndom_syn,Eratedom_Isyndom_rate,50,'c')
axarr[0].legend(('E Syn & Rate','I Syn & Rate','Esyn & I Rate','I Syn & E Rate'),loc='upper right',fontsize=font_size)
axarr[0].set_xlabel('I/E Synapse Ratio',fontsize=font_size)
axarr[0].set_ylabel('I/E Rate Ratio',fontsize=font_size)
axarr[0].set_xlim(0,1.5)
axarr[0].set_ylim(0,15)
axarr[0].tick_params(axis='both', which='major')

axarr[1].bar([1,2,3,4],(len(Edom_syn),len(Idom_syn),len(Esyndom_Iratedom_syn),len(Eratedom_Isyndom_syn)),0.5,align='center')
axarr[1].set_xticklabels(('','E Syn\n& Rate','I Syn\n& Rate','Esyn\n& I Rate','I Syn\n& E Rate'))
axarr[1].set_xlim(0,5)
axarr[1].set_ylabel('HC Model Count',fontsize=font_size)

pyplot.savefig('PLOTfiles/' + Case + '_HCModelIERatios.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_HCModelIERatios.png', bbox_inches='tight')

# Plot High-Conductance Model Common Inputs Paramters
CommonMat = [HC_NumExcCommon, HC_NumInhCommon]
Common1E1I = CommonMat[0][CommonMat[0]+CommonMat[1] == 2]
Common1E3I = CommonMat[0][CommonMat[0]+CommonMat[1] == 4]
Common1E9I = CommonMat[0][CommonMat[0]+CommonMat[1] == 10]
Common4E1I = CommonMat[0][CommonMat[0]+CommonMat[1] == 5]
Common4E3I = CommonMat[0][CommonMat[0]+CommonMat[1] == 7]
Common4E9I = CommonMat[0][CommonMat[0]+CommonMat[1] == 13]
Common16E1I = CommonMat[0][CommonMat[0]+CommonMat[1] == 17]
Common16E3I = CommonMat[0][CommonMat[0]+CommonMat[1] == 19]
Common16E9I = CommonMat[0][CommonMat[0]+CommonMat[1] == 25]

Counts = (len(Common1E1I),len(Common1E3I),len(Common1E9I),len(Common4E1I),len(Common4E3I),len(Common4E9I),len(Common16E1I),len(Common16E3I),len(Common16E9I))
f = pyplot.figure()
ax = f.add_axes([0.1, 0.1, 0.8, 0.8])
ax.bar(numpy.arange(1,10),Counts,0.5,align='center')
ax.set_xticks(numpy.arange(1,10))
ax.set_xticklabels(('1E1I','1E3I','1E9I','4E1I','4E3I','4E9I','16E1I','16E3I','16E9I'))
ax.set_xlim(0,10)
ax.set_ylabel('HC Model Count',fontsize=font_size)

pyplot.savefig('PLOTfiles/' + Case + '_HCModelCommonInputs.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_HCModelCommonInputs.png', bbox_inches='tight')

# Plot Ratios Against Common Excitatory Inputs
SynIERatios_1E = SynIERatios[HC_NumExcCommon == 1]
RateIERatios_1E = RateIERatios[HC_NumExcCommon == 1]

SynIERatios_4E = SynIERatios[HC_NumExcCommon == 4]
RateIERatios_4E = RateIERatios[HC_NumExcCommon == 4]

SynIERatios_16E = SynIERatios[HC_NumExcCommon == 16]
RateIERatios_16E = RateIERatios[HC_NumExcCommon == 16]

f, axarr = matplotlib.pyplot.subplots(3, sharex=True, sharey=True)
axarr[0].scatter(SynIERatios_1E,RateIERatios_1E,50,'g')
axarr[0].set_title("1 Common Excitatory Inputs",fontsize=font_size)
axarr[0].set_ylabel('I/E Rate Ratio',fontsize=font_size)

axarr[1].scatter(SynIERatios_4E,RateIERatios_4E,50,'g')
axarr[1].set_title("4 Common Excitatory Inputs",fontsize=font_size)
axarr[1].set_ylabel('I/E Rate Ratio',fontsize=font_size)

axarr[2].scatter(SynIERatios_16E,RateIERatios_16E,50,'g')
axarr[2].set_title("16 Common Excitatory Inputs",fontsize=font_size)
axarr[2].set_xlabel('I/E Synapse Ratio',fontsize=font_size)
axarr[2].set_ylabel('I/E Rate Ratio',fontsize=font_size)

pyplot.savefig('PLOTfiles/' + Case + '_HCModelExcitatoryCommonVSIERatio.pdf')
pyplot.savefig('PLOTfiles/' + Case + '_HCModelExcitatoryCommonVSIERatio.png')

# Plot Ratios Against Common Inhibitory Inputs
SynIERatios_1I = SynIERatios[HC_NumInhCommon == 1]
RateIERatios_1I = RateIERatios[HC_NumInhCommon == 1]

SynIERatios_3I = SynIERatios[HC_NumInhCommon == 3]
RateIERatios_3I = RateIERatios[HC_NumInhCommon == 3]

SynIERatios_9I = SynIERatios[HC_NumInhCommon == 9]
RateIERatios_9I = RateIERatios[HC_NumInhCommon == 9]

f, axarr = matplotlib.pyplot.subplots(3, sharex=True, sharey=True)
axarr[0].scatter(SynIERatios_1I,RateIERatios_1I,50,'g')
axarr[0].set_title("1 Common Inhibitory Inputs",fontsize=font_size)
axarr[0].set_ylabel('I/E Rate Ratio',fontsize=font_size)

axarr[1].scatter(SynIERatios_3I,RateIERatios_3I,50,'g')
axarr[1].set_title("3 Common Inhibitory Inputs",fontsize=font_size)
axarr[1].set_ylabel('I/E Rate Ratio',fontsize=font_size)

axarr[2].scatter(SynIERatios_9I,RateIERatios_9I,50,'g')
axarr[2].set_title("9 Common Inhibitory Inputs",fontsize=font_size)
axarr[2].set_xlabel('I/E Synapse Ratio',fontsize=font_size)
axarr[2].set_ylabel('I/E Rate Ratio',fontsize=font_size)

pyplot.savefig('PLOTfiles/' + Case + '_HCModelInhibitoryCommonVSIERatio.pdf')
pyplot.savefig('PLOTfiles/' + Case + '_HCModelInhibitoryCommonVSIERatio.png')

