### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
from numpy import inf
from numpy import nan
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
import random

Case = 'SDprox2_E_COM_I_COM'

# If Loading Vectors
NumInhVec = numpy.load('NPYfiles/' + Case + '_NumInh.npy')
NumExcVec = numpy.load('NPYfiles/' + Case + '_NumExc.npy')
InhSpikesVec = numpy.load('NPYfiles/' + Case + '_InhSpikes.npy')
ExcSRSpikesVec = numpy.load('NPYfiles/' + Case + '_ExcSRSpikes.npy')
ExcSLMSpikesVec = numpy.load('NPYfiles/' + Case + '_ExcSLMSpikes.npy')
NumExcCommonVec = numpy.load('NPYfiles/' + Case + '_NumExcCommon.npy')
NumInhCommonVec = numpy.load('NPYfiles/' + Case + '_NumInhCommon.npy')
MeanVolt = numpy.load('NPYfiles/' + Case + '_MeanVolt.npy')
StdVolt = numpy.load('NPYfiles/' + Case + '_StdVolt.npy')
ISICV = numpy.load('NPYfiles/' + Case + '_ISICV.npy')
MeanAPamp = numpy.load('NPYfiles/' + Case + '_MeanAPamp.npy')
NumSpikes = numpy.load('NPYfiles/' + Case + '_NumSpikes.npy')

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
HC_MetricVec[(MeanAPamp < AMP_DB_Thresh) & (NumSpikes > 0)] = HC_MetricVec[(MeanAPamp < AMP_DB_Thresh) & (NumSpikes > 0)] - 4

# Move HC Models To New List
HC_NumInh = NumInhVec[HC_MetricVec == 3]
HC_NumExc = NumExcVec[HC_MetricVec == 3]
HC_InhSpikes = InhSpikesVec[HC_MetricVec == 3]
HC_ExcSRSpikes = ExcSRSpikesVec[HC_MetricVec == 3]
HC_ExcSLMSpikes = ExcSLMSpikesVec[HC_MetricVec == 3]
HC_NumExcCommon = NumExcCommonVec[HC_MetricVec == 3]
HC_NumInhCommon = NumInhCommonVec[HC_MetricVec == 3]
HC_NumSpikes = NumSpikes[HC_MetricVec == 3]

HC_InhRateVec = HC_InhSpikes/tstop
HC_ExcSRRateVec = HC_ExcSRSpikes/tstop
HC_ExcSLMRateVec = HC_ExcSLMSpikes/tstop

HC_Index = numpy.arange(0,len(HC_NumInh))
HC_Index = numpy.random.permutation(HC_Index)

# Move Depolarization Block Models to New List
DB_NumInh = NumInhVec[HC_MetricVec < 0]
DB_NumExc = NumExcVec[HC_MetricVec < 0]
DB_InhSpikes = InhSpikesVec[HC_MetricVec < 0]
DB_ExcSRSpikes = ExcSRSpikesVec[HC_MetricVec < 0]
DB_ExcSLMSpikes = ExcSLMSpikesVec[HC_MetricVec < 0]
DB_NumExcCommon = NumExcCommonVec[HC_MetricVec < 0]
DB_NumInhCommon = NumInhCommonVec[HC_MetricVec < 0]
DB_NumSpikes = NumSpikes[HC_MetricVec < 0]

DB_InhRateVec = DB_InhSpikes/tstop
DB_ExcSRRateVec = DB_ExcSRSpikes/tstop
DB_ExcSLMRateVec = DB_ExcSLMSpikes/tstop

DB_Index = numpy.arange(0,len(DB_NumInh))
DB_Index = numpy.random.permutation(DB_Index)

# Move Non-High Conductance Models to New List
NHC_NumInh = NumInhVec[HC_MetricVec == 0]
NHC_NumExc = NumExcVec[HC_MetricVec == 0]
NHC_InhSpikes = InhSpikesVec[HC_MetricVec == 0]
NHC_ExcSRSpikes = ExcSRSpikesVec[HC_MetricVec == 0]
NHC_ExcSLMSpikes = ExcSLMSpikesVec[HC_MetricVec == 0]
NHC_NumExcCommon = NumExcCommonVec[HC_MetricVec == 0]
NHC_NumInhCommon = NumInhCommonVec[HC_MetricVec == 0]
NHC_NumSpikes = NumSpikes[HC_MetricVec == 0]

