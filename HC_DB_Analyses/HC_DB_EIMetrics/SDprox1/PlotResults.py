### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
from numpy import inf
from numpy import nan
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
import random
import scipy
from scipy import ndimage
from scipy import stats

Case = 'SDprox1_E_COM_I_COM'

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

# IVL Treshold Measurement Values
tstop = 10 # seconds
font_size = 13

AvgPot_Thresh = -66.7
StdPot_Thresh = 2.2
ISICV_Thresh = 0.8
AMP_DB_Thresh = 40

# Measure IVL Metric In All Models
IVL_MetricVec = numpy.zeros((len(NumInhVec),), dtype=numpy.int)
IVL_MetricVec[MeanVolt >= AvgPot_Thresh] = IVL_MetricVec[MeanVolt >= AvgPot_Thresh] + 1
IVL_MetricVec[StdVolt >= StdPot_Thresh] = IVL_MetricVec[StdVolt >= StdPot_Thresh] + 1
IVL_MetricVec[ISICV >= ISICV_Thresh] = IVL_MetricVec[ISICV >= ISICV_Thresh] + 1
IVL_MetricVec[(MeanAPamp < AMP_DB_Thresh) & (NumSpikes > 0)] = IVL_MetricVec[(MeanAPamp < AMP_DB_Thresh) & (NumSpikes > 0)] - 4

# Measure EI Metrics In All Models
ESpikeRate = ExcSRSpikesVec/tstop
ISpikeRate = InhSpikesVec/tstop
NumExcVec = numpy.array(NumExcVec,dtype=numpy.float64)
NumInhVec = numpy.array(NumInhVec,dtype=numpy.float64)
EI1_MetricVec = (numpy.add(NumExcVec/numpy.amax(NumExcVec),ESpikeRate/numpy.amax(ESpikeRate)) - numpy.add(NumInhVec/numpy.amax(NumInhVec),ISpikeRate/numpy.amax(ISpikeRate)))/2
EI2_MetricVec = ESpikeRate*(NumExcVec) - ISpikeRate*(NumInhVec)

# Move IVL Models To New List
IVL_NumInh = NumInhVec[IVL_MetricVec == 3]
IVL_NumExc = NumExcVec[IVL_MetricVec == 3]
IVL_InhSpikes = InhSpikesVec[IVL_MetricVec == 3]
IVL_ExcSRSpikes = ExcSRSpikesVec[IVL_MetricVec == 3]
IVL_ExcSLMSpikes = ExcSLMSpikesVec[IVL_MetricVec == 3]
IVL_NumExcCommon = NumExcCommonVec[IVL_MetricVec == 3]
IVL_NumInhCommon = NumInhCommonVec[IVL_MetricVec == 3]
IVL_EI1_MetricVec = EI1_MetricVec[IVL_MetricVec == 3]
IVL_EI2_MetricVec = EI2_MetricVec[IVL_MetricVec == 3]

IVL_InhRateVec = IVL_InhSpikes/tstop
IVL_ExcSRRateVec = IVL_ExcSRSpikes/tstop
IVL_ExcSLMRateVec = IVL_ExcSLMSpikes/tstop

IVL_Index = numpy.arange(0,len(IVL_NumInh))
IVL_Index = numpy.random.permutation(IVL_Index)

# Move Depolarization Block Models to New List
DB_NumInh = NumInhVec[IVL_MetricVec < 0]
DB_NumExc = NumExcVec[IVL_MetricVec < 0]
DB_InhSpikes = InhSpikesVec[IVL_MetricVec < 0]
DB_ExcSRSpikes = ExcSRSpikesVec[IVL_MetricVec < 0]
DB_ExcSLMSpikes = ExcSLMSpikesVec[IVL_MetricVec < 0]
DB_NumExcCommon = NumExcCommonVec[IVL_MetricVec < 0]
DB_NumInhCommon = NumInhCommonVec[IVL_MetricVec < 0]
DB_EI1_MetricVec = EI1_MetricVec[IVL_MetricVec < 0]
DB_EI2_MetricVec = EI2_MetricVec[IVL_MetricVec < 0]

