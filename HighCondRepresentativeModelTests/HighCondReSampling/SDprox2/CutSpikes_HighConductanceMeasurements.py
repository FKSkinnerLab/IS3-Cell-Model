### Test Script for a file found in the SDprox2 results from initial Parallel Simulations

import efel
import numpy
import time
import random

t = time.time()

# If Loading Vectors
NumInhVec = numpy.load('NPYfiles/' + Case + '_HCNumInh.npy')
NumExcVec = numpy.load('NPYfiles/' + Case + '_HCNumExc.npy')
InhSpikesVec = numpy.load('NPYfiles/' + Case + '_HCInhSpikes.npy')
ExcSRSpikesVec = numpy.load('NPYfiles/' + Case + '_HCExcSRSpikes.npy')
ExcSLMSpikesVec = numpy.load('NPYfiles/' + Case + '_HCExcSLMSpikes.npy')
NumExcCommonVec = numpy.load('NPYfiles/' + Case + '_HCNumExcCommon.npy')
NumInhCommonVec = numpy.load('NPYfiles/' + Case + '_HCNumInhCommon.npy')

LowNumInh = NumInhVec<=172
HighNumInh = NumInhVec>=176
LowNumExc = NumExcVec<=765
HighNumExc = NumExcVec>=783
LowInhSpikes = (InhSpikesVec<=500) & (InhSpikesVec>0)
HighInhSpikes = InhSpikesVec>=600
LowExcSpikes = (ExcSRSpikesVec<=150) & (ExcSRSpikesVec>0)
HighExcSpikes = ExcSRSpikesVec>=200

LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes = zip(LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumInhVec,LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumExcVec,LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec,LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
random.shuffle(LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes)

HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes = zip(HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumInhVec,HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumExcVec,HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec,HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
random.shuffle(HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes)

LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes = zip(LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumInhVec,LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumExcVec,LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec,LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
random.shuffle(LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes)

HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes = zip(HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumInhVec,HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumExcVec,HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec,HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
random.shuffle(HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes)

LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes = zip(LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumInhVec,LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumExcVec,LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec,LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
random.shuffle(LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes)

HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes = zip(HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumInhVec,HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumExcVec,HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec,HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
random.shuffle(HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes)

LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes = zip(LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumInhVec,LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumExcVec,LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec,LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
random.shuffle(LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes)

HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes = zip(HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumInhVec,HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumExcVec,HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec,HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
random.shuffle(HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes)

LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes = zip(LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumInhVec,LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumExcVec,LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec,LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
random.shuffle(LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes)

HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes = zip(HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumInhVec,HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumExcVec,HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec,HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
random.shuffle(HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes)

LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes = zip(LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumInhVec,LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumExcVec,LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec,LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
random.shuffle(LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes)

HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes = zip(HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumInhVec,HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumExcVec,HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec,HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
random.shuffle(HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes)

LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes = zip(LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumInhVec,LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumExcVec,LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec,LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
random.shuffle(LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes)

HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes = zip(HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumInhVec,HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumExcVec,HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec,HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
random.shuffle(HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes)

LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes = zip(LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumInhVec,LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumExcVec,LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec,LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
random.shuffle(LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes)

HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes = zip(HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumInhVec,HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumExcVec,HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec,HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
random.shuffle(HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes)

data = numpy.zeros((100001,), dtype=numpy.float64)
tstop = h.tstop
dt = h.dt
def getMeasures(inhsyn,excsyn,inhspikes,excspikes,examplenum,repnum):	
	rep = int(repnum)
	example = int(examplenum)
	h.randomize_syns(example,rep) # Randomizes synapse location with a different seed on each repetition
	h.f(int(inhsyn),int(excsyn),int(inhspikes),int(excspikes),0,example,rep) # Runs Simulation
	for p in range(0,int(tstop/dt+1)): data[p] = h.recV[p]
	timevec = numpy.arange(1000,int(tstop),dt)
	voltage = data[10001:len(data)] # Cut out first second of simulation since there are transient effects still present
	trace = {}
	trace['T'] = timevec
	trace['V'] = voltage
	trace['stim_start'] = [0]
	trace['stim_end'] = [10000]
	traces = [trace]
	
	traces_results = efel.getFeatureValues(traces,['AP_amplitude','ISI_CV','Spikecount','AP_begin_indices','AP_end_indices'])
	traces_mean_results = efel.getMeanFeatureValues(traces,['AP_amplitude','ISI_CV','Spikecount'])
	
	#### Create Trace Where Spikes Are Removed ####
	AP_begin = traces_results[0]['AP_begin_indices']
	AP_end = traces_results[0]['AP_end_indices']
	spikecut_voltage = []
	
	if AP_begin is not None:
		for i in range(0,len(AP_begin)):
			# Cut out action potentials + 100 index points preceding each spike
			if i == 0:
				spikecut_tempvoltage = voltage[0:AP_begin[i]-80]
				spikecut_voltage.append(spikecut_tempvoltage)
			elif i == len(AP_begin):
				spikecut_tempvoltage = [voltage[AP_end[i-1]:AP_begin[i]]-80, voltage[AP_end[i]:len(voltage)]]
				spikecut_voltage.append(spikecut_tempvoltage)
			else:
				spikecut_tempvoltage = voltage[AP_end[i-1]:AP_begin[i]-80]
				spikecut_voltage.append(spikecut_tempvoltage)
			# Find lengths of appended arrays and rebuild voltage trace array
			x = []
			for i in range(0,len(spikecut_voltage)):
				newlength = len(spikecut_voltage[i])
				x.append(newlength)
			totallength = numpy.sum(x)
			spv = numpy.zeros((totallength,), dtype=numpy.int)
			count = 0
			for i in range(0,len(spikecut_voltage)):
				for j in range(0,len(spikecut_voltage[i])):
					spv[count] = spikecut_voltage[i][j]
					count = count + 1
	else:
		spv = voltage
	
	spv = spv[spv < -50] # Remove all voltage instinces greater than -50 mV
	spt = numpy.arange(0,len(spv),1)*0.1 # Build new tvec for trace with spike cut
	
	### Generate Measurements ###
	if len(spv) == 0:
		StdVolt_i = 0
		MeanVolt_i = -50 # i.e. set to highest possible average if all data points get cut
	else:
		StdVolt_i = numpy.std(spv)
		MeanVolt_i = numpy.mean(spv)
	NumSpikes_i = traces_mean_results[0]['Spikecount']
	if traces_mean_results[0]['AP_amplitude'] is not None:
		MeanAPamp_i = traces_mean_results[0]['AP_amplitude']
	else:
		MeanAPamp_i = 0
	if traces_mean_results[0]['ISI_CV'] is not None:
		ISICV_i = traces_mean_results[0]['ISI_CV']
	else:
		ISICV_i = 0
		reload(efel) # added due to previous error following which all models had ISICV values of 0 regardless of spikes
	AvgPot_Thresh = -66.7
	StdPot_Thresh = 2.2
	ISICV_Thresh = 0.8
	AMP_DB_Thresh = 40
	HC_Metric = 0
	HC_Metric = HC_Metric + (MeanVolt_i >= AvgPot_Thresh) + (StdVolt_i >= StdPot_Thresh) + (ISICV_i >= ISICV_Thresh) - 4*((MeanAPamp_i < AMP_DB_Thresh) & (MeanAPamp_i > 0))
	print 'Vm = ' + str(MeanVolt_i) + ', Vm STD = ' + str(StdVolt_i) + ', ISICV = ' + str(ISICV_i) + ', Amp = ' + str(MeanAPamp_i) + ', HC = ' + str(HC_Metric)
	outputresults = [rep,HC_Metric]
	return outputresults

# Set up parallel context
pc = h.ParallelContext()
pc.runworker()
HCT = numpy.zeros((10,), dtype=numpy.int)
if not LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes:
	LNI_LNE_LIS_LES = numpy.array([0,0,0,0])
for x in range(0,len(LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes)):
	numinh = LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes[x][0]
	numexc = LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes[x][1]
	inhspikes = LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes[x][2]
	excspikes = LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC1 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT1 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		LNI_LNE_LIS_LES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		LNI_LNE_LIS_LES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes:
	HNI_LNE_LIS_LES = numpy.array([0,0,0,0])
for x in range(0,len(HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes)):
	numinh = HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes[x][0]
	numexc = HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes[x][1]
	inhspikes = HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes[x][2]
	excspikes = HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC2 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT2 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		HNI_LNE_LIS_LES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		HNI_LNE_LIS_LES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes:
	LNI_HNE_LIS_LES = numpy.array([0,0,0,0])
for x in range(0,len(LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes)):
	numinh = LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes[x][0]
	numexc = LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes[x][1]
	inhspikes = LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes[x][2]
	excspikes = LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC3 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT3 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		LNI_HNE_LIS_LES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		LNI_HNE_LIS_LES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes:
	HNI_HNE_LIS_LES = numpy.array([0,0,0,0])
for x in range(0,len(HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes)):
	numinh = HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes[x][0]
	numexc = HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes[x][1]
	inhspikes = HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes[x][2]
	excspikes = HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC4 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT4 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		HNI_HNE_LIS_LES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		HNI_HNE_LIS_LES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes:
	LNI_LNE_HIS_LES = numpy.array([0,0,0,0])
for x in range(0,len(LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes)):
	numinh = LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes[x][0]
	numexc = LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes[x][1]
	inhspikes = LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes[x][2]
	excspikes = LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC5 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT5 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		LNI_LNE_HIS_LES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		LNI_LNE_HIS_LES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes:
	HNI_LNE_HIS_LES = numpy.array([0,0,0,0])
for x in range(0,len(HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes)):
	numinh = HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes[x][0]
	numexc = HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes[x][1]
	inhspikes = HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes[x][2]
	excspikes = HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC6 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT6 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		HNI_LNE_HIS_LES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		HNI_LNE_HIS_LES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes:
	LNI_HNE_HIS_LES = numpy.array([0,0,0,0])
for x in range(0,len(LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes)):
	numinh = LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes[x][0]
	numexc = LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes[x][1]
	inhspikes = LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes[x][2]
	excspikes = LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC7 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT7 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		LNI_HNE_HIS_LES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		LNI_HNE_HIS_LES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes:
	HNI_HNE_HIS_LES = numpy.array([0,0,0,0])
for x in range(0,len(HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes)):
	numinh = HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes[x][0]
	numexc = HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes[x][1]
	inhspikes = HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes[x][2]
	excspikes = HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC8 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT8 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		HNI_HNE_HIS_LES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		HNI_HNE_HIS_LES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes:
	LNI_LNE_LIS_HES = numpy.array([0,0,0,0])
for x in range(0,len(LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes)):
	numinh = LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes[x][0]
	numexc = LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes[x][1]
	inhspikes = LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes[x][2]
	excspikes = LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC9 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT9 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		LNI_LNE_LIS_HES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		LNI_LNE_LIS_HES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes:
	HNI_LNE_LIS_HES = numpy.array([0,0,0,0])
for x in range(0,len(HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes)):
	numinh = HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes[x][0]
	numexc = HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes[x][1]
	inhspikes = HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes[x][2]
	excspikes = HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC10 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT10 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		HNI_LNE_LIS_HES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		HNI_LNE_LIS_HES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes:
	LNI_HNE_LIS_HES = numpy.array([0,0,0,0])
for x in range(0,len(LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes)):
	numinh = LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes[x][0]
	numexc = LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes[x][1]
	inhspikes = LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes[x][2]
	excspikes = LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC11 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT11 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		LNI_HNE_LIS_HES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		LNI_HNE_LIS_HES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes:
	HNI_HNE_LIS_HES = numpy.array([0,0,0,0])
for x in range(0,len(HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes)):
	numinh = HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes[x][0]
	numexc = HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes[x][1]
	inhspikes = HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes[x][2]
	excspikes = HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC12 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT12 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		HNI_HNE_LIS_HES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		HNI_HNE_LIS_HES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes:
	LNI_LNE_HIS_HES = numpy.array([0,0,0,0])
for x in range(0,len(LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes)):
	numinh = LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes[x][0]
	numexc = LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes[x][1]
	inhspikes = LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes[x][2]
	excspikes = LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC13 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT13 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		LNI_LNE_HIS_HES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		LNI_LNE_HIS_HES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes:
	HNI_LNE_HIS_HES = numpy.array([0,0,0,0])
for x in range(0,len(HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes)):
	numinh = HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes[x][0]
	numexc = HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes[x][1]
	inhspikes = HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes[x][2]
	excspikes = HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC14 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT14 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		HNI_LNE_HIS_HES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		HNI_LNE_HIS_HES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes:
	LNI_HNE_HIS_HES = numpy.array([0,0,0,0])
for x in range(0,len(LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes)):
	numinh = LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes[x][0]
	numexc = LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes[x][1]
	inhspikes = LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes[x][2]
	excspikes = LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC15 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT15 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		LNI_HNE_HIS_HES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		LNI_HNE_HIS_HES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)
if not HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes:
	HNI_HNE_HIS_HES = numpy.array([0,0,0,0])
for x in range(0,len(HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes)):
	numinh = HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes[x][0]
	numexc = HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes[x][1]
	inhspikes = HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes[x][2]
	excspikes = HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes[x][3]
	if pc.nhost() == 1:
		for y in range(1,11):
			results = getMeasures(numinh,numexc,inhspikes,excspikes,x,y)
			print 'HC16 = ' + str(results[1]) + ', for example #' + str(x) + ' on rep #' + str(y)
			if results[1] < 3:
				break
	else:
		for y in range(1,11):
			pc.submit(getMeasures,numinh,numexc,inhspikes,excspikes,x,y)
		while pc.working():
			results = pc.pyret()
			HCT[results[0]-1] = results[1]
		results[0] = 0 # Ensures no confusion between serial and parallel contexts
		results[1] = 0 # Ensures no confusion between serial and parallel contexts
		print 'HCT16 = ' + str(numpy.sum(HCT)) + ' for example #' + str(x)
	if ((results[0] == 10) & (results[1] == 3)) or (numpy.sum(HCT) == 30):
		HNI_HNE_HIS_HES = numpy.array([numinh,numexc,inhspikes,excspikes])
		break
	else:
		HNI_HNE_HIS_HES = numpy.array([0,0,0,0])
	HCT = numpy.zeros((10,), dtype=numpy.int)
HCT = numpy.zeros((10,), dtype=numpy.int)

pc.done()

elapsed = time.time() - t
print elapsed
