### Test Script for a file found in the SDprox2 results from initial Parallel Simulations

def getMeasures(TrIn):
	trace_index = int(TrIn)
	h.f(TrIn)
	print('Trace Index = ' + str(trace_index))
	outputresults = [trace_index,trace_index*2,trace_index*3,trace_index*4,trace_index*5,trace_index*6]
	return outputresults

from neuron import h
import numpy
pc = h.ParallelContext()
pc.runworker()
Vec_count = 25
StdVolt = numpy.zeros((Vec_count,), dtype=numpy.float64)
MeanVolt = numpy.zeros((Vec_count,), dtype=numpy.float64)
MeanAPamp = numpy.zeros((Vec_count,), dtype=numpy.float64)
ISICV = numpy.zeros((Vec_count,), dtype=numpy.float64)
NumSpikes = numpy.zeros((Vec_count,), dtype=numpy.int)
# Set up parallel context
print 'Number of Hosts = ' + str(pc.nhost())
if pc.nhost() == 1:
	for l in range(0,Vec_count):
		results = getMeasures(l)
		StdVolt[results[0]] = results[1]
		MeanVolt[results[0]] = results[2]
		NumSpikes[results[0]] = results[3]
		MeanAPamp[results[0]] = results[4]
		ISICV[results[0]] = results[5]
else:
	print 'Step 1: submit jobs'
	for l in range(0,Vec_count): 
		pc.submit(getMeasures,l)
		print 'Trace Index Submit = ' + str(l)
	print 'Step 2: working'
	while pc.working():
		print 'Step 2A'
		print 'User ID = ' + str(pc.userid())
		results = pc.pyret()
		print 'Results = ' + str(results)
		print 'Step 2B: Store Results'
		StdVolt[results[0]] = results[1]
		MeanVolt[results[0]] = results[2]
		NumSpikes[results[0]] = results[3]
		MeanAPamp[results[0]] = results[4]
		ISICV[results[0]] = results[5]
		print 'Step 2C: Results Storage Complete'
print 'Step 3: Done'
pc.done()

