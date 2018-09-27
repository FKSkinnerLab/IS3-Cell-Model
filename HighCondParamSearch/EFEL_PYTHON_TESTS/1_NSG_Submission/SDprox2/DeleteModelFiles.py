### Script for deleting all the model files following simulation analyses
import os

for i_NumInh in range(0,len(NumInh)):
    for i_NumExc in range(0,len(NumExc)):
        for i_InhSpikes in range(0,len(InhSpikes)):
            for i_ExcSRSpikes in range(0,len(ExcSRSpikes)):
                for i_NumExcCommon in range(0,len(NumExcCommon)):
                    for i_NumInhCommon in range(0,len(NumInhCommon)):
                        os.remove("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('model_',str(NumInh[i_NumInh]),'_NumInh_',str(NumExc[i_NumExc]),'_NumExc_',str(InhSpikes[i_InhSpikes]),'_InhSpikes_',str(ExcSRSpikes[i_ExcSRSpikes]),'_ExcSRSpikes_',str(ExcSRSpikes[i_ExcSRSpikes]),'_ExcSLMSpikes_',str(NumExcCommon[i_NumExcCommon]),'_NumExcCommon_',str(NumInhCommon[i_NumInhCommon]),'_NumInhCommon.dat'))
                        os.remove("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('InhPreSpikeTrains_',str(NumInh[i_NumInh]),'_NumInh_',str(NumExc[i_NumExc]),'_NumExc_',str(InhSpikes[i_InhSpikes]),'_InhSpikes_',str(ExcSRSpikes[i_ExcSRSpikes]),'_ExcSRSpikes_',str(ExcSRSpikes[i_ExcSRSpikes]),'_ExcSLMSpikes_',str(NumExcCommon[i_NumExcCommon]),'_NumExcCommon_',str(NumInhCommon[i_NumInhCommon]),'_NumInhCommon.dat'))
                        os.remove("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('SRExcPreSpikeTrains_',str(NumInh[i_NumInh]),'_NumInh_',str(NumExc[i_NumExc]),'_NumExc_',str(InhSpikes[i_InhSpikes]),'_InhSpikes_',str(ExcSRSpikes[i_ExcSRSpikes]),'_ExcSRSpikes_',str(ExcSRSpikes[i_ExcSRSpikes]),'_ExcSLMSpikes_',str(NumExcCommon[i_NumExcCommon]),'_NumExcCommon_',str(NumInhCommon[i_NumInhCommon]),'_NumInhCommon.dat'))
                        os.remove("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" % ('SLMExcPreSpikeTrains_',str(NumInh[i_NumInh]),'_NumInh_',str(NumExc[i_NumExc]),'_NumExc_',str(InhSpikes[i_InhSpikes]),'_InhSpikes_',str(ExcSRSpikes[i_ExcSRSpikes]),'_ExcSRSpikes_',str(ExcSRSpikes[i_ExcSRSpikes]),'_ExcSLMSpikes_',str(NumExcCommon[i_NumExcCommon]),'_NumExcCommon_',str(NumInhCommon[i_NumInhCommon]),'_NumInhCommon.dat'))