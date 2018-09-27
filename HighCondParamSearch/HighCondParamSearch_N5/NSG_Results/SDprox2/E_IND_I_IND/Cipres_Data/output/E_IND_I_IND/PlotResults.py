### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D

Case = 'SDprox2_E_IND_I_IND'

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
AMP_DB_Thresh = 40

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

numpy.save('NPYfiles/' + Case + '_HCNumInh.npy', HC_NumInh)
numpy.save('NPYfiles/' + Case + '_HCNumExc.npy', HC_NumExc)
numpy.save('NPYfiles/' + Case + '_HCInhSpikes.npy', HC_InhSpikes)
numpy.save('NPYfiles/' + Case + '_HCExcSRSpikes.npy', HC_ExcSRSpikes)
numpy.save('NPYfiles/' + Case + '_HCExcSLMSpikes.npy', HC_ExcSLMSpikes)
numpy.save('NPYfiles/' + Case + '_HCNumExcCommon.npy', HC_NumExcCommon)
numpy.save('NPYfiles/' + Case + '_HCNumInhCommon.npy', HC_NumInhCommon)

HC_InhRateVec = HC_InhSpikes/tstop
HC_ExcSRRateVec = HC_ExcSRSpikes/tstop
HC_ExcSLMRateVec = HC_ExcSLMSpikes/tstop

HC_Index = numpy.arange(0,len(HC_NumInh))
HC_Index = numpy.random.permutation(HC_Index)

print 'Number Of High Conductance Models For Case ' + Case + ' = ' + str(len(HC_Index))

# Plot High-Conductance Model I/E Ratio Parameters
SynEIRatios = HC_NumExc/HC_NumInh
RateEIRatios = HC_ExcSRRateVec/HC_InhRateVec

Edom_syn = SynEIRatios[(SynEIRatios>1) & (RateEIRatios>1)]
Edom_rate = RateEIRatios[(SynEIRatios>1) & (RateEIRatios>1)]
Idom_syn = SynEIRatios[(SynEIRatios<1) & (RateEIRatios<1)]
Idom_rate = RateEIRatios[(SynEIRatios<1) & (RateEIRatios<1)]
Esyndom_Iratedom_syn = SynEIRatios[(SynEIRatios>1) & (RateEIRatios<1)]
Esyndom_Iratedom_rate = RateEIRatios[(SynEIRatios>1) & (RateEIRatios<1)]
Eratedom_Isyndom_syn = SynEIRatios[(SynEIRatios<1) & (RateEIRatios>1)]
Eratedom_Isyndom_rate = RateEIRatios[(SynEIRatios<1) & (RateEIRatios>1)]

f, axarr = matplotlib.pyplot.subplots(2, sharex=False)
axarr[0].scatter(SynEIRatios,RateEIRatios,50,'b')
axarr[0].set_xlabel('E/I Synapse Ratio',fontsize=font_size)
axarr[0].set_ylabel('E/I Rate Ratio',fontsize=font_size)
axarr[0].tick_params(axis='both', which='major')

axarr[1].bar([1,2,3,4],(len(Edom_syn),len(Idom_syn),len(Esyndom_Iratedom_syn),len(Eratedom_Isyndom_syn)),0.5,align='center')
axarr[1].set_xticklabels(('','E Syn\n& Rate','I Syn\n& Rate','E syn\n& I Rate','I Syn\n& E Rate'))
axarr[1].set_xlim(0,5)
axarr[1].set_ylabel('E/I Synapse & Rate Dominance in HC Models',fontsize=font_size)

pyplot.savefig('PLOTfiles/' + Case + '_HCModelIERatios.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_HCModelIERatios.png', bbox_inches='tight')
