### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
import scipy
from scipy import signal
from scipy import stats
from scipy.stats import rayleigh

ThetaDegrees = numpy.array([333.6585, 286.3158, 31.7956, 90, 317.362, 30.6441, 300.4724, 128.0632, 122.1429, 117.3264, 337.2332, 11.9008, 314.8289, 29.5522, 271.3433, 150, 237.913, 253.0286, 210.6667, 43.0189, 61.3333, 248.8889, 335.122, 66.755, 64, 45.5422, 262.9352, 354.7445])
ThetaRads = ThetaDegrees*(numpy.pi/180)
ThetaAmps = numpy.array([27.3, 57.9, 22.8, 21.8, 22.4, 42, 50, 49.3, 57.3, 33, 77, 103, 164, 28, 92, 39, 52, 26, 42, 32.5, 32, 41.5, 13, 21, 20, 35, 18, 17])

numpy.save('NPYfiles/ThetaDegrees.npy',ThetaRads)
numpy.save('NPYfiles/ThetaRads.npy',ThetaRads)
numpy.save('NPYfiles/ThetaAmps.npy',ThetaAmps)

ThetaRads_Sorted = sorted(ThetaRads)
ThetaAmps_Sorted = [x for i, x in sorted(zip(ThetaRads,ThetaAmps))]

# Polar Distribution Plots
bin_size = 24 # Ensures bins of 15 degrees
range_rads = (0,2*numpy.pi)

heights11,be11 = numpy.histogram(ThetaRads_Sorted,bins=bin_size,range=range_rads)

ThetaRads_MeanBins,be11,bn11 = scipy.stats.binned_statistic(ThetaRads_Sorted,ThetaRads_Sorted,statistic='mean',bins=bin_size,range=range_rads)
_BMeans = ThetaRads_MeanBins
ThetaRads_MeanBins = ThetaRads_MeanBins[~numpy.isnan(ThetaRads_MeanBins)]
ThetaRads_MeanBins = numpy.append(ThetaRads_MeanBins,ThetaRads_MeanBins[0])

ThetaAmps_MeanBins,be12,bn12 = scipy.stats.binned_statistic(ThetaRads_Sorted,ThetaAmps_Sorted,statistic='mean',bins=bin_size,range=range_rads)
ThetaAmps_MeanBins = ThetaAmps_MeanBins[~numpy.isnan(_BMeans)]
ThetaAmps_MeanBins = numpy.append(ThetaAmps_MeanBins,ThetaAmps_MeanBins[0])

ThetaAmps_MinsBins,be111,bn111 = scipy.stats.binned_statistic(ThetaRads_Sorted,ThetaAmps_Sorted,statistic='min',bins=bin_size,range=range_rads)
ThetaAmps_MinsBins = ThetaAmps_MinsBins[~numpy.isnan(_BMeans)]
ThetaAmps_MinsBins = numpy.append(ThetaAmps_MinsBins,ThetaAmps_MinsBins[0])

ThetaAmps_MaxBins,be111,bn111 = scipy.stats.binned_statistic(ThetaRads_Sorted,ThetaAmps_Sorted,statistic='max',bins=bin_size,range=range_rads)
ThetaAmps_MaxBins = ThetaAmps_MaxBins[~numpy.isnan(_BMeans)]
ThetaAmps_MaxBins = numpy.append(ThetaAmps_MaxBins,ThetaAmps_MaxBins[0])

ThetaAmps_StdBins,be111,bn111 = scipy.stats.binned_statistic(ThetaRads_Sorted,ThetaAmps_Sorted,statistic='std',bins=bin_size,range=range_rads)
ThetaAmps_StdBins = ThetaAmps_StdBins[~numpy.isnan(_BMeans)]
ThetaAmps_StdBins = numpy.append(ThetaAmps_StdBins,ThetaAmps_StdBins[0])