NHC_InhRateVec = NHC_InhSpikes/tstop
NHC_ExcSRRateVec = NHC_ExcSRSpikes/tstop
NHC_ExcSLMRateVec = NHC_ExcSLMSpikes/tstop

NHC_Index = numpy.arange(0,len(NHC_NumInh))
NHC_Index = numpy.random.permutation(NHC_Index)

# Divide HC models into pools & print numbers
execfile("PoolDivide.py")
print '-------------------------------------------------'
print '-------------High-Conductance Pools--------------'
print '-------------------------------------------------'
print 'Number Of High Conductance Models (HC Metric = 3) For Case ' + Case + ' = ' + str(len(HC_Index))
HC_PoolStrings_HC_PoolNums = PoolDivide(HC_NumInh,HC_NumExc,HC_InhSpikes,HC_ExcSRSpikes,HC_NumSpikes,"HC")
HC_PoolStrings = HC_PoolStrings_HC_PoolNums[0]
HC_PoolNums = HC_PoolStrings_HC_PoolNums[1]
HC_PoolSpikes = HC_PoolStrings_HC_PoolNums[2]

HC_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.int)

HC_PoolNumsMat[0][0] = HC_PoolNums[10]
HC_PoolNumsMat[0][1] = HC_PoolNums[14]
HC_PoolNumsMat[0][2] = HC_PoolNums[11]
HC_PoolNumsMat[0][3] = HC_PoolNums[15]

HC_PoolNumsMat[1][0] = HC_PoolNums[2]
HC_PoolNumsMat[1][1] = HC_PoolNums[6]
HC_PoolNumsMat[1][2] = HC_PoolNums[3]
HC_PoolNumsMat[1][3] = HC_PoolNums[7]

HC_PoolNumsMat[2][0] = HC_PoolNums[8]
HC_PoolNumsMat[2][1] = HC_PoolNums[12]
HC_PoolNumsMat[2][2] = HC_PoolNums[9]
HC_PoolNumsMat[2][3] = HC_PoolNums[13]

HC_PoolNumsMat[3][0] = HC_PoolNums[0]
HC_PoolNumsMat[3][1] = HC_PoolNums[4]
HC_PoolNumsMat[3][2] = HC_PoolNums[1]
HC_PoolNumsMat[3][3] = HC_PoolNums[5]

HC_PoolSpikesMat = numpy.zeros((4,4), dtype=numpy.float64)

HC_PoolSpikesMat[0][0] = HC_PoolSpikes[10]
HC_PoolSpikesMat[0][1] = HC_PoolSpikes[14]
HC_PoolSpikesMat[0][2] = HC_PoolSpikes[11]
HC_PoolSpikesMat[0][3] = HC_PoolSpikes[15]

HC_PoolSpikesMat[1][0] = HC_PoolSpikes[2]
HC_PoolSpikesMat[1][1] = HC_PoolSpikes[6]
HC_PoolSpikesMat[1][2] = HC_PoolSpikes[3]
HC_PoolSpikesMat[1][3] = HC_PoolSpikes[7]

HC_PoolSpikesMat[2][0] = HC_PoolSpikes[8]
HC_PoolSpikesMat[2][1] = HC_PoolSpikes[12]
HC_PoolSpikesMat[2][2] = HC_PoolSpikes[9]
HC_PoolSpikesMat[2][3] = HC_PoolSpikes[13]

HC_PoolSpikesMat[3][0] = HC_PoolSpikes[0]
HC_PoolSpikesMat[3][1] = HC_PoolSpikes[4]
HC_PoolSpikesMat[3][2] = HC_PoolSpikes[1]
HC_PoolSpikesMat[3][3] = HC_PoolSpikes[5]

print HC_PoolNumsMat

print '-------------------------------------------------'
print '-----------Depolarization Block Pools------------'
print '-------------------------------------------------'
print 'Number Of Depolarization Block Models (HC Metric < 0) For Case ' + Case + ' = ' + str(len(DB_Index))
DB_PoolStrings_DB_PoolNums = PoolDivide(DB_NumInh,DB_NumExc,DB_InhSpikes,DB_ExcSRSpikes,DB_NumSpikes,"DB")
DB_PoolStrings = DB_PoolStrings_DB_PoolNums[0]
DB_PoolNums = DB_PoolStrings_DB_PoolNums[1]

