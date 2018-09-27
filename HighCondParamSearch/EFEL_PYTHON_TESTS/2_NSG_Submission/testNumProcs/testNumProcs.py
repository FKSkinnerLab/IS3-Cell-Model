import neuron
from neuron import h
import time

t = time.time()

def testNumProcs(x):
    output = x*x
    print(x)
    return output

import multiprocessing
from multiprocessing import Pool
NUM_PROCS = multiprocessing.cpu_count()
print('number of processors = ' + str(NUM_PROCS))
pool = Pool(NUM_PROCS)
chunksize = 10
NumIndexes = 10000
results = []
results.append(pool.map(testNumProcs,range(0,NumIndexes),chunksize))
print('length = ' + str(len(results[0])))

elapsed = time.time() - t
print elapsed