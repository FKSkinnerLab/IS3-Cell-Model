clear all; close all;

addpath('~/Dropbox/MSC_THESIS/Pandora 1.3b/pandora')
addpath('~/Dropbox/MSC_THESIS/Pandora_Matlab - In Progress Scripts/stack-ordering')

dt_sim = 0.0001;
dy_sim = 0.001;
cip_start_sim = 2500;
cip_end_sim = 8000;

props_sim = struct('num_params',5,'type','sim','file_type','neuron','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');

Case = 'Case7';
TopDirSim = '~/Desktop/SkinnerLab/Usages/Fast KDRF/Case 1/';
TopDirSim1 = [TopDirSim 'model_1_ModNum_0.2_NaT_5e-05_NaP_0.95_Kdrf_0.15_KA_-0.1_InjectionMagnitude.dat'];
TopDirSim2 = [TopDirSim 'model_1_ModNum_0.2_NaT_5e-05_NaP_0.95_Kdrf_0.15_KA_0.02_InjectionMagnitude.dat'];
TopDirSim3 = [TopDirSim 'model_1_ModNum_0.2_NaT_5e-05_NaP_0.95_Kdrf_0.15_KA_0.05_InjectionMagnitude.dat'];
TopDirSim4 = [TopDirSim 'model_1_ModNum_0.2_NaT_5e-05_NaP_0.95_Kdrf_0.15_KA_0.5_InjectionMagnitude.dat'];

% TopDirSim1 = [TopDirSim 'model_42_ModNum_0.225_NaT_0.00015_NaP_1_Kdrf_0.2_KA_-0.1_InjectionMagnitude.dat'];
% TopDirSim2 = [TopDirSim 'model_42_ModNum_0.225_NaT_0.00015_NaP_1_Kdrf_0.2_KA_0.02_InjectionMagnitude.dat'];
% TopDirSim3 = [TopDirSim 'model_42_ModNum_0.225_NaT_0.00015_NaP_1_Kdrf_0.2_KA_0.05_InjectionMagnitude.dat'];
% TopDirSim4 = [TopDirSim 'model_42_ModNum_0.225_NaT_0.00015_NaP_1_Kdrf_0.2_KA_0.5_InjectionMagnitude.dat'];

f1 = TopDirSim1;
f2 = TopDirSim2;
f3 = TopDirSim3;
f4 = TopDirSim4;

ssdm100TraceSimN1 = cip_trace(f1,dt_sim,dy_sim,cip_start_sim,cip_end_sim,'simdata',props_sim);
ssdp20TraceSimN1 = cip_trace(f2,dt_sim,dy_sim,cip_start_sim,cip_end_sim,'simdata',props_sim);
ssdp50TraceSimN1 = cip_trace(f3,dt_sim,dy_sim,cip_start_sim,cip_end_sim,'simdata',props_sim);
ssdp500TraceSimN1 = cip_trace(f4,dt_sim,dy_sim,cip_start_sim,cip_end_sim,'simdata',props_sim);

x = vertcat(ssdm100TraceSimN1.data,ssdp20TraceSimN1.data,ssdp50TraceSimN1.data,ssdp500TraceSimN1.data);
tv = 0.1:0.1:12000.4;

A3 = figure(1);
plot(tv,x)
xlabel('Time [ms]')
ylabel('Voltage [mV]')
title('Voltage Trace')
axis([0 max(tv) -150 50])