DB_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.int)

DB_PoolNumsMat[0][0] = DB_PoolNums[10]
DB_PoolNumsMat[0][1] = DB_PoolNums[14]
DB_PoolNumsMat[0][2] = DB_PoolNums[11]
DB_PoolNumsMat[0][3] = DB_PoolNums[15]

DB_PoolNumsMat[1][0] = DB_PoolNums[2]
DB_PoolNumsMat[1][1] = DB_PoolNums[6]
DB_PoolNumsMat[1][2] = DB_PoolNums[3]
DB_PoolNumsMat[1][3] = DB_PoolNums[7]

DB_PoolNumsMat[2][0] = DB_PoolNums[8]
DB_PoolNumsMat[2][1] = DB_PoolNums[12]
DB_PoolNumsMat[2][2] = DB_PoolNums[9]
DB_PoolNumsMat[2][3] = DB_PoolNums[13]

DB_PoolNumsMat[3][0] = DB_PoolNums[0]
DB_PoolNumsMat[3][1] = DB_PoolNums[4]
DB_PoolNumsMat[3][2] = DB_PoolNums[1]
DB_PoolNumsMat[3][3] = DB_PoolNums[5]

print DB_PoolNumsMat

print '-------------------------------------------------'
print '-----------Non-High-Conductance Pools------------'
print '-------------------------------------------------'
print 'Number Of Non-High Conductance Models (HC Metric = 0) For Case ' + Case + ' = ' + str(len(NHC_Index))
NHC_PoolStrings_NHC_PoolNums = PoolDivide(NHC_NumInh,NHC_NumExc,NHC_InhSpikes,NHC_ExcSRSpikes,NHC_NumSpikes,"NHC")
NHC_PoolStrings = NHC_PoolStrings_NHC_PoolNums[0]
NHC_PoolNums = NHC_PoolStrings_NHC_PoolNums[1]

NHC_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.int)

NHC_PoolNumsMat[0][0] = NHC_PoolNums[10]
NHC_PoolNumsMat[0][1] = NHC_PoolNums[14]
NHC_PoolNumsMat[0][2] = NHC_PoolNums[11]
NHC_PoolNumsMat[0][3] = NHC_PoolNums[15]

NHC_PoolNumsMat[1][0] = NHC_PoolNums[2]
NHC_PoolNumsMat[1][1] = NHC_PoolNums[6]
NHC_PoolNumsMat[1][2] = NHC_PoolNums[3]
NHC_PoolNumsMat[1][3] = NHC_PoolNums[7]

NHC_PoolNumsMat[2][0] = NHC_PoolNums[8]
NHC_PoolNumsMat[2][1] = NHC_PoolNums[12]
NHC_PoolNumsMat[2][2] = NHC_PoolNums[9]
NHC_PoolNumsMat[2][3] = NHC_PoolNums[13]

NHC_PoolNumsMat[3][0] = NHC_PoolNums[0]
NHC_PoolNumsMat[3][1] = NHC_PoolNums[4]
NHC_PoolNumsMat[3][2] = NHC_PoolNums[1]
NHC_PoolNumsMat[3][3] = NHC_PoolNums[5]

print NHC_PoolNumsMat

# High-Conductance to Depolarization Block Ratios
HCDBRatios = (HC_PoolNums+1)/(DB_PoolNums+1)
Rat_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.float)

Rat_PoolNumsMat[0][0] = HCDBRatios[10]
Rat_PoolNumsMat[0][1] = HCDBRatios[14]
Rat_PoolNumsMat[0][2] = HCDBRatios[11]
Rat_PoolNumsMat[0][3] = HCDBRatios[15]

Rat_PoolNumsMat[1][0] = HCDBRatios[2]
Rat_PoolNumsMat[1][1] = HCDBRatios[6]
Rat_PoolNumsMat[1][2] = HCDBRatios[3]
Rat_PoolNumsMat[1][3] = HCDBRatios[7]

Rat_PoolNumsMat[2][0] = HCDBRatios[8]
Rat_PoolNumsMat[2][1] = HCDBRatios[12]
Rat_PoolNumsMat[2][2] = HCDBRatios[9]
Rat_PoolNumsMat[2][3] = HCDBRatios[13]

