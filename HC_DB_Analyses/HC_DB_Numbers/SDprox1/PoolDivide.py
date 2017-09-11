def PoolDivide(NumInhVec,NumExcVec,InhSpikesVec,ExcSRSpikesVec,stringvar):
	LowNumInh = NumInhVec<=172
	HighNumInh = NumInhVec>=176
	LowNumExc = NumExcVec<=765
	HighNumExc = NumExcVec>=783
	LowInhSpikes = (InhSpikesVec<=500) & (InhSpikesVec>0)
	HighInhSpikes = InhSpikesVec>=600
	LowExcSpikes = (ExcSRSpikesVec<=150) & (ExcSRSpikesVec>0)
	HighExcSpikes = ExcSRSpikesVec>=200
	
	ExampleStrings = ['LNI_LNE_LIS_LES','HNI_LNE_LIS_LES','LNI_HNE_LIS_LES','HNI_HNE_LIS_LES','LNI_LNE_HIS_LES','HNI_LNE_HIS_LES','LNI_HNE_HIS_LES','HNI_HNE_HIS_LES','LNI_LNE_LIS_HES','HNI_LNE_LIS_HES','LNI_HNE_LIS_HES','HNI_HNE_LIS_HES','LNI_LNE_HIS_HES','HNI_LNE_HIS_HES','LNI_HNE_HIS_HES','HNI_HNE_HIS_HES']
	PoolNums = HC_MetricVec = numpy.zeros((len(ExampleStrings),), dtype=numpy.int) 
	
	LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes = zip(LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumInhVec,LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumExcVec,LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec,LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
	random.shuffle(LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes)
	print 'Number of LNI_LNE_LIS_LES ' + stringvar + ' Models = ' + str(len(LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec))
	PoolNums[0] = len(LowNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
	
	HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes = zip(HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumInhVec,HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_NumExcVec,HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec,HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
	random.shuffle(HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes)
	print 'Number of HNI_LNE_LIS_LES ' + stringvar + ' Models = ' + str(len(HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec))
	PoolNums[1] = len(HighNumInh_LowNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
	
	LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes = zip(LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumInhVec,LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumExcVec,LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec,LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
	random.shuffle(LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes)
	print 'Number of LNI_HNE_LIS_LES ' + stringvar + ' Models = ' + str(len(LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec))
	PoolNums[2] = len(LowNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
	
	HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (LowExcSpikes)]
	HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes = zip(HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumInhVec,HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_NumExcVec,HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_InhSpikesVec,HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
	random.shuffle(HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes)
	print 'Number of HNI_HNE_LIS_LES ' + stringvar + ' Models = ' + str(len(HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec))
	PoolNums[3] = len(HighNumInh_HighNumExc_LowInhSpikes_LowExcSpikes_ExcSpikesVec)
	
	LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes = zip(LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumInhVec,LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumExcVec,LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec,LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
	random.shuffle(LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes)
	print 'Number of LNI_LNE_HIS_LES ' + stringvar + ' Models = ' + str(len(LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec))
	PoolNums[4] = len(LowNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
	
	HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes = zip(HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumInhVec,HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_NumExcVec,HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec,HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
	random.shuffle(HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes)
	print 'Number of HNI_LNE_HIS_LES ' + stringvar + ' Models = ' + str(len(HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec))
	PoolNums[5] = len(HighNumInh_LowNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
	
	LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes = zip(LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumInhVec,LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumExcVec,LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec,LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
	random.shuffle(LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes)
	print 'Number of LNI_HNE_HIS_LES ' + stringvar + ' Models = ' + str(len(LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec))
	PoolNums[6] = len(LowNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
	
	HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (LowExcSpikes)]
	HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes = zip(HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumInhVec,HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_NumExcVec,HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_InhSpikesVec,HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
	random.shuffle(HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes)
	print 'Number of HNI_HNE_HIS_LES ' + stringvar + ' Models = ' + str(len(HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec))
	PoolNums[7] = len(HighNumInh_HighNumExc_HighInhSpikes_LowExcSpikes_ExcSpikesVec)
	
	LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes = zip(LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumInhVec,LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumExcVec,LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec,LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
	random.shuffle(LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes)
	print 'Number of LNI_LNE_LIS_HES ' + stringvar + ' Models = ' + str(len(LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec))
	PoolNums[8] = len(LowNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
	
	HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (LowNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes = zip(HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumInhVec,HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_NumExcVec,HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec,HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
	random.shuffle(HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes)
	print 'Number of HNI_LNE_LIS_HES ' + stringvar + ' Models = ' + str(len(HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec))
	PoolNums[9] = len(HighNumInh_LowNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
	
	LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes = zip(LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumInhVec,LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumExcVec,LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec,LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
	random.shuffle(LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes)
	print 'Number of LNI_HNE_LIS_HES ' + stringvar + ' Models = ' + str(len(LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec))
	PoolNums[10] = len(LowNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
	
	HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (HighNumExc) & (LowInhSpikes) & (HighExcSpikes)]
	HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes = zip(HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumInhVec,HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_NumExcVec,HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_InhSpikesVec,HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
	random.shuffle(HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes)
	print 'Number of HNI_HNE_LIS_HES ' + stringvar + ' Models = ' + str(len(HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec))
	PoolNums[11] = len(HighNumInh_HighNumExc_LowInhSpikes_HighExcSpikes_ExcSpikesVec)
	
	LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes = zip(LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumInhVec,LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumExcVec,LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec,LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
	random.shuffle(LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes)
	print 'Number of LNI_LNE_HIS_HES ' + stringvar + ' Models = ' + str(len(LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec))
	PoolNums[12] = len(LowNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
	
	HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (LowNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes = zip(HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumInhVec,HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_NumExcVec,HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec,HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
	random.shuffle(HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes)
	print 'Number of HNI_LNE_HIS_HES ' + stringvar + ' Models = ' + str(len(HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec))
	PoolNums[13] = len(HighNumInh_LowNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
	
	LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(LowNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes = zip(LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumInhVec,LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumExcVec,LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec,LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
	random.shuffle(LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes)
	print 'Number of LNI_HNE_HIS_HES ' + stringvar + ' Models = ' + str(len(LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec))
	PoolNums[14] = len(LowNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
	
	HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec = ExcSRSpikesVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec = InhSpikesVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumExcVec = NumExcVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumInhVec = NumInhVec[(HighNumInh) & (HighNumExc) & (HighInhSpikes) & (HighExcSpikes)]
	HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes = zip(HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumInhVec,HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_NumExcVec,HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_InhSpikesVec,HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
	random.shuffle(HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes)
	print 'Number of HNI_HNE_HIS_HES ' + stringvar + ' Models = ' + str(len(HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec))
	PoolNums[15] = len(HighNumInh_HighNumExc_HighInhSpikes_HighExcSpikes_ExcSpikesVec)
	
	return ExampleStrings, PoolNums

