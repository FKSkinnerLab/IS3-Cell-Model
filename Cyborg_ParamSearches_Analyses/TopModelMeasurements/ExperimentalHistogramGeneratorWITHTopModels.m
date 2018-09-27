tic
clear
close all

addpath('~/Dropbox/MSC_THESIS/Pandora 1.3b/pandora')
addpath('~/Dropbox/MSC_THESIS/Pandora_Matlab - In Progress Scripts/stack-ordering')
font_size = 24;
font_weight = 'normal';
font_angle = 'normal';

%%% Experimental database histogram generator %%%
%% Parameters
dt_exp = 0.0001; % in seconds
dy_exp = 0.001;
cip_start_exp = 2500;
cip_end_exp = 8000;

TopDirExp1 = '~/Dropbox/MSC_THESIS/Experimental Data/ExpSavedTraces/Hyperpolarizing/*.mat';
TopDirExp2 = '~/Dropbox/MSC_THESIS/Experimental Data/ExpSavedTraces/DepolarizingNoSpikes/*.mat';
TopDirExp3 = '~/Dropbox/MSC_THESIS/Experimental Data/ExpSavedTraces/DepolarizingSpikes/*.mat';
TopDirExp4 = '~/Dropbox/MSC_THESIS/Experimental Data/ExpSavedTraces/Depolarizationblock/*.mat';

%% Construct Experimental Databases

props_exp = struct('num_params',2,'type','exp','file_type','matlab','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');

fileset_exp_m100 = params_cip_trace_fileset(TopDirExp1,...
    dt_exp,dy_exp,cip_start_exp,cip_end_exp,'Exp Dataset',props_exp);
fileset_exp_p20 = params_cip_trace_fileset(TopDirExp2,...
    dt_exp,dy_exp,cip_start_exp,cip_end_exp,'Exp Dataset',props_exp);
fileset_exp_p50 = params_cip_trace_fileset(TopDirExp3,...
    dt_exp,dy_exp,cip_start_exp,cip_end_exp,'Exp Dataset',props_exp);
fileset_exp_p500 = params_cip_trace_fileset(TopDirExp4,...
    dt_exp,dy_exp,cip_start_exp,cip_end_exp,'Exp Dataset',props_exp);

db_exp_m100 = params_tests_db(fileset_exp_m100);
db_exp_p20 = params_tests_db(fileset_exp_p20);
db_exp_p50 = params_tests_db(fileset_exp_p50);
db_exp_p500 = params_tests_db(fileset_exp_p500);

%% Find number of traces & cells for each CIP
NCells_m100 = length(unique(db_exp_m100.data(:,1))); % Note that some are repeats, however
NTraces_m100 = length(db_exp_m100.data(:,2));
CIPvalues_m100 = unique(db_exp_m100.data(:,2));

NCells_p20 = length(unique(db_exp_p20.data(:,1))); % Note that some are repeats, however
NTraces_p20 = length(db_exp_p20.data(:,2));
CIPvalues_p20 = unique(db_exp_p20.data(:,2));

NCells_p50 = length(unique(db_exp_p50.data(:,1))); % Note that some are repeats, however
NTraces_p50 = length(db_exp_p50.data(:,2));
CIPvalues_p50 = unique(db_exp_p50.data(:,2));

NCells_p500 = length(unique(db_exp_p500.data(:,1))); % Note that some are repeats, however
NTraces_p500 = length(db_exp_p500.data(:,2));
CIPvalues_p500 = unique(db_exp_p500.data(:,2));

%% Find Selected Traces
CanonExp1 = find(db_exp_m100.data(:,1)==14227002 & db_exp_m100.data(:,2)==-100);
CanonExp2 = find(db_exp_p20.data(:,1)==14723001 & db_exp_p20.data(:,2)==20);
CanonExp3 = find(db_exp_p50.data(:,1)==14227002 & db_exp_p50.data(:,2)==50);
CanonExp4 = find(db_exp_p500.data(:,1)==14227002 & db_exp_p500.data(:,2)==500);

%% Simulation Paramaters

dt_sim = 0.0001; % in seconds
dy_sim = 0.001;
cip_start_sim = 2500;
cip_end_sim = 8000;

props_sim = struct('num_params',2,'type','sim','file_type','neuron','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');

%% Simulations from case 1, 8*, 9*, 7 top model and 8 top model

Case1m100 = '~/Desktop/SkinnerLab/Usages/Case_1_Output_Analysis/Case1Output/*_-0.1_InjectionMagnitude.dat';
Case1p20 = '~/Desktop/SkinnerLab/Usages/Case_1_Output_Analysis/Case1Output/*_0.02_InjectionMagnitude.dat';
Case1p50 = '~/Desktop/SkinnerLab/Usages/Case_1_Output_Analysis/Case1Output/*_0.05_InjectionMagnitude.dat';
Case1p500 = '~/Desktop/SkinnerLab/Usages/Case_1_Output_Analysis/Case1Output/*_0.5_InjectionMagnitude.dat';

