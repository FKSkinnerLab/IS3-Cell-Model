### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D

Case = 'SDprox2_E_COM_I_COM'

execfile("CutSpikes_HighConductanceMeasurements.py")

# HC Treshold Measurement Values
tstop = 10 # seconds
font_size = 6

numpy.save('NPYfiles/' + Case + '_NoNoisePercentHCs.npy',CumulHCs1)
numpy.save('NPYfiles/' + Case + '_NoNoiseMeanVm.npy',MeanVm1)
numpy.save('NPYfiles/' + Case + '_NoNoiseVm_STD.npy',Vm_STD1)
numpy.save('NPYfiles/' + Case + '_NoNoiseISI_cv.npy',ISI_cv1)
numpy.save('NPYfiles/' + Case + '_NoNoiseMean_A.npy',Mean_A1)

numpy.save('NPYfiles/' + Case + '_WithNoisePercentHCs.npy',CumulHCs2)
numpy.save('NPYfiles/' + Case + '_WithNoiseMeanVm.npy',MeanVm2)
numpy.save('NPYfiles/' + Case + '_WithNoiseVm_STD.npy',Vm_STD2)
numpy.save('NPYfiles/' + Case + '_WithNoiseISI_cv.npy',ISI_cv2)
numpy.save('NPYfiles/' + Case + '_WithNoiseMean_A.npy',Mean_A2)

# CumulHCs1 = numpy.load('NPYfiles/' + Case + '_NoNoisePercentHCs.npy')
# MeanVm1 = numpy.load('NPYfiles/' + Case + '_NoNoiseMeanVm.npy')
# Vm_STD1 = numpy.load('NPYfiles/' + Case + '_NoNoiseVm_STD.npy')
# ISI_cv1 = numpy.load('NPYfiles/' + Case + '_NoNoiseISI_cv.npy')
# Mean_A1 = numpy.load('NPYfiles/' + Case + '_NoNoiseMean_A.npy')

# CumulHCs2 = numpy.load('NPYfiles/' + Case + '_WithNoisePercentHCs.npy')
# MeanVm2 = numpy.load('NPYfiles/' + Case + '_WithNoiseMeanVm.npy')
# Vm_STD2 = numpy.load('NPYfiles/' + Case + '_WithNoiseVm_STD.npy')
# ISI_cv2 = numpy.load('NPYfiles/' + Case + '_WithNoiseISI_cv.npy')
# Mean_A2 = numpy.load('NPYfiles/' + Case + '_WithNoiseMean_A.npy')