DB_InhRateVec = DB_InhSpikes/tstop
DB_ExcSRRateVec = DB_ExcSRSpikes/tstop
DB_ExcSLMRateVec = DB_ExcSLMSpikes/tstop

DB_Index = numpy.arange(0,len(DB_NumInh))
DB_Index = numpy.random.permutation(DB_Index)

# Move Non-High Conductance Models to New List
NIVL_NumInh = NumInhVec[IVL_MetricVec == 0]
NIVL_NumExc = NumExcVec[IVL_MetricVec == 0]
NIVL_InhSpikes = InhSpikesVec[IVL_MetricVec == 0]
NIVL_ExcSRSpikes = ExcSRSpikesVec[IVL_MetricVec == 0]
NIVL_ExcSLMSpikes = ExcSLMSpikesVec[IVL_MetricVec == 0]
NIVL_NumExcCommon = NumExcCommonVec[IVL_MetricVec == 0]
NIVL_NumInhCommon = NumInhCommonVec[IVL_MetricVec == 0]
NIVL_EI1_MetricVec = EI1_MetricVec[IVL_MetricVec == 0]
NIVL_EI2_MetricVec = EI2_MetricVec[IVL_MetricVec == 0]

NIVL_InhRateVec = NIVL_InhSpikes/tstop
NIVL_ExcSRRateVec = NIVL_ExcSRSpikes/tstop
NIVL_ExcSLMRateVec = NIVL_ExcSLMSpikes/tstop

NIVL_Index = numpy.arange(0,len(NIVL_NumInh))
NIVL_Index = numpy.random.permutation(NIVL_Index)

ExcSpikesbins = numpy.linspace(0-(30/6)/2, 30+(30/6)/2, 7+1)
InhSpikesbins = numpy.linspace(0-(100/10)/2, 100+(100/10)/2, 11+1)
ExcNumberbins = numpy.linspace(18-(1530/84)/2, 1530+(1530/84)/2, 85+1)
InhNumberbins = numpy.linspace(4-(344/85)/2, 344+(344/85)/2, 86+1)

