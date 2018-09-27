tic
clear
close all

addpath('~/Dropbox/MSC_THESIS/Pandora 1.3b/pandora')
addpath('~/Dropbox/MSC_THESIS/Pandora_Matlab - In Progress Scripts/stack-ordering')

tvecFULL = 0.1:0.1:12000.4;

dt_sim = 0.0001; % in seconds
dy_sim = 0.001;
cip_start_sim = 2500;
cip_end_sim = 8000;

props_sim = struct('num_params',2,'type','sim','file_type','neuron','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');
%% Simulations from case 8*, 9*, 7 top model and 8 top model

m100 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/m100/*_-0.1_InjectionMagnitude.dat';
p20 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/p20/*_0.02_InjectionMagnitude.dat';
p50 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/p50/*_0.05_InjectionMagnitude.dat';
p500 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/p500/*_0.5_InjectionMagnitude.dat';

fileset_sim_m100 = params_cip_trace_fileset(m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_sim_p20 = params_cip_trace_fileset(p20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_sim_p50 = params_cip_trace_fileset(p50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_sim_p500 = params_cip_trace_fileset(p500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_sim_m100 = params_tests_db(fileset_sim_m100);
db_sim_p20 = params_tests_db(fileset_sim_p20);
db_sim_p50 = params_tests_db(fileset_sim_p50);
db_sim_p500 = params_tests_db(fileset_sim_p500);

%% Case 8* voltage trace

Case8Star_m100 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8 Star/model_1_Case8Star_-0.1_InjectionMagnitude.dat';
Case8Star_20 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8 Star/model_1_Case8Star_0.02_InjectionMagnitude.dat';
Case8Star_50 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8 Star/model_1_Case8Star_0.05_InjectionMagnitude.dat';
Case8Star_500 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8 Star/model_1_Case8Star_0.5_InjectionMagnitude.dat';

fileset_8Star_m100 = params_cip_trace_fileset(Case8Star_m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_8Star_p20 = params_cip_trace_fileset(Case8Star_20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_8Star_p50 = params_cip_trace_fileset(Case8Star_50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_8Star_p500 = params_cip_trace_fileset(Case8Star_500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_8Star_m100 = params_tests_db(fileset_8Star_m100);
db_8Star_p20 = params_tests_db(fileset_8Star_p20);
db_8Star_p50 = params_tests_db(fileset_8Star_p50);
db_8Star_p500 = params_tests_db(fileset_8Star_p500);

%% Case 9* Voltage Traces

Case9Star_m100 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 9 Star/model_1_Case9Star_-0.1_InjectionMagnitude.dat';
Case9Star_20 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 9 Star/model_1_Case9Star_0.02_InjectionMagnitude.dat';
Case9Star_50 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 9 Star/model_1_Case9Star_0.05_InjectionMagnitude.dat';
Case9Star_500 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 9 Star/model_1_Case9Star_0.5_InjectionMagnitude.dat';

fileset_9Star_m100 = params_cip_trace_fileset(Case9Star_m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_9Star_p20 = params_cip_trace_fileset(Case9Star_20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_9Star_p50 = params_cip_trace_fileset(Case9Star_50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_9Star_p500 = params_cip_trace_fileset(Case9Star_500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_9Star_m100 = params_tests_db(fileset_9Star_m100);
db_9Star_p20 = params_tests_db(fileset_9Star_p20);
db_9Star_p50 = params_tests_db(fileset_9Star_p50);
db_9Star_p500 = params_tests_db(fileset_9Star_p500);

%% Case 7 Top Model Voltage Traces

Case7_m100 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 7/model_17_Case7TopModel_-0.1_InjectionMagnitude.dat';
Case7_20 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 7/model_17_Case7TopModel_0.02_InjectionMagnitude.dat';
Case7_50 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 7/model_17_Case7TopModel_0.05_InjectionMagnitude.dat';
Case7_500 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 7/model_17_Case7TopModel_0.5_InjectionMagnitude.dat';

fileset_7TopModel_m100 = params_cip_trace_fileset(Case7_m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_7TopModel_p20 = params_cip_trace_fileset(Case7_20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_7TopModel_p50 = params_cip_trace_fileset(Case7_50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_7TopModel_p500 = params_cip_trace_fileset(Case7_500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_7TopModel_m100 = params_tests_db(fileset_7TopModel_m100);
db_7TopModel_p20 = params_tests_db(fileset_7TopModel_p20);
db_7TopModel_p50 = params_tests_db(fileset_7TopModel_p50);
db_7TopModel_p500 = params_tests_db(fileset_7TopModel_p500);

%% Case 8 Top Model Voltage Traces

Case8_m100 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8/model_61_Case8TopModel_-0.1_InjectionMagnitude.dat';
Case8_20 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8/model_61_Case8TopModel_0.02_InjectionMagnitude.dat';
Case8_50 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8/model_61_Case8TopModel_0.05_InjectionMagnitude.dat';
Case8_500 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8/model_61_Case8TopModel_0.5_InjectionMagnitude.dat';

fileset_8TopModel_m100 = params_cip_trace_fileset(Case8_m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_8TopModel_p20 = params_cip_trace_fileset(Case8_20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_8TopModel_p50 = params_cip_trace_fileset(Case8_50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_8TopModel_p500 = params_cip_trace_fileset(Case8_500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_8TopModel_m100 = params_tests_db(fileset_8TopModel_m100);
db_8TopModel_p20 = params_tests_db(fileset_8TopModel_p20);
db_8TopModel_p50 = params_tests_db(fileset_8TopModel_p50);
db_8TopModel_p500 = params_tests_db(fileset_8TopModel_p500);

%% Measurement Numbers
PulseIniSpontPotAvgDiff = 20;
PulsePotMin = 26;
PulsePotMinTime = 27;
PulsePotSag = 28;
PulsePotTau = 29;
FreqAtMaxThetaPeak = 3;
ThetaPower = 49;
PulseFirstSpikeTime = 9;
PulseSFA = 30;
PulseSpikeRate = 33;
PulseSpikeRateISI = 34;
PulseSpikeAmplitudeMean = 99;
PulseSpikeHalfWidthMean = 117;
PulseSpikeInitVmMean = 126;
PulseSpikeMaxAHPMean = 129;
PulseSpikes = 147;
PulseIni100msSpikeRate = 18;
PulseIni100msRestIniSpontPotAvgDiff = 16;


toc