axarr = pyplot.subplot(111, projection='polar')
axarr.plot(ThetaRads_MeanBins,ThetaAmps_MeanBins,'b',label='Baseline')
axarr.fill_between(ThetaRads_MeanBins,numpy.clip(ThetaAmps_MeanBins-ThetaAmps_StdBins,0,1000),numpy.clip(ThetaAmps_MeanBins+ThetaAmps_StdBins,0,1000),alpha=0.5, edgecolor='b', facecolor='b')
position = 100
bottom = numpy.amax(numpy.clip(ThetaAmps_MeanBins+ThetaAmps_StdBins,0,1000))+5
width = range_rads[1]/(bin_size+1)
axarr.bar(_BMeans, heights11, width=width, bottom=bottom,color='b')
axarr._r_label_position._t = (position, 0)
axarr._r_label_position.invalidate()
axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
pyplot.tight_layout()
pyplot.savefig('PLOTfiles/PolarPlotBinnedAndAmplitudesWithSTD.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/PolarPlotBinnedAndAmplitudesWithSTD.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

axarr = pyplot.subplot(111, projection='polar')
axarr.plot(ThetaRads_MeanBins,ThetaAmps_MeanBins,'b',label='Baseline')
# axarr.fill_between(ThetaRads_MeanBins,numpy.clip(ThetaAmps_MeanBins-ThetaAmps_StdBins,0,1000),numpy.clip(ThetaAmps_MeanBins+ThetaAmps_StdBins,0,1000),alpha=0.5, edgecolor='b', facecolor='b')
position = 100
# bottom = numpy.amax(numpy.clip(ThetaAmps_MeanBins+ThetaAmps_StdBins,0,1000))+5
bottom = numpy.amax(numpy.clip(ThetaAmps_MeanBins,0,1000))+5
width = range_rads[1]/(bin_size+1)
axarr.bar(_BMeans, heights11, width=width, bottom=bottom,color='b')
axarr._r_label_position._t = (position, 0)
axarr._r_label_position.invalidate()
axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
pyplot.tight_layout()
pyplot.savefig('PLOTfiles/PolarPlotBinnedAndAmplitudes.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/PolarPlotBinnedAndAmplitudes.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

axarr = pyplot.subplot(111, projection='polar')
axarr.bar(_BMeans, heights11, width=width,color='b')
axarr.set_xticklabels(['0$^\circ$', '45$^\circ$', '90$^\circ$\nPeak', '135$^\circ$', '180$^\circ$', '225$^\circ$', '270$^\circ$\nTrough', '315$^\circ$'])
position = 100
axarr._r_label_position._t = (position, 0)
axarr._r_label_position.invalidate()
axarr.set_rticks([1, 2, 3])
pyplot.tight_layout()
pyplot.savefig('PLOTfiles/PolarPlotBinned.pdf', bbox_inches='tight')
pyplot.savefig('PLOTfiles/PolarPlotBinned.png', bbox_inches='tight')
pyplot.gcf().clear()
pyplot.cla()
pyplot.clf()
pyplot.close()

# Rayleigh Test
# ThetaTimes = ThetaDegrees*(0.125/360) # Converts to seconds
# freq8Hz = 8
#
# n = len(ThetaTimes)
# theta = 2. * numpy.pi * freq8Hz * ThetaTimes
#
# z = 1. / n * (( numpy.sum(numpy.sin(theta))**2 + numpy.sum(numpy.cos(theta))**2 ))
# print z
#
# # Evaluate at linearly spaced frequencies
# minfreq = 0
# maxfreq = 1/0.125
# nper = 1
# freqs = numpy.linspace(minfreq, maxfreq, num=nper)
# z2 = map(lambda freq8Hz: z, freqs)
# print z2
# pyplot.figure()
# pyplot.plot(freqs, z2)
# pyplot.xlabel('Period (s)')
# pyplot.ylabel('Rayleigh power (z)')
# pyplot.tight_layout()
# pyplot.savefig('PLOTfiles/RayleighSpectrum.pdf', bbox_inches='tight')
# pyplot.savefig('PLOTfiles/RayleighSpectrum.png', bbox_inches='tight')
# pyplot.gcf().clear()
# pyplot.cla()
# pyplot.clf()
# pyplot.close()