pyplot.hist(DB_NumInh, InhNumberbins, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_NumInh, InhNumberbins, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_NumInh, InhNumberbins, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper center')
# pyplot.xlim(0,344)
pyplot.xlabel("Number of Inhibitory Synapses", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_NumInhHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_NumExc, ExcNumberbins, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_NumExc, ExcNumberbins, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_NumExc, ExcNumberbins, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper center')
# pyplot.xlim(0,1530)
pyplot.xlabel("Number of Excitatory Synapses", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_NumExcHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_InhRateVec, InhSpikesbins, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_InhRateVec, InhSpikesbins, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_InhRateVec, InhSpikesbins, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper center')
# pyplot.xlim(0,100)
pyplot.xlabel("Inhibitory Spike Rate (Hz)", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_InhRateHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_ExcSRRateVec, ExcSpikesbins, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_ExcSRRateVec, ExcSpikesbins, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_ExcSRRateVec, ExcSpikesbins, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper center')
# pyplot.xlim(0,30)
pyplot.xlabel("Excitatory Spike Rate (Hz)", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_ExcRateHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_EI1_MetricVec, 100, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_EI1_MetricVec, 100, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_EI1_MetricVec, 100, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper right')
pyplot.xlim(-1,1)
pyplot.xlabel("EI Metric #1", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_EI1MetricHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_EI2_MetricVec, 100, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_EI2_MetricVec, 100, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_EI2_MetricVec, 100, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper right')
pyplot.xlim(-50000,50000)
pyplot.xlabel("EI Metric #2", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_EI2MetricHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(IVL_EI1_MetricVec, 100, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper right')
pyplot.xlim(numpy.amin(IVL_EI1_MetricVec),-numpy.amin(IVL_EI1_MetricVec))
pyplot.xlabel("EI Metric #1", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_EI1MetricHist_IVLOnly.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(IVL_EI2_MetricVec, 100, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper right')
pyplot.xlim(numpy.amin(IVL_EI2_MetricVec),-numpy.amin(IVL_EI2_MetricVec))
pyplot.xlabel("EI Metric #2", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_EI2MetricHist_IVLOnly.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

# Divide IVL models into pools & print numbers
execfile("PoolDivide.py")
print '-------------------------------------------------'
print '-------------In Vivo-Like Pools--------------'
print '-------------------------------------------------'
print 'Number Of High Conductance Models (IVL Metric = 3) For Case ' + Case + ' = ' + str(len(IVL_Index))
IVL_PoolStrings_IVL_PoolNums = PoolDivide(IVL_NumInh,IVL_NumExc,IVL_InhSpikes,IVL_ExcSRSpikes,"IVL",IVL_EI1_MetricVec,IVL_EI2_MetricVec)
IVL_PoolStrings = IVL_PoolStrings_IVL_PoolNums[0]
IVL_PoolNums = IVL_PoolStrings_IVL_PoolNums[1]

IVL_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.int)

IVL_PoolNumsMat[0][0] = IVL_PoolNums[10]
IVL_PoolNumsMat[0][1] = IVL_PoolNums[14]
IVL_PoolNumsMat[0][2] = IVL_PoolNums[11]
IVL_PoolNumsMat[0][3] = IVL_PoolNums[15]

IVL_PoolNumsMat[1][0] = IVL_PoolNums[2]
IVL_PoolNumsMat[1][1] = IVL_PoolNums[6]
IVL_PoolNumsMat[1][2] = IVL_PoolNums[3]
IVL_PoolNumsMat[1][3] = IVL_PoolNums[7]

IVL_PoolNumsMat[2][0] = IVL_PoolNums[8]
IVL_PoolNumsMat[2][1] = IVL_PoolNums[12]
IVL_PoolNumsMat[2][2] = IVL_PoolNums[9]
IVL_PoolNumsMat[2][3] = IVL_PoolNums[13]

IVL_PoolNumsMat[3][0] = IVL_PoolNums[0]
IVL_PoolNumsMat[3][1] = IVL_PoolNums[4]
IVL_PoolNumsMat[3][2] = IVL_PoolNums[1]
IVL_PoolNumsMat[3][3] = IVL_PoolNums[5]

# Plot Parameter Histograms
ExcSpikesbins = numpy.linspace(0-(30/6)/2, 30+(30/6)/2, 7+1)
InhSpikesbins = numpy.linspace(0-(100/10)/2, 100+(100/10)/2, 11+1)
ExcNumberbins = numpy.linspace(18-(1530/84)/2, 1530+(1530/84)/2, 85+1)
InhNumberbins = numpy.linspace(4-(344/85)/2, 344+(344/85)/2, 86+1)

bin_number = 50

for x in range(2,18):
	EI1MetricVec = numpy.zeros(len(IVL_PoolStrings_IVL_PoolNums[x]), dtype = numpy.float64)
	for y in range(len(IVL_PoolStrings_IVL_PoolNums[x])):
		EI1MetricVec[y] = IVL_PoolStrings_IVL_PoolNums[x][y][4]    
	pyplot.hist(EI1MetricVec, bin_number, alpha=0.5, label=IVL_PoolStrings[x-2])
pyplot.legend(loc='upper right')
pyplot.xlim(-1,1)
pyplot.xlabel("EI Metric #1", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_IVLEI1MetricPoolHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

for x in range(2,18):
	EI2MetricVec = numpy.zeros(len(IVL_PoolStrings_IVL_PoolNums[x]), dtype = numpy.int)
	for y in range(len(IVL_PoolStrings_IVL_PoolNums[x])):
		EI2MetricVec[y] = IVL_PoolStrings_IVL_PoolNums[x][y][5]
	pyplot.hist(EI2MetricVec, bin_number, alpha=0.5, label=IVL_PoolStrings[x-2])
pyplot.legend(loc='upper right')
pyplot.xlim(-50000,50000)
pyplot.xlabel("EI Metric #2", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_IVLEI2MetricPoolHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

for x in range(2,18):
	EI2MetricVec = numpy.zeros(len(IVL_PoolStrings_IVL_PoolNums[x]), dtype = numpy.int)
	for y in range(len(IVL_PoolStrings_IVL_PoolNums[x])):
		EI2MetricVec[y] = IVL_PoolStrings_IVL_PoolNums[x][y][5]
	pyplot.hist(EI2MetricVec, bin_number, alpha=0.5, label=IVL_PoolStrings[x-2])
pyplot.legend(loc='upper right')
pyplot.xlim(numpy.amin(EI2MetricVec),-numpy.amin(EI2MetricVec))
pyplot.xlabel("EI Metric #2", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_IVLEI2MetricPoolHist_Zoomed.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

EI1MetricVec = numpy.zeros(len(IVL_PoolStrings_IVL_PoolNums[2]), dtype = numpy.float64)
for y in range(len(IVL_PoolStrings_IVL_PoolNums[2])):
	EI1MetricVec[y] = IVL_PoolStrings_IVL_PoolNums[2][y][4]
pyplot.hist(EI1MetricVec, bin_number, alpha=0.5, label=IVL_PoolStrings[0])
pyplot.legend(loc='upper right')
pyplot.xlim(numpy.amin(EI1MetricVec),-numpy.amin(EI1MetricVec))
pyplot.xlabel("EI Metric #1", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_IVLEI1MetricPoolHist_LNI_LNE_LIS_LES.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

EI2MetricVec = numpy.zeros(len(IVL_PoolStrings_IVL_PoolNums[2]), dtype = numpy.int)
for y in range(len(IVL_PoolStrings_IVL_PoolNums[2])):
	EI2MetricVec[y] = IVL_PoolStrings_IVL_PoolNums[2][y][5]
pyplot.hist(EI2MetricVec, bin_number, alpha=0.5, label=IVL_PoolStrings[0])
pyplot.legend(loc='upper right')
pyplot.xlim(numpy.amin(EI2MetricVec),-numpy.amin(EI2MetricVec))
pyplot.xlabel("EI Metric #2", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_IVLEI2MetricPoolHist_LNI_LNE_LIS_LES.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

print IVL_PoolNumsMat

print '-------------------------------------------------'
print '-----------Depolarization Block Pools------------'
print '-------------------------------------------------'
print 'Number Of Depolarization Block Models (IVL Metric < 0) For Case ' + Case + ' = ' + str(len(DB_Index))
DB_PoolStrings_DB_PoolNums = PoolDivide(DB_NumInh,DB_NumExc,DB_InhSpikes,DB_ExcSRSpikes,"DB",DB_EI1_MetricVec,DB_EI2_MetricVec)
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

# Plot Parameter Histograms
ExcSpikesbins = numpy.linspace(0-(30/6)/2, 30+(30/6)/2, 7+1)
InhSpikesbins = numpy.linspace(0-(100/10)/2, 100+(100/10)/2, 11+1)
ExcNumberbins = numpy.linspace(18-(1530/84)/2, 1530+(1530/84)/2, 85+1)
InhNumberbins = numpy.linspace(4-(344/85)/2, 344+(344/85)/2, 86+1)

for x in range(2,18):
	EI1MetricVec = numpy.zeros(len(DB_PoolStrings_DB_PoolNums[x]), dtype = numpy.float64)
	for y in range(len(DB_PoolStrings_DB_PoolNums[x])):
		EI1MetricVec[y] = DB_PoolStrings_DB_PoolNums[x][y][4]    
	pyplot.hist(EI1MetricVec, bin_number, alpha=0.5, label=DB_PoolStrings[x-2])
pyplot.legend(loc='upper left')
pyplot.xlim(-1,1)
pyplot.xlabel("EI Metric #1", fontsize=font_size)
pyplot.ylabel("DB Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_DBEI1MetricPoolHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

for x in range(2,18):
	EI2MetricVec = numpy.zeros(len(DB_PoolStrings_DB_PoolNums[x]), dtype = numpy.int)
	for y in range(len(DB_PoolStrings_DB_PoolNums[x])):
		EI2MetricVec[y] = DB_PoolStrings_DB_PoolNums[x][y][5]
	pyplot.hist(EI2MetricVec, bin_number, alpha=0.5, label=DB_PoolStrings[x-2])
pyplot.legend(loc='upper left')
pyplot.xlim(-50000,50000)
pyplot.xlabel("EI Metric #2", fontsize=font_size)
pyplot.ylabel("DB Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_DBEI2MetricPoolHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

print DB_PoolNumsMat

print '-------------------------------------------------'
print '-----------Non-In Vivo-Like Pools------------'
print '-------------------------------------------------'
print 'Number Of Non-High Conductance Models (IVL Metric = 0) For Case ' + Case + ' = ' + str(len(NIVL_Index))
NIVL_PoolStrings_NIVL_PoolNums = PoolDivide(NIVL_NumInh,NIVL_NumExc,NIVL_InhSpikes,NIVL_ExcSRSpikes,"NIVL",NIVL_EI1_MetricVec,NIVL_EI2_MetricVec)
NIVL_PoolStrings = NIVL_PoolStrings_NIVL_PoolNums[0]
NIVL_PoolNums = NIVL_PoolStrings_NIVL_PoolNums[1]

NIVL_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.int)

NIVL_PoolNumsMat[0][0] = NIVL_PoolNums[10]
NIVL_PoolNumsMat[0][1] = NIVL_PoolNums[14]
NIVL_PoolNumsMat[0][2] = NIVL_PoolNums[11]
NIVL_PoolNumsMat[0][3] = NIVL_PoolNums[15]

NIVL_PoolNumsMat[1][0] = NIVL_PoolNums[2]
NIVL_PoolNumsMat[1][1] = NIVL_PoolNums[6]
NIVL_PoolNumsMat[1][2] = NIVL_PoolNums[3]
NIVL_PoolNumsMat[1][3] = NIVL_PoolNums[7]

NIVL_PoolNumsMat[2][0] = NIVL_PoolNums[8]
NIVL_PoolNumsMat[2][1] = NIVL_PoolNums[12]
NIVL_PoolNumsMat[2][2] = NIVL_PoolNums[9]
NIVL_PoolNumsMat[2][3] = NIVL_PoolNums[13]

NIVL_PoolNumsMat[3][0] = NIVL_PoolNums[0]
NIVL_PoolNumsMat[3][1] = NIVL_PoolNums[4]
NIVL_PoolNumsMat[3][2] = NIVL_PoolNums[1]
NIVL_PoolNumsMat[3][3] = NIVL_PoolNums[5]

# Plot Parameter Histograms
ExcSpikesbins = numpy.linspace(0-(30/6)/2, 30+(30/6)/2, 7+1)
InhSpikesbins = numpy.linspace(0-(100/10)/2, 100+(100/10)/2, 11+1)
ExcNumberbins = numpy.linspace(18-(1530/84)/2, 1530+(1530/84)/2, 85+1)
InhNumberbins = numpy.linspace(4-(344/85)/2, 344+(344/85)/2, 86+1)

for x in range(2,18):
	EI1MetricVec = numpy.zeros(len(NIVL_PoolStrings_NIVL_PoolNums[x]), dtype = numpy.float64)
	for y in range(len(NIVL_PoolStrings_NIVL_PoolNums[x])):
		EI1MetricVec[y] = NIVL_PoolStrings_NIVL_PoolNums[x][y][4]
	pyplot.hist(EI1MetricVec, bin_number, alpha=0.5, label=NIVL_PoolStrings[x-2])
pyplot.legend(loc='upper right')
pyplot.xlim(-1,1)
pyplot.xlabel("EI Metric #1", fontsize=font_size)
pyplot.ylabel("NIVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_NIVLEI1MetricPoolHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

for x in range(2,18):
	EI2MetricVec = numpy.zeros(len(NIVL_PoolStrings_NIVL_PoolNums[x]), dtype = numpy.int)
	for y in range(len(NIVL_PoolStrings_NIVL_PoolNums[x])):
		EI2MetricVec[y] = NIVL_PoolStrings_NIVL_PoolNums[x][y][5]
	pyplot.hist(EI2MetricVec, bin_number, alpha=0.5, label=NIVL_PoolStrings[x-2])
pyplot.legend(loc='upper right')
pyplot.xlim(-50000,50000)
pyplot.xlabel("EI Metric #2", fontsize=font_size)
pyplot.ylabel("NIVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_NIVLEI2MetricPoolHist.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

print NIVL_PoolNumsMat

# In Vivo-Like to Depolarization Block Ratios
IVLDBRatios = (IVL_PoolNums+1)/(DB_PoolNums+1)
Rat_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.float)

Rat_PoolNumsMat[0][0] = IVLDBRatios[10]
Rat_PoolNumsMat[0][1] = IVLDBRatios[14]
Rat_PoolNumsMat[0][2] = IVLDBRatios[11]
Rat_PoolNumsMat[0][3] = IVLDBRatios[15]

Rat_PoolNumsMat[1][0] = IVLDBRatios[2]
Rat_PoolNumsMat[1][1] = IVLDBRatios[6]
Rat_PoolNumsMat[1][2] = IVLDBRatios[3]
Rat_PoolNumsMat[1][3] = IVLDBRatios[7]

Rat_PoolNumsMat[2][0] = IVLDBRatios[8]
Rat_PoolNumsMat[2][1] = IVLDBRatios[12]
Rat_PoolNumsMat[2][2] = IVLDBRatios[9]
Rat_PoolNumsMat[2][3] = IVLDBRatios[13]

Rat_PoolNumsMat[3][0] = IVLDBRatios[0]
Rat_PoolNumsMat[3][1] = IVLDBRatios[4]
Rat_PoolNumsMat[3][2] = IVLDBRatios[1]
Rat_PoolNumsMat[3][3] = IVLDBRatios[5]

Rat_PoolNumsMat[Rat_PoolNumsMat == 1] = 0.5
Rat_PoolNumsMat[Rat_PoolNumsMat < 1] = 0
Rat_PoolNumsMat[Rat_PoolNumsMat > 1] = 1
print Rat_PoolNumsMat

# In Vivo-Like to Non-High Conductance Ratios
IVLNIVLRatios = (NIVL_PoolNums+1)/(IVL_PoolNums+1)
Rat2_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.float)

Rat2_PoolNumsMat[0][0] = IVLNIVLRatios[10]
Rat2_PoolNumsMat[0][1] = IVLNIVLRatios[14]
Rat2_PoolNumsMat[0][2] = IVLNIVLRatios[11]
Rat2_PoolNumsMat[0][3] = IVLNIVLRatios[15]

Rat2_PoolNumsMat[1][0] = IVLNIVLRatios[2]
Rat2_PoolNumsMat[1][1] = IVLNIVLRatios[12]
Rat2_PoolNumsMat[1][2] = IVLNIVLRatios[9]
Rat2_PoolNumsMat[1][3] = IVLNIVLRatios[13]

Rat2_PoolNumsMat[2][0] = IVLNIVLRatios[8]
Rat2_PoolNumsMat[2][1] = IVLNIVLRatios[12]
Rat2_PoolNumsMat[2][2] = IVLNIVLRatios[9]
Rat2_PoolNumsMat[2][3] = IVLNIVLRatios[13]

Rat2_PoolNumsMat[3][0] = IVLNIVLRatios[0]
Rat2_PoolNumsMat[3][1] = IVLNIVLRatios[4]
Rat2_PoolNumsMat[3][2] = IVLNIVLRatios[1]
Rat2_PoolNumsMat[3][3] = IVLNIVLRatios[5]

Rat2_PoolNumsMat[Rat2_PoolNumsMat == 1] = 0.5
Rat2_PoolNumsMat[Rat2_PoolNumsMat < 1] = 0
Rat2_PoolNumsMat[Rat2_PoolNumsMat > 1] = 1
print Rat2_PoolNumsMat

print '---------------------------------------------------'
print '-----------Non-In Vivo-Like Pools 2------------'
print '---------------------------------------------------'
NIVL_NumInh = NumInhVec[(IVL_MetricVec > -1) & (IVL_MetricVec < 3)]
NIVL_NumExc = NumExcVec[(IVL_MetricVec > -1) & (IVL_MetricVec < 3)]
NIVL_InhSpikes = InhSpikesVec[(IVL_MetricVec > -1) & (IVL_MetricVec < 3)]
NIVL_ExcSRSpikes = ExcSRSpikesVec[(IVL_MetricVec > -1) & (IVL_MetricVec < 3)]
NIVL_ExcSLMSpikes = ExcSLMSpikesVec[(IVL_MetricVec > -1) & (IVL_MetricVec < 3)]
NIVL_NumExcCommon = NumExcCommonVec[(IVL_MetricVec > -1) & (IVL_MetricVec < 3)]
NIVL_NumInhCommon = NumInhCommonVec[(IVL_MetricVec > -1) & (IVL_MetricVec < 3)]
NIVL_EI1_MetricVec = EI1_MetricVec[(IVL_MetricVec > -1) & (IVL_MetricVec < 3)]
NIVL_EI2_MetricVec = EI2_MetricVec[(IVL_MetricVec > -1) & (IVL_MetricVec < 3)]

NIVL_InhRateVec = NIVL_InhSpikes/tstop
NIVL_ExcSRRateVec = NIVL_ExcSRSpikes/tstop
NIVL_ExcSLMRateVec = NIVL_ExcSLMSpikes/tstop

NIVL_Index = numpy.arange(0,len(NIVL_NumInh))
NIVL_Index = numpy.random.permutation(NIVL_Index)

pyplot.hist(DB_NumInh, InhNumberbins, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_NumInh, InhNumberbins, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_NumInh, InhNumberbins, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper center')
# pyplot.xlim(0,344)
pyplot.xlabel("Number of Inhibitory Synapses", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_NumInhHist_NIVL2.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_NumExc, ExcNumberbins, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_NumExc, ExcNumberbins, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_NumExc, ExcNumberbins, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper center')
# pyplot.xlim(0,1530)
pyplot.xlabel("Number of Excitatory Synapses", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_NumExcHist_NIVL2.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_InhRateVec, InhSpikesbins, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_InhRateVec, InhSpikesbins, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_InhRateVec, InhSpikesbins, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper center')
# pyplot.xlim(0,100)
pyplot.xlabel("Inhibitory Spike Rate (Hz)", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_InhRateHist_NIVL2.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_ExcSRRateVec, ExcSpikesbins, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_ExcSRRateVec, ExcSpikesbins, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_ExcSRRateVec, ExcSpikesbins, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper center')
# pyplot.xlim(0,30)
pyplot.xlabel("Excitatory Spike Rate (Hz)", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_ExcRateHist_NIVL2.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_EI1_MetricVec, 100, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_EI1_MetricVec, 100, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_EI1_MetricVec, 100, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper right')
pyplot.xlim(-1,1)
pyplot.xlabel("EI Metric #1", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_EI1MetricHist_NIVL2.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

pyplot.hist(DB_EI2_MetricVec, 100, alpha=0.5, label='Depolarization Block')
pyplot.hist(NIVL_EI2_MetricVec, 100, alpha=0.5, label='Non-In Vivo-Like')
pyplot.hist(IVL_EI2_MetricVec, 100, alpha=0.5, label='In Vivo-Like')
pyplot.legend(loc='upper right')
pyplot.xlim(-50000,50000)
pyplot.xlabel("EI Metric #2", fontsize=font_size)
pyplot.ylabel("IVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_EI2MetricHist_NIVL2.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

print 'Number Of Non-High Conductance Models (IVL Metric = 0 - 2) For Case ' + Case + ' = ' + str(len(NIVL_Index))
NIVL_PoolStrings_NIVL_PoolNums = PoolDivide(NIVL_NumInh,NIVL_NumExc,NIVL_InhSpikes,NIVL_ExcSRSpikes,"NIVL",NIVL_EI1_MetricVec,NIVL_EI2_MetricVec)
NIVL_PoolStrings = NIVL_PoolStrings_NIVL_PoolNums[0]
NIVL_PoolNums = NIVL_PoolStrings_NIVL_PoolNums[1]

NIVL_PoolNumsMat = numpy.zeros((4,4), dtype=numpy.int)

NIVL_PoolNumsMat[0][0] = NIVL_PoolNums[10]
NIVL_PoolNumsMat[0][1] = NIVL_PoolNums[14]
NIVL_PoolNumsMat[0][2] = NIVL_PoolNums[11]
NIVL_PoolNumsMat[0][3] = NIVL_PoolNums[15]

NIVL_PoolNumsMat[1][0] = NIVL_PoolNums[2]
NIVL_PoolNumsMat[1][1] = NIVL_PoolNums[6]
NIVL_PoolNumsMat[1][2] = NIVL_PoolNums[3]
NIVL_PoolNumsMat[1][3] = NIVL_PoolNums[7]

NIVL_PoolNumsMat[2][0] = NIVL_PoolNums[8]
NIVL_PoolNumsMat[2][1] = NIVL_PoolNums[12]
NIVL_PoolNumsMat[2][2] = NIVL_PoolNums[9]
NIVL_PoolNumsMat[2][3] = NIVL_PoolNums[13]

NIVL_PoolNumsMat[3][0] = NIVL_PoolNums[0]
NIVL_PoolNumsMat[3][1] = NIVL_PoolNums[4]
NIVL_PoolNumsMat[3][2] = NIVL_PoolNums[1]
NIVL_PoolNumsMat[3][3] = NIVL_PoolNums[5]

# Plot Parameter Histograms
ExcSpikesbins = numpy.linspace(0-(30/6)/2, 30+(30/6)/2, 7+1)
InhSpikesbins = numpy.linspace(0-(100/10)/2, 100+(100/10)/2, 11+1)
ExcNumberbins = numpy.linspace(18-(1530/84)/2, 1530+(1530/84)/2, 85+1)
InhNumberbins = numpy.linspace(4-(344/85)/2, 344+(344/85)/2, 86+1)

for x in range(2,18):
	EI1MetricVec = numpy.zeros(len(NIVL_PoolStrings_NIVL_PoolNums[x]), dtype = numpy.float64)
	for y in range(len(NIVL_PoolStrings_NIVL_PoolNums[x])):
		EI1MetricVec[y] = NIVL_PoolStrings_NIVL_PoolNums[x][y][4]
	pyplot.hist(EI1MetricVec, bin_number, alpha=0.5, label=NIVL_PoolStrings[x-2])
pyplot.legend(loc='upper right')
pyplot.xlim(-1,1)
pyplot.xlabel("EI Metric #1", fontsize=font_size)
pyplot.ylabel("NIVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_NIVLEI1MetricPoolHist_NIVL2.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

for x in range(2,18):
	EI2MetricVec = numpy.zeros(len(NIVL_PoolStrings_NIVL_PoolNums[x]), dtype = numpy.int)
	for y in range(len(NIVL_PoolStrings_NIVL_PoolNums[x])):
		EI2MetricVec[y] = NIVL_PoolStrings_NIVL_PoolNums[x][y][5]
	pyplot.hist(EI2MetricVec, bin_number, alpha=0.5, label=NIVL_PoolStrings[x-2])
pyplot.legend(loc='upper right')
pyplot.xlim(-50000,50000)
pyplot.xlabel("EI Metric #2", fontsize=font_size)
pyplot.ylabel("NIVL Scenario Count", fontsize=font_size)
pyplot.savefig(Case + "_NIVLEI2MetricPoolHist_NIVL2.png", bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

print NIVL_PoolNumsMat
