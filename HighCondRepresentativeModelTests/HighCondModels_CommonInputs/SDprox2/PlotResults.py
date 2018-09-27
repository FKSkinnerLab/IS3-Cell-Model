### Test Script for a file found in the SDprox2 results from initial Parallel Simulations
from __future__ import division
import numpy
import matplotlib
from matplotlib import pyplot

Case = 'SDprox2_E_COM_I_COM'

execfile("CutSpikes_HighConductanceMeasurements.py")

# HC Treshold Measurement Values
tstop = 10 # seconds
font_size = 6
numpy.save('NPYfiles/' + Case + '_HCMetrics.npy',HCMetrics)
numpy.save('NPYfiles/' + Case + '_SpikeRateIndex.npy',SpikeRateIndex)
numpy.save('NPYfiles/' + Case + '_MeanVoltIndex.npy',MeanVoltIndex)
numpy.save('NPYfiles/' + Case + '_StdVoltIndex.npy',StdVoltIndex)
numpy.save('NPYfiles/' + Case + '_ISICVIndex.npy',ISICVIndex)

# Plot HC Metrics for each representative model
excnum_Mesh = numpy.zeros((10,10), dtype=numpy.float64)
inhnum_Mesh = numpy.zeros((10,10), dtype=numpy.float64)
for ExcNumCommon in range(1,11):
	for InhNumCommon in range(1,11):
		excnum_Mesh[ExcNumCommon-1][InhNumCommon-1] = ExcNumCommon
		inhnum_Mesh[ExcNumCommon-1][InhNumCommon-1] = InhNumCommon

for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	numinh = ParamNums[0][x]
	numexc = ParamNums[1][x]
	inhspikes = ParamNums[2][x]
	excspikes = ParamNums[3][x]
	
	fig = pyplot.figure()
	ax = fig.gca()
	
	HCMetrics_Mesh = HCMetrics[x]
	
	surf = pyplot.imshow(numpy.transpose(HCMetrics_Mesh), interpolation='nearest', origin='lower', extent=[excnum_Mesh.min()-0.5, excnum_Mesh.max()+0.5, inhnum_Mesh.min()-0.5, inhnum_Mesh.max()+0.5])
	
	# Add a color bar which maps values to colors.
	cb = fig.colorbar(surf, shrink=0.5, aspect=5)
	cb.set_label('HC Metric')
	ax.set_xlabel('Number of Common Excitatory')
	ax.set_ylabel('Number of Common Inhibitory')
	
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_HCMetric' + '.pdf', bbox_inches='tight')
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_HCMetric' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()

for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	numinh = ParamNums[0][x]
	numexc = ParamNums[1][x]
	inhspikes = ParamNums[2][x]
	excspikes = ParamNums[3][x]
	
	fig = pyplot.figure()
	ax = fig.gca()
	
	SpikeRateIndex_Mesh = SpikeRateIndex[x]
	
	surf = pyplot.imshow(numpy.transpose(SpikeRateIndex_Mesh), interpolation='nearest', origin='lower', extent=[excnum_Mesh.min()-0.5, excnum_Mesh.max()+0.5, inhnum_Mesh.min()-0.5, inhnum_Mesh.max()+0.5])
	
	# Add a color bar which maps values to colors.
	cb = fig.colorbar(surf, shrink=0.5, aspect=5)
	cb.set_label('Spike Rate (Hz)')
	ax.set_xlabel('Number of Common Excitatory')
	ax.set_ylabel('Number of Common Inhibitory')
	
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_SpikeRate' + '.pdf', bbox_inches='tight')
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_SpikeRate' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()

for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	numinh = ParamNums[0][x]
	numexc = ParamNums[1][x]
	inhspikes = ParamNums[2][x]
	excspikes = ParamNums[3][x]
	
	fig = pyplot.figure()
	ax = fig.gca()
	
	MeanVoltIndex_Mesh = MeanVoltIndex[x]
	
	surf = pyplot.imshow(numpy.transpose(MeanVoltIndex_Mesh), interpolation='nearest', origin='lower', extent=[excnum_Mesh.min()-0.5, excnum_Mesh.max()+0.5, inhnum_Mesh.min()-0.5, inhnum_Mesh.max()+0.5])
	
	# Add a color bar which maps values to colors.
	cb = fig.colorbar(surf, shrink=0.5, aspect=5)
	cb.set_label('Average Subthreshold Membrane Potential (mV)')
	ax.set_xlabel('Number of Common Excitatory')
	ax.set_ylabel('Number of Common Inhibitory')
	
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_MeanVolt' + '.pdf', bbox_inches='tight')
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_MeanVolt' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()

for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	numinh = ParamNums[0][x]
	numexc = ParamNums[1][x]
	inhspikes = ParamNums[2][x]
	excspikes = ParamNums[3][x]
	
	fig = pyplot.figure()
	ax = fig.gca()
	
	StdVoltIndex_Mesh = StdVoltIndex[x]
	
	surf = pyplot.imshow(numpy.transpose(StdVoltIndex_Mesh), interpolation='nearest', origin='lower', extent=[excnum_Mesh.min()-0.5, excnum_Mesh.max()+0.5, inhnum_Mesh.min()-0.5, inhnum_Mesh.max()+0.5])
	
	# Add a color bar which maps values to colors.
	cb = fig.colorbar(surf, shrink=0.5, aspect=5)
	cb.set_label('Subthreshold Membrane Potential Standard Deviation (mV)')
	ax.set_xlabel('Number of Common Excitatory')
	ax.set_ylabel('Number of Common Inhibitory')
	
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_StdVolt' + '.pdf', bbox_inches='tight')
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_StdVolt' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()

for x in range(0,len(ParamNums[0])):
	if numpy.sum([ParamNums[0][x], ParamNums[1][x], ParamNums[2][x], ParamNums[3][x]]) == 0:
		continue
	numinh = ParamNums[0][x]
	numexc = ParamNums[1][x]
	inhspikes = ParamNums[2][x]
	excspikes = ParamNums[3][x]
	
	fig = pyplot.figure()
	ax = fig.gca()
	
	ISICVIndex_Mesh = ISICVIndex[x]
	
	surf = pyplot.imshow(numpy.transpose(ISICVIndex_Mesh), interpolation='nearest', origin='lower', extent=[excnum_Mesh.min()-0.5, excnum_Mesh.max()+0.5, inhnum_Mesh.min()-0.5, inhnum_Mesh.max()+0.5])
	
	# Add a color bar which maps values to colors.
	cb = fig.colorbar(surf, shrink=0.5, aspect=5)
	cb.set_label('Interspike Interval Coefficient of Variation')
	ax.set_xlabel('Number of Common Excitatory')
	ax.set_ylabel('Number of Common Inhibitory')
	
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_ISICV' + '.pdf', bbox_inches='tight')
	fig.savefig('PLOTfiles/' + Case + '_' + ParamStrs[x] + '_ISICV' + '.png', bbox_inches='tight')
	pyplot.gcf().clear()
	pyplot.cla()
	pyplot.clf()
	pyplot.close()
