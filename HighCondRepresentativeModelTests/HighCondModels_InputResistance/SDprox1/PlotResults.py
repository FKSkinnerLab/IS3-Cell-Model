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
numpy.save('NPYfiles/' + Case + '_MeanRiHCModels.npy',MeanRi)
numpy.save('NPYfiles/' + Case + '_StdRiHCModels.npy',StdRi)

f, axarr = matplotlib.pyplot.subplots(1)
ind = numpy.arange(16)
width = 0.4
axarr.bar(ind+width, MeanRi, width, color='k',yerr=StdRi,ecolor='r')
axarr.set_xticks(ind-width+width/2)
axarr.set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
axarr.set_ylabel('Mean Input Resistance (MOhms)')
axarr.set_xlim(-0.2,16+width)
pyplot.savefig('PLOTfiles/' + Case + '_MeanRiHCModels_' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_MeanRiHCModels_' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

numpy.save('NPYfiles/' + Case + '_NoNoisePercentHCs.npy',CumulHCs)

f, axarr = matplotlib.pyplot.subplots(1)
ind = numpy.arange(16)
width = 0.4
axarr.bar(ind+width, (CumulHCs/10)*100, width, color='k')
axarr.set_xticks(ind-width+width/2)
axarr.set_xticklabels((ParamStrs[0],ParamStrs[1],ParamStrs[2],ParamStrs[3],ParamStrs[4],ParamStrs[5],ParamStrs[6],ParamStrs[7],ParamStrs[8],ParamStrs[9],ParamStrs[10],ParamStrs[11],ParamStrs[12],ParamStrs[13],ParamStrs[14],ParamStrs[15]),fontsize = font_size, fontweight='bold', rotation=45)
axarr.set_ylabel('Percent High-Conductance (%)')
axarr.set_xlim(-0.2,16+width)
pyplot.savefig('PLOTfiles/' + Case + '_PercentHC_' + '.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/' + Case + '_PercentHC_' + '.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()