Rat_PoolNumsMat[3][0] = HCDBRatios[0]
Rat_PoolNumsMat[3][1] = HCDBRatios[4]
Rat_PoolNumsMat[3][2] = HCDBRatios[1]
Rat_PoolNumsMat[3][3] = HCDBRatios[5]

Rat_PoolNumsMat[Rat_PoolNumsMat == 1] = 0.5
Rat_PoolNumsMat[Rat_PoolNumsMat < 1] = 0
Rat_PoolNumsMat[Rat_PoolNumsMat > 1] = 1
print Rat_PoolNumsMat

# High-Conductance to Non-High Conductance Ratios
HCNHCRatios = (NHC_PoolNums+1)/(HC_PoolNums+1)
Rat2_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.float)

Rat2_PoolNumsMat[0][0] = HCNHCRatios[10]
Rat2_PoolNumsMat[0][1] = HCNHCRatios[14]
Rat2_PoolNumsMat[0][2] = HCNHCRatios[11]
Rat2_PoolNumsMat[0][3] = HCNHCRatios[15]

Rat2_PoolNumsMat[1][0] = HCNHCRatios[2]
Rat2_PoolNumsMat[1][1] = HCNHCRatios[12]
Rat2_PoolNumsMat[1][2] = HCNHCRatios[9]
Rat2_PoolNumsMat[1][3] = HCNHCRatios[13]

Rat2_PoolNumsMat[2][0] = HCNHCRatios[8]
Rat2_PoolNumsMat[2][1] = HCNHCRatios[12]
Rat2_PoolNumsMat[2][2] = HCNHCRatios[9]
Rat2_PoolNumsMat[2][3] = HCNHCRatios[13]

Rat2_PoolNumsMat[3][0] = HCNHCRatios[0]
Rat2_PoolNumsMat[3][1] = HCNHCRatios[4]
Rat2_PoolNumsMat[3][2] = HCNHCRatios[1]
Rat2_PoolNumsMat[3][3] = HCNHCRatios[5]

Rat2_PoolNumsMat[Rat2_PoolNumsMat == 1] = 0.5
Rat2_PoolNumsMat[Rat2_PoolNumsMat < 1] = 0
Rat2_PoolNumsMat[Rat2_PoolNumsMat > 1] = 1
print Rat2_PoolNumsMat

# Plot Pools as Heat Plots
pyplot.imshow(HC_PoolNumsMat, cmap='viridis', interpolation='nearest')
cb = pyplot.colorbar()
cb.set_label('Number of High-Conductance Models (HC = 3)')
pyplot.axis('off')
pyplot.savefig(Case + "_HCPools.png", bbox_inches='tight')
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.imshow(HC_PoolSpikesMat/10, cmap='viridis', interpolation='nearest')
cb = pyplot.colorbar()
cb.set_label('High-Conductance Model Mean Spike Rates (Hz)')
pyplot.axis('off')
pyplot.savefig(Case + "_HCMeanSpikes.png", bbox_inches='tight')
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.imshow(DB_PoolNumsMat, cmap='viridis', interpolation='nearest')
cb = pyplot.colorbar()
cb.set_label('Number of Models Nearing Depolarization Block (HC < 0)')
pyplot.axis('off')
pyplot.savefig(Case + "_DBPools.png", bbox_inches='tight')
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.imshow(NHC_PoolNumsMat, cmap='viridis', interpolation='nearest')
cb = pyplot.colorbar()
cb.set_label('Number of Non-High-Conductance Models (HC = 0)')
pyplot.axis('off')
pyplot.savefig(Case + "_NHCPools.png", bbox_inches='tight')
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.imshow(Rat_PoolNumsMat, cmap='viridis', interpolation='nearest')
cb = pyplot.colorbar()
cb.set_label('Ratio of High-Conductance Models to Depolarization Block Models ')
pyplot.axis('off')
pyplot.savefig(Case + "_HCDBRatioPools.png", bbox_inches='tight')
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.imshow(Rat2_PoolNumsMat, cmap='viridis', interpolation='nearest')
cb = pyplot.colorbar()
cb.set_label('Ratio of Non-High-Conductance Models to High-Conductance Models')
pyplot.axis('off')
pyplot.savefig(Case + "_HCNHCRatioPools.png", bbox_inches='tight')
pyplot.cla()
pyplot.clf()
pyplot.close()

