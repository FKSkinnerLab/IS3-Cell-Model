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
font_size = 6
numpy.save('NPYfiles/' + Case + '_NoNoisePercentHCs.npy',CumulHCs)
numpy.save('NPYfiles/' + Case + '_NoNoiseMeanVm.npy',MeanVm)
numpy.save('NPYfiles/' + Case + '_NoNoiseVm_STD.npy',Vm_STD)
numpy.save('NPYfiles/' + Case + '_NoNoiseISI_cv.npy',ISI_cv)
numpy.save('NPYfiles/' + Case + '_NoNoiseMean_A.npy',Mean_A)

# CumulHCs = numpy.load('NPYfiles/' + Case + '_NoNoisePercentHCs.npy')
# MeanVm = numpy.load('NPYfiles/' + Case + '_NoNoiseMeanVm.npy')
# Vm_STD = numpy.load('NPYfiles/' + Case + '_NoNoiseVm_STD.npy')
# ISI_cv = numpy.load('NPYfiles/' + Case + '_NoNoiseISI_cv.npy')
# Mean_A = numpy.load('NPYfiles/' + Case + '_NoNoiseMean_A.npy')

f, axarr = matplotlib.pyplot.subplots(1)
ind = numpy.arange(16)
width = 0.4
axarr.bar(ind+width, (CumulHCs/10)*100, width, color='k')
axarr.set_xticks(ind-width+width/2)
axarr.set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
axarr.set_ylabel('Percent High-Conductance (%)')
axarr.set_xlim(-0.2,16+width)
pyplot.savefig('PLOTfiles/' + Case + '_PercentHC_NoNoise' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_PercentHC_NoNoise' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

AvgPot_Thresh = -66.7
StdPot_Thresh = 2.2
ISICV_Thresh = 0.8
AMP_DB_Thresh = 40

f, axarr = matplotlib.pyplot.subplots(1)
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	xspot = numpy.random.normal(x+0.4, 0.04, size=len(MeanVm[x]))
	axarr.scatter(xspot, MeanVm[x], color='k',alpha=0.5)
	axarr.set_xticks(ind-width+width/2)
	axarr.set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
	axarr.set_ylabel('Mean Membrane Potential (mV)')
	axarr.set_xlim(-0.2,16+width)
	axarr.axhline(y=AvgPot_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
pyplot.savefig('PLOTfiles/' + Case + '_MeanVm_NoNoise' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_MeanVm_NoNoise' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

f, axarr = matplotlib.pyplot.subplots(1)
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	xspot = numpy.random.normal(x+0.4, 0.04, size=len(Vm_STD[x]))
	axarr.scatter(xspot, Vm_STD[x], color='k',alpha=0.5)
	axarr.set_xticks(ind-width+width/2)
	axarr.set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
	axarr.set_ylabel('Vm Standard Deviation (mV)')
	axarr.set_xlim(-0.2,16+width)
	axarr.axhline(y=StdPot_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
pyplot.savefig('PLOTfiles/' + Case + '_Vm_STD_NoNoise' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_Vm_STD_NoNoise' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

f, axarr = matplotlib.pyplot.subplots(1)
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	xspot = numpy.random.normal(x+0.4, 0.04, size=len(ISI_cv[x]))
	axarr.scatter(xspot, ISI_cv[x], color='k',alpha=0.5)
	axarr.set_xticks(ind-width+width/2)
	axarr.set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
	axarr.set_ylabel('ISICV')
	axarr.set_xlim(-0.2,16+width)
	axarr.axhline(y=ISICV_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
pyplot.savefig('PLOTfiles/' + Case + '_ISI_cv_NoNoise' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_ISI_cv_NoNoise' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

f, axarr = matplotlib.pyplot.subplots(1)
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	xspot = numpy.random.normal(x+0.4, 0.04, size=len(Mean_A[x]))
	axarr.scatter(xspot, Mean_A[x], color='k',alpha=0.5)
	axarr.set_xticks(ind-width+width/2)
	axarr.set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
	axarr.set_ylabel('Mean Spike Amplitude (mV)')
	axarr.set_xlim(-0.2,16+width)
	axarr.axhline(y=AMP_DB_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
pyplot.savefig('PLOTfiles/' + Case + '_Mean_A_NoNoise' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_Mean_A_NoNoise' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