f, axarr = matplotlib.pyplot.subplots(2)
f.add_subplot(111, frameon=False)
pyplot.tick_params(labelcolor='none', top='off', bottom='off', left='off', right='off')
pyplot.grid(False)
pyplot.ylabel('Percent High-Conductance (%)')
ind = numpy.arange(16)
width = 0.4
axarr[0].bar(ind+width, (CumulHCs1/10)*100, width, color='k')
axarr[1].bar(ind+width, (CumulHCs2/10)*100, width, color='k')
axarr[1].set_xticks(ind-width+width/2)
axarr[1].set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
axarr[0].set_xlim(-0.2,16+width)
axarr[1].set_xlim(-0.2,16+width)
axarr[0].axes.get_xaxis().set_visible(False)
axarr[0].set_title('Intrinsic Noise Off')
axarr[1].set_title('Intrinsic Noise On')
pyplot.savefig('PLOTfiles/' + Case + '_PercentHC' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_PercentHC' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

AvgPot_Thresh = -66.7
StdPot_Thresh = 2.2
ISICV_Thresh = 0.8
AMP_DB_Thresh = 40

f, axarr = matplotlib.pyplot.subplots(2)
f.add_subplot(111, frameon=False)
pyplot.tick_params(labelcolor='none', top='off', bottom='off', left='off', right='off')
pyplot.grid(False)
pyplot.ylabel('Mean Membrane Potential (mV)')
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	xspot = numpy.random.normal(x+0.4, 0.04, size=len(MeanVm1[x]))
	axarr[0].scatter(xspot, MeanVm1[x], color='k',alpha=0.5)
	axarr[1].scatter(xspot, MeanVm2[x], color='k',alpha=0.5)
	axarr[1].set_xticks(ind-width+width/2)
	axarr[1].set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
	axarr[0].set_xlim(-0.2,16+width)
	axarr[1].set_xlim(-0.2,16+width)
	axarr[0].axhline(y=AvgPot_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
	axarr[1].axhline(y=AvgPot_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
	axarr[0].axes.get_xaxis().set_visible(False)
	axarr[0].set_title('Intrinsic Noise Off')
	axarr[1].set_title('Intrinsic Noise On')
pyplot.savefig('PLOTfiles/' + Case + '_MeanVm' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_MeanVm' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

f, axarr = matplotlib.pyplot.subplots(2)
f.add_subplot(111, frameon=False)
pyplot.tick_params(labelcolor='none', top='off', bottom='off', left='off', right='off')
pyplot.grid(False)
pyplot.ylabel('Vm Standard Deviation (mV)')
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	xspot = numpy.random.normal(x+0.4, 0.04, size=len(Vm_STD1[x]))
	axarr[0].scatter(xspot, Vm_STD1[x], color='k',alpha=0.5)
	axarr[1].scatter(xspot, Vm_STD2[x], color='k',alpha=0.5)
	axarr[1].set_xticks(ind-width+width/2)
	axarr[1].set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
	axarr[0].set_xlim(-0.2,16+width)
	axarr[1].set_xlim(-0.2,16+width)
	axarr[0].axhline(y=StdPot_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
	axarr[1].axhline(y=StdPot_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
	axarr[0].axes.get_xaxis().set_visible(False)
	axarr[0].set_title('Intrinsic Noise Off')
	axarr[1].set_title('Intrinsic Noise On')
pyplot.savefig('PLOTfiles/' + Case + '_Vm_STD' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_Vm_STD' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

f, axarr = matplotlib.pyplot.subplots(2)
f.add_subplot(111, frameon=False)
pyplot.tick_params(labelcolor='none', top='off', bottom='off', left='off', right='off')
pyplot.grid(False)
pyplot.ylabel('ISICV')
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	xspot = numpy.random.normal(x+0.4, 0.04, size=len(ISI_cv1[x]))
	axarr[0].scatter(xspot, ISI_cv1[x], color='k',alpha=0.5)
	axarr[1].scatter(xspot, ISI_cv2[x], color='k',alpha=0.5)
	axarr[1].set_xticks(ind-width+width/2)
	axarr[1].set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
	axarr[0].set_xlim(-0.2,16+width)
	axarr[1].set_xlim(-0.2,16+width)
	axarr[0].axhline(y=ISICV_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
	axarr[1].axhline(y=ISICV_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
	axarr[0].axes.get_xaxis().set_visible(False)
	axarr[0].set_title('Intrinsic Noise Off')
	axarr[1].set_title('Intrinsic Noise On')
pyplot.savefig('PLOTfiles/' + Case + '_ISI_cv' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_ISI_cv' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

f, axarr = matplotlib.pyplot.subplots(2)
f.add_subplot(111, frameon=False)
pyplot.tick_params(labelcolor='none', top='off', bottom='off', left='off', right='off')
pyplot.grid(False)
pyplot.ylabel('Mean Spike Amplitude (mV)')
for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	xspot = numpy.random.normal(x+0.4, 0.04, size=len(Mean_A1[x]))
	axarr[0].scatter(xspot, Mean_A1[x], color='k',alpha=0.5)
	axarr[1].scatter(xspot, Mean_A2[x], color='k',alpha=0.5)
	axarr[1].set_xticks(ind-width+width/2)
	axarr[1].set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
	axarr[0].set_xlim(-0.2,16+width)
	axarr[1].set_xlim(-0.2,16+width)
	axarr[0].axhline(y=AMP_DB_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
	axarr[1].axhline(y=AMP_DB_Thresh,xmin=0,xmax=1,color='r',linestyle='--')
	axarr[0].axes.get_xaxis().set_visible(False)
	axarr[0].set_title('Intrinsic Noise Off')
	axarr[1].set_title('Intrinsic Noise On')
pyplot.savefig('PLOTfiles/' + Case + '_Mean_A' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_Mean_A' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