fileset_Case1_m100 = params_cip_trace_fileset(Case1m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case1_p20 = params_cip_trace_fileset(Case1p20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case1_p50 = params_cip_trace_fileset(Case1p50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case1_p500 = params_cip_trace_fileset(Case1p500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_Case1_m100 = params_tests_db(fileset_Case1_m100);
db_Case1_p20 = params_tests_db(fileset_Case1_p20);
db_Case1_p50 = params_tests_db(fileset_Case1_p50);
db_Case1_p500 = params_tests_db(fileset_Case1_p500);

Case7m100 = '~/Desktop/SkinnerLab/Usages/Fast KDRF/Case 1/*_-0.1_InjectionMagnitude.dat';
Case7p20 = '~/Desktop/SkinnerLab/Usages/Fast KDRF/Case 1/*_0.02_InjectionMagnitude.dat';
Case7p50 = '~/Desktop/SkinnerLab/Usages/Fast KDRF/Case 1/*_0.05_InjectionMagnitude.dat';
Case7p500 = '~/Desktop/SkinnerLab/Usages/Fast KDRF/Case 1/*_0.5_InjectionMagnitude.dat';

fileset_Case7_m100 = params_cip_trace_fileset(Case7m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case7_p20 = params_cip_trace_fileset(Case7p20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case7_p50 = params_cip_trace_fileset(Case7p50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case7_p500 = params_cip_trace_fileset(Case7p500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_Case7_m100 = params_tests_db(fileset_Case7_m100);
db_Case7_p20 = params_tests_db(fileset_Case7_p20);
db_Case7_p50 = params_tests_db(fileset_Case7_p50);
db_Case7_p500 = params_tests_db(fileset_Case7_p500);

Case8m100 = '~/Desktop/SkinnerLab/Usages/Fast KDRF/Case 2/*_-0.1_InjectionMagnitude.dat';
Case8p20 = '~/Desktop/SkinnerLab/Usages/Fast KDRF/Case 2/*_0.02_InjectionMagnitude.dat';
Case8p50 = '~/Desktop/SkinnerLab/Usages/Fast KDRF/Case 2/*_0.05_InjectionMagnitude.dat';
Case8p500 = '~/Desktop/SkinnerLab/Usages/Fast KDRF/Case 2/*_0.5_InjectionMagnitude.dat';

fileset_Case8_m100 = params_cip_trace_fileset(Case8m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case8_p20 = params_cip_trace_fileset(Case8p20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case8_p50 = params_cip_trace_fileset(Case8p50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case8_p500 = params_cip_trace_fileset(Case8p500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_Case8_m100 = params_tests_db(fileset_Case8_m100);
db_Case8_p20 = params_tests_db(fileset_Case8_p20);
db_Case8_p50 = params_tests_db(fileset_Case8_p50);
db_Case8_p500 = params_tests_db(fileset_Case8_p500);

Case8Starm100 = '~/Desktop/SkinnerLab/Usages/NSG_Simulations/output/Case8StarPSIBAuRg/Cipres_Data/output/Case8StarModel/*_-0.1_InjectionMagnitude.dat';
Case8Starp20 = '~/Desktop/SkinnerLab/Usages/NSG_Simulations/output/Case8StarPSIBAuRg/Cipres_Data/output/Case8StarModel/*_0.02_InjectionMagnitude.dat';
Case8Starp50 = '~/Desktop/SkinnerLab/Usages/NSG_Simulations/output/Case8StarPSIBAuRg/Cipres_Data/output/Case8StarModel/*_0.05_InjectionMagnitude.dat';
Case8Starp500 = '~/Desktop/SkinnerLab/Usages/NSG_Simulations/output/Case8StarPSIBAuRg/Cipres_Data/output/Case8StarModel/*_0.5_InjectionMagnitude.dat';

fileset_Case8Star_m100 = params_cip_trace_fileset(Case8Starm100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case8Star_p20 = params_cip_trace_fileset(Case8Starp20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case8Star_p50 = params_cip_trace_fileset(Case8Starp50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case8Star_p500 = params_cip_trace_fileset(Case8Starp500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_Case8Star_m100 = params_tests_db(fileset_Case8Star_m100);
db_Case8Star_p20 = params_tests_db(fileset_Case8Star_p20);
db_Case8Star_p50 = params_tests_db(fileset_Case8Star_p50);
db_Case8Star_p500 = params_tests_db(fileset_Case8Star_p500);

Case9Starm100 = '~/Desktop/SkinnerLab/Usages/NSG_Simulations/output/Case9StarPSIBAuRg/Cipres_Data/output/Case9StarModel/*_-0.1_InjectionMagnitude.dat';
Case9Starp20 = '~/Desktop/SkinnerLab/Usages/NSG_Simulations/output/Case9StarPSIBAuRg/Cipres_Data/output/Case9StarModel/*_0.02_InjectionMagnitude.dat';
Case9Starp50 = '~/Desktop/SkinnerLab/Usages/NSG_Simulations/output/Case9StarPSIBAuRg/Cipres_Data/output/Case9StarModel/*_0.05_InjectionMagnitude.dat';
Case9Starp500 = '~/Desktop/SkinnerLab/Usages/NSG_Simulations/output/Case9StarPSIBAuRg/Cipres_Data/output/Case9StarModel/*_0.5_InjectionMagnitude.dat';

fileset_Case9Star_m100 = params_cip_trace_fileset(Case9Starm100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case9Star_p20 = params_cip_trace_fileset(Case9Starp20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case9Star_p50 = params_cip_trace_fileset(Case9Starp50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_Case9Star_p500 = params_cip_trace_fileset(Case9Starp500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_Case9Star_m100 = params_tests_db(fileset_Case9Star_m100);
db_Case9Star_p20 = params_tests_db(fileset_Case9Star_p20);
db_Case9Star_p50 = params_tests_db(fileset_Case9Star_p50);
db_Case9Star_p500 = params_tests_db(fileset_Case9Star_p500);

SDprox3m100 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/*_-0.1_InjectionMagnitude.dat';
SDprox3p20 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/*_0.02_InjectionMagnitude.dat';
SDprox3p50 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/*_0.05_InjectionMagnitude.dat';
SDprox3p500 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/*_0.5_InjectionMagnitude.dat';

fileset_SDprox3_m100 = params_cip_trace_fileset(SDprox3m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_SDprox3_p20 = params_cip_trace_fileset(SDprox3p20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_SDprox3_p50 = params_cip_trace_fileset(SDprox3p50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_SDprox3_p500 = params_cip_trace_fileset(SDprox3p500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_SDprox3_m100 = params_tests_db(fileset_SDprox3_m100);
db_SDprox3_p20 = params_tests_db(fileset_SDprox3_p20);
db_SDprox3_p50 = params_tests_db(fileset_SDprox3_p50);
db_SDprox3_p500 = params_tests_db(fileset_SDprox3_p500);

SDprox4m100 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/*_-0.1_InjectionMagnitude.dat';
SDprox4p20 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/*_0.02_InjectionMagnitude.dat';
SDprox4p50 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/*_0.05_InjectionMagnitude.dat';
SDprox4p500 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/*_0.5_InjectionMagnitude.dat';

fileset_SDprox4_m100 = params_cip_trace_fileset(SDprox4m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_SDprox4_p20 = params_cip_trace_fileset(SDprox4p20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_SDprox4_p50 = params_cip_trace_fileset(SDprox4p50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_SDprox4_p500 = params_cip_trace_fileset(SDprox4p500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_SDprox4_m100 = params_tests_db(fileset_SDprox4_m100);
db_SDprox4_p20 = params_tests_db(fileset_SDprox4_p20);
db_SDprox4_p50 = params_tests_db(fileset_SDprox4_p50);
db_SDprox4_p500 = params_tests_db(fileset_SDprox4_p500);

%% SDprox.3 voltage trace

TopSDprox3m100 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/model_289_ModNum_0.075_NaT_5e-05_NaP_0.275_Kdrf_0.03_KA_5e-05_IH_75_DistFromSoma_-0.1_InjectionMagnitude.dat';
TopSDprox3p20 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/model_289_ModNum_0.075_NaT_5e-05_NaP_0.275_Kdrf_0.03_KA_5e-05_IH_75_DistFromSoma_0.02_InjectionMagnitude.dat';
TopSDprox3p50 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/model_289_ModNum_0.075_NaT_5e-05_NaP_0.275_Kdrf_0.03_KA_5e-05_IH_75_DistFromSoma_0.05_InjectionMagnitude.dat';
TopSDprox3p500 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox1_HCNS_N2/Cipres_Data/output/SDprox1_HCNS/model_289_ModNum_0.075_NaT_5e-05_NaP_0.275_Kdrf_0.03_KA_5e-05_IH_75_DistFromSoma_0.5_InjectionMagnitude.dat';

fileset_TopSDprox3_m100 = params_cip_trace_fileset(TopSDprox3m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_TopSDprox3_p20 = params_cip_trace_fileset(TopSDprox3p20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_TopSDprox3_p50 = params_cip_trace_fileset(TopSDprox3p50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_TopSDprox3_p500 = params_cip_trace_fileset(TopSDprox3p500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_TopSDprox3_m100 = params_tests_db(fileset_TopSDprox3_m100);
db_TopSDprox3_p20 = params_tests_db(fileset_TopSDprox3_p20);
db_TopSDprox3_p50 = params_tests_db(fileset_TopSDprox3_p50);
db_TopSDprox3_p500 = params_tests_db(fileset_TopSDprox3_p500);

%% SDprox.4 voltage trace

TopSDprox4m100 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox2_HCNS_N2/Cipres_Data/output/SDprox2_HCNS/model_564_ModNum_0.065_NaT_0.0001_NaP_0.35_Kdrf_0.03_KA_0.0002_IH_95_DistFromSoma_-0.1_InjectionMagnitude.dat';
TopSDprox4p20 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox2_HCNS_N2/Cipres_Data/output/SDprox2_HCNS/model_564_ModNum_0.065_NaT_0.0001_NaP_0.35_Kdrf_0.03_KA_0.0002_IH_95_DistFromSoma_0.02_InjectionMagnitude.dat';
TopSDprox4p50 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox2_HCNS_N2/Cipres_Data/output/SDprox2_HCNS/model_564_ModNum_0.065_NaT_0.0001_NaP_0.35_Kdrf_0.03_KA_0.0002_IH_95_DistFromSoma_0.05_InjectionMagnitude.dat';
TopSDprox4p500 = '~/Desktop/SkinnerLab/Usages/HCN_cyborg/NSG/Outputs/SDprox2_HCNS_N2/Cipres_Data/output/SDprox2_HCNS/model_564_ModNum_0.065_NaT_0.0001_NaP_0.35_Kdrf_0.03_KA_0.0002_IH_95_DistFromSoma_0.5_InjectionMagnitude.dat';

fileset_TopSDprox4_m100 = params_cip_trace_fileset(TopSDprox4m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_TopSDprox4_p20 = params_cip_trace_fileset(TopSDprox4p20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_TopSDprox4_p50 = params_cip_trace_fileset(TopSDprox4p50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_TopSDprox4_p500 = params_cip_trace_fileset(TopSDprox4p500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_TopSDprox4_m100 = params_tests_db(fileset_TopSDprox4_m100);
db_TopSDprox4_p20 = params_tests_db(fileset_TopSDprox4_p20);
db_TopSDprox4_p50 = params_tests_db(fileset_TopSDprox4_p50);
db_TopSDprox4_p500 = params_tests_db(fileset_TopSDprox4_p500);

%% Case 8* voltage trace

Case8Star_m100 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8 Star/model_137_Case8Star_-0.1_InjectionMagnitude.dat';
Case8Star_20 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8 Star/model_137_Case8Star_0.02_InjectionMagnitude.dat';
Case8Star_50 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8 Star/model_137_Case8Star_0.05_InjectionMagnitude.dat';
Case8Star_500 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 8 Star/model_137_Case8Star_0.5_InjectionMagnitude.dat';

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

Case9Star_m100 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 9 Star/model_93_Case9Star_-0.1_InjectionMagnitude.dat';
Case9Star_20 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 9 Star/model_93_Case9Star_0.02_InjectionMagnitude.dat';
Case9Star_50 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 9 Star/model_93_Case9Star_0.05_InjectionMagnitude.dat';
Case9Star_500 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 9 Star/model_93_Case9Star_0.5_InjectionMagnitude.dat';

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

%% Case 1 Top Model Voltage Traces

Case1_m100 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 1/model_346_Case1TopModel_-0.1_InjectionMagnitude.dat';
Case1_20 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 1/model_346_Case1TopModel_0.02_InjectionMagnitude.dat';
Case1_50 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 1/model_346_Case1TopModel_0.05_InjectionMagnitude.dat';
Case1_500 = '~/Desktop/SkinnerLab/Usages/TopModelMeasurements/Case 1/model_346_Case1TopModel_0.5_InjectionMagnitude.dat';

fileset_1TopModel_m100 = params_cip_trace_fileset(Case1_m100,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_1TopModel_p20 = params_cip_trace_fileset(Case1_20,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_1TopModel_p50 = params_cip_trace_fileset(Case1_50,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_1TopModel_p500 = params_cip_trace_fileset(Case1_500,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_1TopModel_m100 = params_tests_db(fileset_1TopModel_m100);
db_1TopModel_p20 = params_tests_db(fileset_1TopModel_p20);
db_1TopModel_p50 = params_tests_db(fileset_1TopModel_p50);
db_1TopModel_p500 = params_tests_db(fileset_1TopModel_p500);

%% Plot Experimental Histograms

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

%% Pre-processing (i.e. removing models that clearly don't capture the signature features)
PulseIni100msRest1SpikeRate = 12; % Number from column index in tests_db
PulseIni100msRest2SpikeRate = 14;
RecovSpikes = 196;

% Remove all models containing any spikes at the 20pA CIP
db_Case1_m100.data(db_Case1_p20.data(:,PulseSpikes)>=1,:) = []; 
db_Case1_p50.data(db_Case1_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case1_p500.data(db_Case1_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case1_p20.data(db_Case1_p20.data(:,PulseSpikes)>=1,:) = [];

db_Case7_m100.data(db_Case7_p20.data(:,PulseSpikes)>=1,:) = []; 
db_Case7_p50.data(db_Case7_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case7_p500.data(db_Case7_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case7_p20.data(db_Case7_p20.data(:,PulseSpikes)>=1,:) = [];

db_Case8_m100.data(db_Case8_p20.data(:,PulseSpikes)>=1,:) = []; 
db_Case8_p50.data(db_Case8_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case8_p500.data(db_Case8_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case8_p20.data(db_Case8_p20.data(:,PulseSpikes)>=1,:) = [];

db_Case8Star_m100.data(db_Case8Star_p20.data(:,PulseSpikes)>=1,:) = []; 
db_Case8Star_p50.data(db_Case8Star_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case8Star_p500.data(db_Case8Star_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case8Star_p20.data(db_Case8Star_p20.data(:,PulseSpikes)>=1,:) = [];

db_Case9Star_m100.data(db_Case9Star_p20.data(:,PulseSpikes)>=1,:) = []; 
db_Case9Star_p50.data(db_Case9Star_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case9Star_p500.data(db_Case9Star_p20.data(:,PulseSpikes)>=1,:) = [];
db_Case9Star_p20.data(db_Case9Star_p20.data(:,PulseSpikes)>=1,:) = [];

db_SDprox3_m100.data(db_SDprox3_p20.data(:,PulseSpikes)>=1,:) = []; 
db_SDprox3_p50.data(db_SDprox3_p20.data(:,PulseSpikes)>=1,:) = [];
db_SDprox3_p500.data(db_SDprox3_p20.data(:,PulseSpikes)>=1,:) = [];
db_SDprox3_p20.data(db_SDprox3_p20.data(:,PulseSpikes)>=1,:) = [];

db_SDprox4_m100.data(db_SDprox4_p20.data(:,PulseSpikes)>=1,:) = []; 
db_SDprox4_p50.data(db_SDprox4_p20.data(:,PulseSpikes)>=1,:) = [];
db_SDprox4_p500.data(db_SDprox4_p20.data(:,PulseSpikes)>=1,:) = [];
db_SDprox4_p20.data(db_SDprox4_p20.data(:,PulseSpikes)>=1,:) = [];

% Remove all models containing less than 3 spikes at the 50pA CIP
db_Case1_m100.data(db_Case1_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case1_p500.data(db_Case1_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case1_p20.data(db_Case1_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case1_p50.data(db_Case1_p50.data(:,PulseSpikes)<=2,:) = [];

db_Case7_m100.data(db_Case7_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case7_p500.data(db_Case7_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case7_p20.data(db_Case7_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case7_p50.data(db_Case7_p50.data(:,PulseSpikes)<=2,:) = [];

db_Case8_m100.data(db_Case8_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case8_p500.data(db_Case8_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case8_p20.data(db_Case8_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case8_p50.data(db_Case8_p50.data(:,PulseSpikes)<=2,:) = [];

db_Case8Star_m100.data(db_Case8Star_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case8Star_p500.data(db_Case8Star_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case8Star_p20.data(db_Case8Star_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case8Star_p50.data(db_Case8Star_p50.data(:,PulseSpikes)<=2,:) = [];

db_Case9Star_m100.data(db_Case9Star_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case9Star_p500.data(db_Case9Star_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case9Star_p20.data(db_Case9Star_p50.data(:,PulseSpikes)<=2,:) = [];
db_Case9Star_p50.data(db_Case9Star_p50.data(:,PulseSpikes)<=2,:) = [];

db_SDprox3_m100.data(db_SDprox3_p50.data(:,PulseSpikes)<=2,:) = [];
db_SDprox3_p500.data(db_SDprox3_p50.data(:,PulseSpikes)<=2,:) = [];
db_SDprox3_p20.data(db_SDprox3_p50.data(:,PulseSpikes)<=2,:) = [];
db_SDprox3_p50.data(db_SDprox3_p50.data(:,PulseSpikes)<=2,:) = [];

db_SDprox4_m100.data(db_SDprox4_p50.data(:,PulseSpikes)<=2,:) = [];
db_SDprox4_p500.data(db_SDprox4_p50.data(:,PulseSpikes)<=2,:) = [];
db_SDprox4_p20.data(db_SDprox4_p50.data(:,PulseSpikes)<=2,:) = [];
db_SDprox4_p50.data(db_SDprox4_p50.data(:,PulseSpikes)<=2,:) = [];

% Remove all models containing any spikes in the last 700ms of the 500pA CIP
db_Case1_m100.data(db_Case1_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case1_p20.data(db_Case1_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case1_p50.data(db_Case1_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case1_p500.data(db_Case1_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];

db_Case1_m100.data(db_Case1_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case1_p20.data(db_Case1_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case1_p50.data(db_Case1_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case1_p500.data(db_Case1_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];

db_Case7_m100.data(db_Case7_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case7_p20.data(db_Case7_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case7_p50.data(db_Case7_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case7_p500.data(db_Case7_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];

db_Case7_m100.data(db_Case7_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case7_p20.data(db_Case7_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case7_p50.data(db_Case7_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case7_p500.data(db_Case7_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];

db_Case8_m100.data(db_Case8_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case8_p20.data(db_Case8_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case8_p50.data(db_Case8_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case8_p500.data(db_Case8_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];

db_Case8_m100.data(db_Case8_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case8_p20.data(db_Case8_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case8_p50.data(db_Case8_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case8_p500.data(db_Case8_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];

db_Case8Star_m100.data(db_Case8Star_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case8Star_p20.data(db_Case8Star_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case8Star_p50.data(db_Case8Star_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case8Star_p500.data(db_Case8Star_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];

db_Case8Star_m100.data(db_Case8Star_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case8Star_p20.data(db_Case8Star_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case8Star_p50.data(db_Case8Star_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case8Star_p500.data(db_Case8Star_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];

db_Case9Star_m100.data(db_Case9Star_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case9Star_p20.data(db_Case9Star_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case9Star_p50.data(db_Case9Star_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_Case9Star_p500.data(db_Case9Star_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];

db_Case9Star_m100.data(db_Case9Star_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case9Star_p20.data(db_Case9Star_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case9Star_p50.data(db_Case9Star_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_Case9Star_p500.data(db_Case9Star_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];

db_SDprox3_m100.data(db_SDprox3_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_SDprox3_p20.data(db_SDprox3_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_SDprox3_p50.data(db_SDprox3_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_SDprox3_p500.data(db_SDprox3_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];

db_SDprox3_m100.data(db_SDprox3_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_SDprox3_p20.data(db_SDprox3_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_SDprox3_p50.data(db_SDprox3_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_SDprox3_p500.data(db_SDprox3_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];

db_SDprox4_m100.data(db_SDprox4_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_SDprox4_p20.data(db_SDprox4_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_SDprox4_p50.data(db_SDprox4_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_SDprox4_p500.data(db_SDprox4_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];

db_SDprox4_m100.data(db_SDprox4_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_SDprox4_p20.data(db_SDprox4_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_SDprox4_p50.data(db_SDprox4_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_SDprox4_p500.data(db_SDprox4_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];

% Remove all models containing spikes in the recovery stage of any of the CIPs
db_Case1_p20.data(db_Case1_m100.data(:,RecovSpikes)>0,:) = [];
db_Case1_p50.data(db_Case1_m100.data(:,RecovSpikes)>0,:) = [];
db_Case1_p500.data(db_Case1_m100.data(:,RecovSpikes)>0,:) = [];  
db_Case1_m100.data(db_Case1_m100.data(:,RecovSpikes)>0,:) = [];

db_Case1_m100.data(db_Case1_p20.data(:,RecovSpikes)>0,:) = [];
db_Case1_p50.data(db_Case1_p20.data(:,RecovSpikes)>0,:) = [];
db_Case1_p500.data(db_Case1_p20.data(:,RecovSpikes)>0,:) = [];
db_Case1_p20.data(db_Case1_p20.data(:,RecovSpikes)>0,:) = [];

db_Case1_m100.data(db_Case1_p50.data(:,RecovSpikes)>0,:) = [];
db_Case1_p20.data(db_Case1_p50.data(:,RecovSpikes)>0,:) = [];
db_Case1_p500.data(db_Case1_p50.data(:,RecovSpikes)>0,:) = [];
db_Case1_p50.data(db_Case1_p50.data(:,RecovSpikes)>0,:) = [];

db_Case1_m100.data(db_Case1_p500.data(:,RecovSpikes)>0,:) = [];
db_Case1_p20.data(db_Case1_p500.data(:,RecovSpikes)>0,:) = [];
db_Case1_p50.data(db_Case1_p500.data(:,RecovSpikes)>0,:) = [];
db_Case1_p500.data(db_Case1_p500.data(:,RecovSpikes)>0,:) = [];

db_Case7_p20.data(db_Case7_m100.data(:,RecovSpikes)>0,:) = [];
db_Case7_p50.data(db_Case7_m100.data(:,RecovSpikes)>0,:) = [];
db_Case7_p500.data(db_Case7_m100.data(:,RecovSpikes)>0,:) = [];  
db_Case7_m100.data(db_Case7_m100.data(:,RecovSpikes)>0,:) = [];

db_Case7_m100.data(db_Case7_p20.data(:,RecovSpikes)>0,:) = [];
db_Case7_p50.data(db_Case7_p20.data(:,RecovSpikes)>0,:) = [];
db_Case7_p500.data(db_Case7_p20.data(:,RecovSpikes)>0,:) = [];
db_Case7_p20.data(db_Case7_p20.data(:,RecovSpikes)>0,:) = [];

db_Case7_m100.data(db_Case7_p50.data(:,RecovSpikes)>0,:) = [];
db_Case7_p20.data(db_Case7_p50.data(:,RecovSpikes)>0,:) = [];
db_Case7_p500.data(db_Case7_p50.data(:,RecovSpikes)>0,:) = [];
db_Case7_p50.data(db_Case7_p50.data(:,RecovSpikes)>0,:) = [];

db_Case7_m100.data(db_Case7_p500.data(:,RecovSpikes)>0,:) = [];
db_Case7_p20.data(db_Case7_p500.data(:,RecovSpikes)>0,:) = [];
db_Case7_p50.data(db_Case7_p500.data(:,RecovSpikes)>0,:) = [];
db_Case7_p500.data(db_Case7_p500.data(:,RecovSpikes)>0,:) = [];

db_Case8_p20.data(db_Case8_m100.data(:,RecovSpikes)>0,:) = [];
db_Case8_p50.data(db_Case8_m100.data(:,RecovSpikes)>0,:) = [];
db_Case8_p500.data(db_Case8_m100.data(:,RecovSpikes)>0,:) = [];  
db_Case8_m100.data(db_Case8_m100.data(:,RecovSpikes)>0,:) = [];

db_Case8_m100.data(db_Case8_p20.data(:,RecovSpikes)>0,:) = [];
db_Case8_p50.data(db_Case8_p20.data(:,RecovSpikes)>0,:) = [];
db_Case8_p500.data(db_Case8_p20.data(:,RecovSpikes)>0,:) = [];
db_Case8_p20.data(db_Case8_p20.data(:,RecovSpikes)>0,:) = [];

db_Case8_m100.data(db_Case8_p50.data(:,RecovSpikes)>0,:) = [];
db_Case8_p20.data(db_Case8_p50.data(:,RecovSpikes)>0,:) = [];
db_Case8_p500.data(db_Case8_p50.data(:,RecovSpikes)>0,:) = [];
db_Case8_p50.data(db_Case8_p50.data(:,RecovSpikes)>0,:) = [];

db_Case8_m100.data(db_Case8_p500.data(:,RecovSpikes)>0,:) = [];
db_Case8_p20.data(db_Case8_p500.data(:,RecovSpikes)>0,:) = [];
db_Case8_p50.data(db_Case8_p500.data(:,RecovSpikes)>0,:) = [];
db_Case8_p500.data(db_Case8_p500.data(:,RecovSpikes)>0,:) = [];

db_Case8Star_p20.data(db_Case8Star_m100.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p50.data(db_Case8Star_m100.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p500.data(db_Case8Star_m100.data(:,RecovSpikes)>0,:) = [];  
db_Case8Star_m100.data(db_Case8Star_m100.data(:,RecovSpikes)>0,:) = [];

db_Case8Star_m100.data(db_Case8Star_p20.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p50.data(db_Case8Star_p20.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p500.data(db_Case8Star_p20.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p20.data(db_Case8Star_p20.data(:,RecovSpikes)>0,:) = [];

db_Case8Star_m100.data(db_Case8Star_p50.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p20.data(db_Case8Star_p50.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p500.data(db_Case8Star_p50.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p50.data(db_Case8Star_p50.data(:,RecovSpikes)>0,:) = [];

db_Case8Star_m100.data(db_Case8Star_p500.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p20.data(db_Case8Star_p500.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p50.data(db_Case8Star_p500.data(:,RecovSpikes)>0,:) = [];
db_Case8Star_p500.data(db_Case8Star_p500.data(:,RecovSpikes)>0,:) = [];

db_Case9Star_p20.data(db_Case9Star_m100.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p50.data(db_Case9Star_m100.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p500.data(db_Case9Star_m100.data(:,RecovSpikes)>0,:) = [];  
db_Case9Star_m100.data(db_Case9Star_m100.data(:,RecovSpikes)>0,:) = [];

db_Case9Star_m100.data(db_Case9Star_p20.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p50.data(db_Case9Star_p20.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p500.data(db_Case9Star_p20.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p20.data(db_Case9Star_p20.data(:,RecovSpikes)>0,:) = [];

db_Case9Star_m100.data(db_Case9Star_p50.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p20.data(db_Case9Star_p50.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p500.data(db_Case9Star_p50.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p50.data(db_Case9Star_p50.data(:,RecovSpikes)>0,:) = [];

db_Case9Star_m100.data(db_Case9Star_p500.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p20.data(db_Case9Star_p500.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p50.data(db_Case9Star_p500.data(:,RecovSpikes)>0,:) = [];
db_Case9Star_p500.data(db_Case9Star_p500.data(:,RecovSpikes)>0,:) = [];

db_SDprox3_p20.data(db_SDprox3_m100.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p50.data(db_SDprox3_m100.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p500.data(db_SDprox3_m100.data(:,RecovSpikes)>0,:) = [];  
db_SDprox3_m100.data(db_SDprox3_m100.data(:,RecovSpikes)>0,:) = [];

db_SDprox3_m100.data(db_SDprox3_p20.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p50.data(db_SDprox3_p20.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p500.data(db_SDprox3_p20.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p20.data(db_SDprox3_p20.data(:,RecovSpikes)>0,:) = [];

db_SDprox3_m100.data(db_SDprox3_p50.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p20.data(db_SDprox3_p50.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p500.data(db_SDprox3_p50.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p50.data(db_SDprox3_p50.data(:,RecovSpikes)>0,:) = [];

db_SDprox3_m100.data(db_SDprox3_p500.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p20.data(db_SDprox3_p500.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p50.data(db_SDprox3_p500.data(:,RecovSpikes)>0,:) = [];
db_SDprox3_p500.data(db_SDprox3_p500.data(:,RecovSpikes)>0,:) = [];


%% Plot Histograms
PlotModelHists = 0;
PlotSDproxModelHists = 1;
PlotTopModels = 0;
PlotTopSDproxModels = 1;
PlotLegend = 0;
PlotProbability = 1;
font_size = 25;
font_weight = 'normal';
font_angle = 'normal';

if PlotProbability
    norm = 'probability';
else
    norm = 'count';
end

%%% -100 pA Simulation histograms %%%
figure(1)
h1 = histogram(db_exp_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','k','Normalization',norm);
xlabel('Hyperpolarization V_m Difference (mV)'); ylabel('Percent of Database'); 
% title('-100 pA Measure Histogram for PulseIniSpontPotAvgDiff')
hold on
if PlotModelHists
    histogram(db_Case1_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_m100.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_m100.data(CanonExp1,PulseIniSpontPotAvgDiff)...
    db_exp_m100.data(CanonExp1,PulseIniSpontPotAvgDiff)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_m100.data(1,PulseIniSpontPotAvgDiff)...
        db_1TopModel_m100.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_m100.data(1,PulseIniSpontPotAvgDiff)...
        db_7TopModel_m100.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_m100.data(1,PulseIniSpontPotAvgDiff)...
        db_8TopModel_m100.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_m100.data(1,PulseIniSpontPotAvgDiff)...
        db_8Star_m100.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulseIniSpontPotAvgDiff)...
        db_9Star_m100.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_m100.data(1,PulseIniSpontPotAvgDiff)...
        db_8Star_m100.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulseIniSpontPotAvgDiff)...
        db_9Star_m100.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_m100.data(1,PulseIniSpontPotAvgDiff)...
        db_TopSDprox3_m100.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_m100.data(1,PulseIniSpontPotAvgDiff)...
        db_TopSDprox4_m100.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if 1
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h1,'top')

figure(2)
h2 = histogram(db_exp_m100.data(:,PulsePotMin),10,'FaceColor','k','Normalization',norm);
xlabel('Minimum Potential (mV)'); ylabel('Percent of Database'); 
% title('-100 pA Measure Histogram for PulsePotMin')
hold on
if PlotModelHists
    histogram(db_Case1_m100.data(:,PulsePotMin),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_m100.data(:,PulsePotMin),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_m100.data(:,PulsePotMin),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_m100.data(:,PulsePotMin),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulsePotMin),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_m100.data(:,PulsePotMin),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulsePotMin),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_m100.data(:,PulsePotMin),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_m100.data(:,PulsePotMin),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_m100.data(CanonExp1,PulsePotMin)...
    db_exp_m100.data(CanonExp1,PulsePotMin)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_m100.data(1,PulsePotMin)...
        db_1TopModel_m100.data(1,PulsePotMin)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_m100.data(1,PulsePotMin)...
        db_7TopModel_m100.data(1,PulsePotMin)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_m100.data(1,PulsePotMin)...
        db_8TopModel_m100.data(1,PulsePotMin)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_m100.data(1,PulsePotMin)...
        db_8Star_m100.data(1,PulsePotMin)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulsePotMin)...
        db_9Star_m100.data(1,PulsePotMin)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_m100.data(1,PulsePotMin)...
        db_8Star_m100.data(1,PulsePotMin)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulsePotMin)...
        db_9Star_m100.data(1,PulsePotMin)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_m100.data(1,PulsePotMin)...
        db_TopSDprox3_m100.data(1,PulsePotMin)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_m100.data(1,PulsePotMin)...
        db_TopSDprox4_m100.data(1,PulsePotMin)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h2,'top')

figure(3)
h3 = histogram(db_exp_m100.data(:,PulsePotMinTime),10,'FaceColor','k','Normalization',norm);
xlabel('Minimum Potential Time (ms)'); ylabel('Percent of Database'); 
% title('-100 pA Measure Histogram for PulsePotMinTime')
hold on
if PlotModelHists
    histogram(db_Case1_m100.data(:,PulsePotMinTime),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_m100.data(:,PulsePotMinTime),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_m100.data(:,PulsePotMinTime),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_m100.data(:,PulsePotMinTime),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulsePotMinTime),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_m100.data(:,PulsePotMinTime),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulsePotMinTime),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_m100.data(:,PulsePotMinTime),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_m100.data(:,PulsePotMinTime),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_m100.data(CanonExp1,PulsePotMinTime)...
    db_exp_m100.data(CanonExp1,PulsePotMinTime)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_m100.data(1,PulsePotMinTime)...
        db_1TopModel_m100.data(1,PulsePotMinTime)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_m100.data(1,PulsePotMinTime)...
        db_7TopModel_m100.data(1,PulsePotMinTime)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_m100.data(1,PulsePotMinTime)...
        db_8TopModel_m100.data(1,PulsePotMinTime)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_m100.data(1,PulsePotMinTime)...
        db_8Star_m100.data(1,PulsePotMinTime)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulsePotMinTime)...
        db_9Star_m100.data(1,PulsePotMinTime)], ylim, 'Color','g','LineWidth',2,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_m100.data(1,PulsePotMinTime)...
        db_8Star_m100.data(1,PulsePotMinTime)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulsePotMinTime)...
        db_9Star_m100.data(1,PulsePotMinTime)], ylim, 'Color','g','LineWidth',2,'LineStyle','- -');
    line([db_TopSDprox3_m100.data(1,PulsePotMinTime)...
        db_TopSDprox3_m100.data(1,PulsePotMinTime)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_m100.data(1,PulsePotMinTime)...
        db_TopSDprox4_m100.data(1,PulsePotMinTime)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h3,'top')

figure(4)
h4 = histogram(db_exp_m100.data(:,PulsePotSag),10,'FaceColor','k','Normalization',norm);
xlabel('Potential Sag (mV)'); ylabel('Percent of Database'); 
% title('-100 pA Measure Histogram for PulsePotSag')
hold on
if PlotModelHists
    histogram(db_Case1_m100.data(:,PulsePotSag),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_m100.data(:,PulsePotSag),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_m100.data(:,PulsePotSag),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_m100.data(:,PulsePotSag),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulsePotSag),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_m100.data(:,PulsePotSag),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulsePotSag),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_m100.data(:,PulsePotSag),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_m100.data(:,PulsePotSag),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_m100.data(CanonExp1,PulsePotSag)...
    db_exp_m100.data(CanonExp1,PulsePotSag)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_m100.data(1,PulsePotSag)...
        db_1TopModel_m100.data(1,PulsePotSag)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_m100.data(1,PulsePotSag)...
        db_7TopModel_m100.data(1,PulsePotSag)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_m100.data(1,PulsePotSag)...
        db_8TopModel_m100.data(1,PulsePotSag)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_m100.data(1,PulsePotSag)...
        db_8Star_m100.data(1,PulsePotSag)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulsePotSag)...
        db_9Star_m100.data(1,PulsePotSag)], ylim, 'Color','g','LineWidth',2,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_m100.data(1,PulsePotSag)...
        db_8Star_m100.data(1,PulsePotSag)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulsePotSag)...
        db_9Star_m100.data(1,PulsePotSag)], ylim, 'Color','g','LineWidth',2,'LineStyle','- -');
    line([db_TopSDprox3_m100.data(1,PulsePotSag)...
        db_TopSDprox3_m100.data(1,PulsePotSag)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_m100.data(1,PulsePotSag)...
        db_TopSDprox4_m100.data(1,PulsePotSag)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h4,'top')

figure(5)
h5 = histogram(db_exp_m100.data(:,PulsePotTau),10,'FaceColor','k','Normalization',norm);
xlabel('Sag Time Constant (ms)'); ylabel('Percent of Database'); 
% title('-100 pA Measure Histogram for PulsePotTau')
hold on
if PlotModelHists
    histogram(db_Case1_m100.data(:,PulsePotTau),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_m100.data(:,PulsePotTau),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_m100.data(:,PulsePotTau),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_m100.data(:,PulsePotTau),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulsePotTau),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_m100.data(:,PulsePotTau),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_m100.data(:,PulsePotTau),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_m100.data(:,PulsePotTau),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_m100.data(:,PulsePotTau),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_m100.data(CanonExp1,PulsePotTau)...
    db_exp_m100.data(CanonExp1,PulsePotTau)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_m100.data(1,PulsePotTau)...
        db_1TopModel_m100.data(1,PulsePotTau)], ylim, 'Color','y','LineWidth',2,'LineStyle','- -');
    line([db_7TopModel_m100.data(1,PulsePotTau)...
        db_7TopModel_m100.data(1,PulsePotTau)], ylim, 'Color','m','LineWidth',2,'LineStyle','- -');
    line([db_8TopModel_m100.data(1,PulsePotTau)...
        db_8TopModel_m100.data(1,PulsePotTau)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_m100.data(1,PulsePotTau)...
        db_8Star_m100.data(1,PulsePotTau)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulsePotTau)...
        db_9Star_m100.data(1,PulsePotTau)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_m100.data(1,PulsePotTau)...
        db_8Star_m100.data(1,PulsePotTau)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_m100.data(1,PulsePotTau)...
        db_9Star_m100.data(1,PulsePotTau)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_m100.data(1,PulsePotTau)...
        db_TopSDprox3_m100.data(1,PulsePotTau)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_m100.data(1,PulsePotTau)...
        db_TopSDprox4_m100.data(1,PulsePotTau)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h5,'top')

%%% 20 pA Simulation histograms %%%
figure(6)
h6 = histogram(db_exp_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','k','Normalization',norm);
xlabel('Passive Depolarization V_m Difference (mV)'); ylabel('Percent of Database'); 
% title('20 pA Measure Histogram for PulseIniSpontPotAvgDiff')
hold on
if PlotModelHists
    histogram(db_Case1_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p20.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p20.data(CanonExp2,PulseIniSpontPotAvgDiff)...
    db_exp_p20.data(CanonExp2,PulseIniSpontPotAvgDiff)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p20.data(1,PulseIniSpontPotAvgDiff)...
        db_1TopModel_p20.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','y','LineWidth',2,'LineStyle','- -');
    line([db_7TopModel_p20.data(1,PulseIniSpontPotAvgDiff)...
        db_7TopModel_p20.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','m','LineWidth',2,'LineStyle','- -');
    line([db_8TopModel_p20.data(1,PulseIniSpontPotAvgDiff)...
        db_8TopModel_p20.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p20.data(1,PulseIniSpontPotAvgDiff)...
        db_8Star_p20.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p20.data(1,PulseIniSpontPotAvgDiff)...
        db_9Star_p20.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p20.data(1,PulseIniSpontPotAvgDiff)...
        db_8Star_p20.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p20.data(1,PulseIniSpontPotAvgDiff)...
        db_9Star_p20.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p20.data(1,PulseIniSpontPotAvgDiff)...
        db_TopSDprox3_p20.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p20.data(1,PulseIniSpontPotAvgDiff)...
        db_TopSDprox4_p20.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h6,'top')

figure(7)
h7 = histogram(db_exp_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor','k','Normalization',norm);
xlabel('Frequency at Max Theta Peak (Hz)'); ylabel('Percent of Database'); 
% title('20 pA Measure Histogram for FreqAtMaxThetaPeak')
hold on
if PlotModelHists
    histogram(db_Case1_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p20.data(:,FreqAtMaxThetaPeak),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p20.data(CanonExp2,FreqAtMaxThetaPeak)...
    db_exp_p20.data(CanonExp2,FreqAtMaxThetaPeak)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p20.data(1,FreqAtMaxThetaPeak)...
        db_1TopModel_p20.data(1,FreqAtMaxThetaPeak)], ylim, 'Color','y','LineWidth',2,'LineStyle','- -');
    line([db_7TopModel_p20.data(1,FreqAtMaxThetaPeak)...
        db_7TopModel_p20.data(1,FreqAtMaxThetaPeak)], ylim, 'Color','m','LineWidth',2,'LineStyle','- -');
    line([db_8TopModel_p20.data(1,FreqAtMaxThetaPeak)...
        db_8TopModel_p20.data(1,FreqAtMaxThetaPeak)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p20.data(1,FreqAtMaxThetaPeak)...
        db_8Star_p20.data(1,FreqAtMaxThetaPeak)], ylim, 'Color','r','LineWidth',4,'LineStyle','- -');
    line([db_9Star_p20.data(1,FreqAtMaxThetaPeak)...
        db_9Star_p20.data(1,FreqAtMaxThetaPeak)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p20.data(1,FreqAtMaxThetaPeak)...
        db_8Star_p20.data(1,FreqAtMaxThetaPeak)], ylim, 'Color','r','LineWidth',4,'LineStyle','- -');
    line([db_9Star_p20.data(1,FreqAtMaxThetaPeak)...
        db_9Star_p20.data(1,FreqAtMaxThetaPeak)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p20.data(1,FreqAtMaxThetaPeak)...
        db_TopSDprox3_p20.data(1,FreqAtMaxThetaPeak)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p20.data(1,FreqAtMaxThetaPeak)...
        db_TopSDprox4_p20.data(1,FreqAtMaxThetaPeak)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h7,'top')

figure(8)
h8 = histogram(db_exp_p20.data(:,ThetaPower),10,'FaceColor','k','Normalization',norm);
xlabel('Theta Power ((mV^2/Hz)^2)'); ylabel('Percent of Database'); 
% title('20 pA Measure Histogram for ThetaPower')
hold on
if PlotModelHists
    histogram(db_Case1_p20.data(:,ThetaPower),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p20.data(:,ThetaPower),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p20.data(:,ThetaPower),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p20.data(:,ThetaPower),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p20.data(:,ThetaPower),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p20.data(:,ThetaPower),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p20.data(:,ThetaPower),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p20.data(:,ThetaPower),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p20.data(:,ThetaPower),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p20.data(CanonExp2,ThetaPower)...
    db_exp_p20.data(CanonExp2,ThetaPower)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p20.data(1,ThetaPower)...
        db_1TopModel_p20.data(1,ThetaPower)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p20.data(1,ThetaPower)...
        db_7TopModel_p20.data(1,ThetaPower)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p20.data(1,ThetaPower)...
        db_8TopModel_p20.data(1,ThetaPower)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p20.data(1,ThetaPower)...
        db_8Star_p20.data(1,ThetaPower)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p20.data(1,ThetaPower)...
        db_9Star_p20.data(1,ThetaPower)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p20.data(1,ThetaPower)...
        db_8Star_p20.data(1,ThetaPower)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p20.data(1,ThetaPower)...
        db_9Star_p20.data(1,ThetaPower)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p20.data(1,ThetaPower)...
        db_TopSDprox3_p20.data(1,ThetaPower)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p20.data(1,ThetaPower)...
        db_TopSDprox4_p20.data(1,ThetaPower)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h8,'top')

%%% 50 pA Simulation histograms %%%
figure(9)
h9 = histogram(db_exp_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','k','Normalization',norm);
xlabel('Active Depolarization V_m Difference (mV)'); ylabel('Percent of Database'); 
% title('50 pA Measure Histogram for PulseIniSpontPotAvgDiff')
hold on
if PlotModelHists
    histogram(db_Case1_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseIniSpontPotAvgDiff),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseIniSpontPotAvgDiff)...
    db_exp_p50.data(CanonExp3,PulseIniSpontPotAvgDiff)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p50.data(1,PulseIniSpontPotAvgDiff)...
        db_1TopModel_p50.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseIniSpontPotAvgDiff)...
        db_7TopModel_p50.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseIniSpontPotAvgDiff)...
        db_8TopModel_p50.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p50.data(1,PulseIniSpontPotAvgDiff)...
        db_8Star_p50.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseIniSpontPotAvgDiff)...
        db_9Star_p50.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseIniSpontPotAvgDiff)...
        db_8Star_p50.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseIniSpontPotAvgDiff)...
        db_9Star_p50.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseIniSpontPotAvgDiff)...
        db_TopSDprox3_p50.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseIniSpontPotAvgDiff)...
        db_TopSDprox4_p50.data(1,PulseIniSpontPotAvgDiff)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h9,'top')

figure(10)
h10 = histogram(db_exp_p50.data(:,PulseFirstSpikeTime),10,'FaceColor','k','Normalization',norm);
xlabel('First Spike Time (ms)'); ylabel('Percent of Database'); 
% title('50 pA Measure Histogram for PulseFirstSpikeTime')
hold on
if PlotModelHists
%     histogram(db_Case1_p50.data(:,PulseFirstSpikeTime),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseFirstSpikeTime),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseFirstSpikeTime),10,'FaceColor','b','Normalization',norm);
%     histogram(db_Case8Star_p50.data(:,PulseFirstSpikeTime),10,'FaceColor','r','Normalization',norm);
%     histogram(db_Case9Star_p50.data(:,PulseFirstSpikeTime),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseFirstSpikeTime),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseFirstSpikeTime),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseFirstSpikeTime),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseFirstSpikeTime),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseFirstSpikeTime)...
    db_exp_p50.data(CanonExp3,PulseFirstSpikeTime)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
%     line([db_1TopModel_p50.data(1,PulseFirstSpikeTime)...
%         db_1TopModel_p50.data(1,PulseFirstSpikeTime)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseFirstSpikeTime)...
        db_7TopModel_p50.data(1,PulseFirstSpikeTime)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseFirstSpikeTime)...
        db_8TopModel_p50.data(1,PulseFirstSpikeTime)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
%     line([db_8Star_p50.data(1,PulseFirstSpikeTime)...
%         db_8Star_p50.data(1,PulseFirstSpikeTime)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
%     line([db_9Star_p50.data(1,PulseFirstSpikeTime)...
%         db_9Star_p50.data(1,PulseFirstSpikeTime)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseFirstSpikeTime)...
        db_8Star_p50.data(1,PulseFirstSpikeTime)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseFirstSpikeTime)...
        db_9Star_p50.data(1,PulseFirstSpikeTime)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseFirstSpikeTime)...
        db_TopSDprox3_p50.data(1,PulseFirstSpikeTime)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseFirstSpikeTime)...
        db_TopSDprox4_p50.data(1,PulseFirstSpikeTime)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.2 Database','SD Database','Selected IS3') % For paper
%         legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
% legend('IS3 Database','S.2 Database','SD Database','Selected IS3')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h10,'top')

figure(11)
h11 = histogram(db_exp_p50.data(:,PulseSFA),10,'FaceColor','k','Normalization',norm);
xlabel('Spike Frequency Adaptation'); ylabel('Percent of Database'); 
% title('50 pA Measure Histogram for PulseSFA')
hold on
if PlotModelHists
    histogram(db_Case1_p50.data(:,PulseSFA),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseSFA),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseSFA),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p50.data(:,PulseSFA),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSFA),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseSFA),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSFA),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseSFA),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseSFA),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseSFA)...
    db_exp_p50.data(CanonExp3,PulseSFA)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p50.data(1,PulseSFA)...
        db_1TopModel_p50.data(1,PulseSFA)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseSFA)...
        db_7TopModel_p50.data(1,PulseSFA)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseSFA)...
        db_8TopModel_p50.data(1,PulseSFA)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p50.data(1,PulseSFA)...
        db_8Star_p50.data(1,PulseSFA)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSFA)...
        db_9Star_p50.data(1,PulseSFA)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseSFA)...
        db_8Star_p50.data(1,PulseSFA)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSFA)...
        db_9Star_p50.data(1,PulseSFA)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseSFA)...
        db_TopSDprox3_p50.data(1,PulseSFA)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseSFA)...
        db_TopSDprox4_p50.data(1,PulseSFA)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h11,'top')

figure(12)
h12 = histogram(db_exp_p50.data(:,PulseSpikeRate),10,'FaceColor','k','Normalization',norm);
xlabel('Spike Rate (Hz)'); ylabel('Percent of Database'); 
% title('50 pA Measure Histogram for PulseSpikeRate')
hold on
if PlotModelHists
    histogram(db_Case1_p50.data(:,PulseSpikeRate),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseSpikeRate),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseSpikeRate),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p50.data(:,PulseSpikeRate),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeRate),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseSpikeRate),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeRate),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseSpikeRate),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseSpikeRate),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseSpikeRate)...
    db_exp_p50.data(CanonExp3,PulseSpikeRate)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p50.data(1,PulseSpikeRate)...
        db_1TopModel_p50.data(1,PulseSpikeRate)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseSpikeRate)...
        db_7TopModel_p50.data(1,PulseSpikeRate)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseSpikeRate)...
        db_8TopModel_p50.data(1,PulseSpikeRate)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p50.data(1,PulseSpikeRate)...
        db_8Star_p50.data(1,PulseSpikeRate)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeRate)...
        db_9Star_p50.data(1,PulseSpikeRate)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseSpikeRate)...
        db_8Star_p50.data(1,PulseSpikeRate)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeRate)...
        db_9Star_p50.data(1,PulseSpikeRate)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseSpikeRate)...
        db_TopSDprox3_p50.data(1,PulseSpikeRate)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseSpikeRate)...
        db_TopSDprox4_p50.data(1,PulseSpikeRate)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h12,'top')

figure(13)
h13 = histogram(db_exp_p50.data(:,PulseSpikeRateISI),10,'FaceColor','k','Normalization',norm);
xlabel('Interspike Interval (ms)'); ylabel('Percent of Database'); 
% title('50 pA Measure Histogram for PulseSpikeRateISI')
hold on
if PlotModelHists
    histogram(db_Case1_p50.data(:,PulseSpikeRateISI),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseSpikeRateISI),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseSpikeRateISI),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p50.data(:,PulseSpikeRateISI),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeRateISI),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseSpikeRateISI),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeRateISI),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseSpikeRateISI),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseSpikeRateISI),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseSpikeRateISI)...
    db_exp_p50.data(CanonExp3,PulseSpikeRateISI)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p50.data(1,PulseSpikeRateISI)...
        db_1TopModel_p50.data(1,PulseSpikeRateISI)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseSpikeRateISI)...
        db_7TopModel_p50.data(1,PulseSpikeRateISI)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseSpikeRateISI)...
        db_8TopModel_p50.data(1,PulseSpikeRateISI)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p50.data(1,PulseSpikeRateISI)...
        db_8Star_p50.data(1,PulseSpikeRateISI)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeRateISI)...
        db_9Star_p50.data(1,PulseSpikeRateISI)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseSpikeRateISI)...
        db_8Star_p50.data(1,PulseSpikeRateISI)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeRateISI)...
        db_9Star_p50.data(1,PulseSpikeRateISI)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseSpikeRateISI)...
        db_TopSDprox3_p50.data(1,PulseSpikeRateISI)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseSpikeRateISI)...
        db_TopSDprox4_p50.data(1,PulseSpikeRateISI)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h13,'top')

figure(14)
h14 = histogram(db_exp_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor','k','Normalization',norm);
xlabel('Spike Amplitude Mean (mV)'); ylabel('Percent of Database'); 
% title('50 pA Measure Histogram for PulseSpikeAmplitudeMean')
hold on
if PlotModelHists
    histogram(db_Case1_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseSpikeAmplitudeMean),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseSpikeAmplitudeMean)...
    db_exp_p50.data(CanonExp3,PulseSpikeAmplitudeMean)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p50.data(1,PulseSpikeAmplitudeMean)...
        db_1TopModel_p50.data(1,PulseSpikeAmplitudeMean)], ylim, 'Color','y','LineWidth',2,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseSpikeAmplitudeMean)...
        db_7TopModel_p50.data(1,PulseSpikeAmplitudeMean)], ylim, 'Color','m','LineWidth',2,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseSpikeAmplitudeMean)...
        db_8TopModel_p50.data(1,PulseSpikeAmplitudeMean)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p50.data(1,PulseSpikeAmplitudeMean)...
        db_8Star_p50.data(1,PulseSpikeAmplitudeMean)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeAmplitudeMean)...
        db_9Star_p50.data(1,PulseSpikeAmplitudeMean)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseSpikeAmplitudeMean)...
        db_8Star_p50.data(1,PulseSpikeAmplitudeMean)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeAmplitudeMean)...
        db_9Star_p50.data(1,PulseSpikeAmplitudeMean)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseSpikeAmplitudeMean)...
        db_TopSDprox3_p50.data(1,PulseSpikeAmplitudeMean)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseSpikeAmplitudeMean)...
        db_TopSDprox4_p50.data(1,PulseSpikeAmplitudeMean)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h14,'top')

figure(15)
h15 = histogram(db_exp_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor','k','Normalization',norm);
xlabel('Spike Half Width Mean (ms)'); ylabel('Percent of Database'); 
% title('50 pA Measure Histogram for PulseSpikeHalfWidthMean')
hold on
if PlotModelHists
    histogram(db_Case1_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor','b','Normalization',norm);
%     histogram(db_Case8Star_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor','r','Normalization',norm);
%     histogram(db_Case9Star_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseSpikeHalfWidthMean),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseSpikeHalfWidthMean)...
    db_exp_p50.data(CanonExp3,PulseSpikeHalfWidthMean)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p50.data(1,PulseSpikeHalfWidthMean)...
        db_1TopModel_p50.data(1,PulseSpikeHalfWidthMean)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseSpikeHalfWidthMean)...
        db_7TopModel_p50.data(1,PulseSpikeHalfWidthMean)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseSpikeHalfWidthMean)...
        db_8TopModel_p50.data(1,PulseSpikeHalfWidthMean)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
%     line([db_8Star_p50.data(1,PulseSpikeHalfWidthMean)...
%         db_8Star_p50.data(1,PulseSpikeHalfWidthMean)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
%     line([db_9Star_p50.data(1,PulseSpikeHalfWidthMean)...
%         db_9Star_p50.data(1,PulseSpikeHalfWidthMean)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseSpikeHalfWidthMean)...
        db_8Star_p50.data(1,PulseSpikeHalfWidthMean)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeHalfWidthMean)...
        db_9Star_p50.data(1,PulseSpikeHalfWidthMean)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseSpikeHalfWidthMean)...
        db_TopSDprox3_p50.data(1,PulseSpikeHalfWidthMean)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseSpikeHalfWidthMean)...
        db_TopSDprox4_p50.data(1,PulseSpikeHalfWidthMean)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','Selected IS3') % For paper
%         legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
% legend('IS3 Database','S.1 Database','S.2 Database','SD Database','Selected IS3')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h15,'top')

figure(16)
h16 = histogram(db_exp_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor','k','Normalization',norm);
xlabel('Spike Voltage Threshold Mean (mV)'); ylabel('Percent of Database'); 
% title('50 pA Histogram for Spike Voltage Threshold Mean')
hold on
if PlotModelHists
    histogram(db_Case1_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseSpikeInitVmMean),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseSpikeInitVmMean)...
    db_exp_p50.data(CanonExp3,PulseSpikeInitVmMean)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p50.data(1,PulseSpikeInitVmMean)...
        db_1TopModel_p50.data(1,PulseSpikeInitVmMean)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseSpikeInitVmMean)...
        db_7TopModel_p50.data(1,PulseSpikeInitVmMean)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseSpikeInitVmMean)...
        db_8TopModel_p50.data(1,PulseSpikeInitVmMean)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p50.data(1,PulseSpikeInitVmMean)...
        db_8Star_p50.data(1,PulseSpikeInitVmMean)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeInitVmMean)...
        db_9Star_p50.data(1,PulseSpikeInitVmMean)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseSpikeInitVmMean)...
        db_8Star_p50.data(1,PulseSpikeInitVmMean)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeInitVmMean)...
        db_9Star_p50.data(1,PulseSpikeInitVmMean)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseSpikeInitVmMean)...
        db_TopSDprox3_p50.data(1,PulseSpikeInitVmMean)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseSpikeInitVmMean)...
        db_TopSDprox4_p50.data(1,PulseSpikeInitVmMean)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h16,'top')

figure(17)
h17 = histogram(db_exp_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor','k','Normalization',norm);
xlabel('Spike Max After-Hyperpolarization Mean (mV)'); ylabel('Percent of Database'); 
% title('50 pA Histogram for Spike Max AHP Mean')
hold on
if PlotModelHists
    histogram(db_Case1_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseSpikeMaxAHPMean),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseSpikeMaxAHPMean)...
    db_exp_p50.data(CanonExp3,PulseSpikeMaxAHPMean)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p50.data(1,PulseSpikeMaxAHPMean)...
        db_1TopModel_p50.data(1,PulseSpikeMaxAHPMean)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseSpikeMaxAHPMean)...
        db_7TopModel_p50.data(1,PulseSpikeMaxAHPMean)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseSpikeMaxAHPMean)...
        db_8TopModel_p50.data(1,PulseSpikeMaxAHPMean)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p50.data(1,PulseSpikeMaxAHPMean)...
        db_8Star_p50.data(1,PulseSpikeMaxAHPMean)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeMaxAHPMean)...
        db_9Star_p50.data(1,PulseSpikeMaxAHPMean)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseSpikeMaxAHPMean)...
        db_8Star_p50.data(1,PulseSpikeMaxAHPMean)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikeMaxAHPMean)...
        db_9Star_p50.data(1,PulseSpikeMaxAHPMean)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseSpikeMaxAHPMean)...
        db_TopSDprox3_p50.data(1,PulseSpikeMaxAHPMean)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseSpikeMaxAHPMean)...
        db_TopSDprox4_p50.data(1,PulseSpikeMaxAHPMean)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h17,'top')

figure(18)
h18 = histogram(db_exp_p50.data(:,PulseSpikes),10,'FaceColor','k','Normalization',norm);
xlabel('Number of Spikes'); ylabel('Percent of Database'); 
% title('50 pA Measure Histogram for PulseSpikes')
hold on
if PlotModelHists
    histogram(db_Case1_p50.data(:,PulseSpikes),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p50.data(:,PulseSpikes),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p50.data(:,PulseSpikes),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p50.data(:,PulseSpikes),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikes),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p50.data(:,PulseSpikes),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p50.data(:,PulseSpikes),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p50.data(:,PulseSpikes),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p50.data(:,PulseSpikes),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p50.data(CanonExp3,PulseSpikes)...
    db_exp_p50.data(CanonExp3,PulseSpikes)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p50.data(1,PulseSpikes)...
        db_1TopModel_p50.data(1,PulseSpikes)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p50.data(1,PulseSpikes)...
        db_7TopModel_p50.data(1,PulseSpikes)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p50.data(1,PulseSpikes)...
        db_8TopModel_p50.data(1,PulseSpikes)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p50.data(1,PulseSpikes)...
        db_8Star_p50.data(1,PulseSpikes)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikes)...
        db_9Star_p50.data(1,PulseSpikes)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p50.data(1,PulseSpikes)...
        db_8Star_p50.data(1,PulseSpikes)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p50.data(1,PulseSpikes)...
        db_9Star_p50.data(1,PulseSpikes)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p50.data(1,PulseSpikes)...
        db_TopSDprox3_p50.data(1,PulseSpikes)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p50.data(1,PulseSpikes)...
        db_TopSDprox4_p50.data(1,PulseSpikes)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h18,'top')

%%% 500 pA Simulation histograms %%%
figure(19)
h19 = histogram(db_exp_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor','k','Normalization',norm);
xlabel('Depolarization Block V_m Difference (mV)'); ylabel('Percent of Database'); 
% title('500 pA Measure Histogram for PulseIni100msRestIniSpontPotAvgDiff')
hold on
if PlotModelHists
    histogram(db_Case1_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p500.data(CanonExp4,PulseIni100msRestIniSpontPotAvgDiff)...
    db_exp_p500.data(CanonExp4,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)...
        db_1TopModel_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)...
        db_7TopModel_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)...
        db_8TopModel_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)...
        db_8Star_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)...
        db_9Star_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)...
        db_8Star_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)...
        db_9Star_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)...
        db_TopSDprox3_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)...
        db_TopSDprox4_p500.data(1,PulseIni100msRestIniSpontPotAvgDiff)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h19,'top')

figure(20)
h20 = histogram(db_exp_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor','k','Normalization',norm);
xlabel('Initial 100 ms Spike Rate (Hz)'); ylabel('Percent of Database'); 
% title('500 pA Measure Histogram for PulseIni100msSpikeRate')
hold on
if PlotModelHists
    histogram(db_Case1_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor','y','Normalization',norm);
    histogram(db_Case7_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor','m','Normalization',norm);
    histogram(db_Case8_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor','b','Normalization',norm);
    histogram(db_Case8Star_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor','g','Normalization',norm);
end
if PlotSDproxModelHists
    histogram(db_Case8Star_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor','r','Normalization',norm);
    histogram(db_Case9Star_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor','g','Normalization',norm);
    histogram(db_SDprox3_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor',[0.5 0 0],'Normalization',norm);
    histogram(db_SDprox4_p500.data(:,PulseIni100msSpikeRate),10,'FaceColor',[0 0.5 0],'Normalization',norm);
end
line([db_exp_p500.data(CanonExp4,PulseIni100msSpikeRate)...
    db_exp_p500.data(CanonExp4,PulseIni100msSpikeRate)], ylim, 'Color','k','LineWidth',3,'LineStyle','- -');
if PlotTopModels
    line([db_1TopModel_p500.data(1,PulseIni100msSpikeRate)...
        db_1TopModel_p500.data(1,PulseIni100msSpikeRate)], ylim, 'Color','y','LineWidth',3,'LineStyle','- -');
    line([db_7TopModel_p500.data(1,PulseIni100msSpikeRate)...
        db_7TopModel_p500.data(1,PulseIni100msSpikeRate)], ylim, 'Color','m','LineWidth',3,'LineStyle','- -');
    line([db_8TopModel_p500.data(1,PulseIni100msSpikeRate)...
        db_8TopModel_p500.data(1,PulseIni100msSpikeRate)], ylim, 'Color','b','LineWidth',3,'LineStyle','- -');
    line([db_8Star_p500.data(1,PulseIni100msSpikeRate)...
        db_8Star_p500.data(1,PulseIni100msSpikeRate)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p500.data(1,PulseIni100msSpikeRate)...
        db_9Star_p500.data(1,PulseIni100msSpikeRate)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
end
if PlotTopSDproxModels
    line([db_8Star_p500.data(1,PulseIni100msSpikeRate)...
        db_8Star_p500.data(1,PulseIni100msSpikeRate)], ylim, 'Color','r','LineWidth',3,'LineStyle','- -');
    line([db_9Star_p500.data(1,PulseIni100msSpikeRate)...
        db_9Star_p500.data(1,PulseIni100msSpikeRate)], ylim, 'Color','g','LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox3_p500.data(1,PulseIni100msSpikeRate)...
        db_TopSDprox3_p500.data(1,PulseIni100msSpikeRate)], ylim, 'Color',[0.5 0 0],'LineWidth',3,'LineStyle','- -');
    line([db_TopSDprox4_p500.data(1,PulseIni100msSpikeRate)...
        db_TopSDprox4_p500.data(1,PulseIni100msSpikeRate)], ylim, 'Color',[0 0.5 0],'LineWidth',3,'LineStyle','- -');
end
hold off
if PlotLegend
    if PlotModelHists && PlotTopModels
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database',...
            'Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists == 0 && PlotTopModels
        legend('IS3 Database','Selected IS3','S.1 Best','S.2 Best','SD Best','SDprox.1 Best','SDprox.2 Best','Location','north')
    elseif PlotModelHists && PlotTopModels == 0
        legend('IS3 Database','S.1 Database','S.2 Database','SD Database','SDprox.1 Database','SDprox.2 Database','Selected IS3')
    elseif PlotModelHists == 0 && PlotTopModels == 0 && PlotSDproxModelHists == 0 && PlotTopSDproxModels == 0
        legend('IS3 Database','Selected IS3')
    elseif PlotSDproxModelHists && PlotTopSDproxModels
        legend('IS3 Database','SDprox.1 Database','SDprox.2 Database','SDprox.3 Database','SDprox.4 Database','Selected IS3','SDprox.1 Best','SDprox.2 Best','SDprox.3 Best','SDprox.4 Best','Location','north')
    end
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
uistack(h20,'top')

%%
toc