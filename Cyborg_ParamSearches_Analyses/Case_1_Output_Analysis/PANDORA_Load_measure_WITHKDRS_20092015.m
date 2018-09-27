tic
clear
close all

addpath('~/Dropbox/MSC_THESIS/Pandora 1.3b/pandora')
addpath('~/Dropbox/MSC_THESIS/Pandora_Matlab - In Progress Scripts/stack-ordering')

font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

%% This script loads experimental & simulation IS3 data files using PANDORA
%% fileset functions, measures the voltage traces within and then provides
%% a distance metric between the simulation traces and the experimental
%% traces

%% Parameters
dt_exp = 0.0001; % in seconds
dy_exp = 0.001;
cip_start_exp = 2500;
cip_end_exp = 8000;

dt_sim = 0.0001;
dy_sim = 0.001;
cip_start_sim = 2500;
cip_end_sim = 8000;

TopDirExp = '~/Dropbox/MSC_THESIS/NEURON_files/IS3_ExpRuns/';
TopDirExp1 = [TopDirExp '*_-100_pA.mat'];
TopDirExp2 = [TopDirExp '*_20_pA.mat'];
TopDirExp3 = [TopDirExp '*_50_pA.mat'];
TopDirExp4 = [TopDirExp '*_500_pA.mat'];

Case = 'Case 1';
% TopDirSim = '~/Documents/Simulation runs/Case 1/';
TopDirSim = '~/Desktop/SkinnerLab/Usages/Case_1_Output_Analysis/Case1Output/';
% TopDirSim = '~/Dropbox/MSC_THESIS/NEURON_files/IS3_SimRuns/';
TopDirSim1 = [TopDirSim '*_-0.1_InjectionMagnitude.dat'];
TopDirSim2 = [TopDirSim '*_0.02_InjectionMagnitude.dat'];
TopDirSim3 = [TopDirSim '*_0.05_InjectionMagnitude.dat'];
TopDirSim4 = [TopDirSim '*_0.5_InjectionMagnitude.dat'];

%% Experimental Database

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

critm100file = 2; % which criterion trace to use (out of 2 files) %2
critm100 =  fileset_exp_m100.list(critm100file); % File name of criterion trace
critp20file = 1; %1
critp20 = fileset_exp_p20.list(critp20file);
critp50file = 2; %2
critp50 = fileset_exp_p50.list(critp50file);
critp500file = 2; %2
critp500 = fileset_exp_p500.list(critp500file);

db_exp_m100 = params_tests_db(fileset_exp_m100);
db_exp_p20 = params_tests_db(fileset_exp_p20);
db_exp_p50 = params_tests_db(fileset_exp_p50);
db_exp_p500 = params_tests_db(fileset_exp_p500);

%% Simulation Database

props_sim = struct('num_params',6,'type','sim','file_type','neuron','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');

fileset_sim_m100 = params_cip_trace_fileset(TopDirSim1,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_sim_p20 = params_cip_trace_fileset(TopDirSim2,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_sim_p50 = params_cip_trace_fileset(TopDirSim3,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);
fileset_sim_p500 = params_cip_trace_fileset(TopDirSim4,...
    dt_sim,dy_sim,cip_start_sim,cip_end_sim,'Sim Dataset',props_sim);

db_sim_m100 = params_tests_db(fileset_sim_m100);
db_sim_p20 = params_tests_db(fileset_sim_p20);
db_sim_p50 = params_tests_db(fileset_sim_p50);
db_sim_p500 = params_tests_db(fileset_sim_p500);

%% Pre-processing (i.e. removing models that clearly don't capture the signature features)
PulseIni100msRest1SpikeRate = 16; % Number from column index in tests_db
PulseIni100msRest2SpikeRate = 18;
PulseIni100msSpikeRate = 22;
PulseSpikes = 151;

% Save old databases
m100db = db_sim_m100.data;
p20db = db_sim_p20.data;
p50db = db_sim_p50.data;
p500db = db_sim_p500.data;

% Remove all models containing any spikes at the 20pA CIP
db_sim_m100.data(db_sim_p20.data(:,PulseSpikes)>=1,:) = []; 
db_sim_p50.data(db_sim_p20.data(:,PulseSpikes)>=1,:) = [];
db_sim_p500.data(db_sim_p20.data(:,PulseSpikes)>=1,:) = [];
db_sim_p20.data(db_sim_p20.data(:,PulseSpikes)>=1,:) = [];

% Remove all models containing less than 3 spikes at the 50pA CIP
db_sim_m100.data(db_sim_p50.data(:,PulseSpikes)<=2,:) = [];
db_sim_p500.data(db_sim_p50.data(:,PulseSpikes)<=2,:) = [];
db_sim_p20.data(db_sim_p50.data(:,PulseSpikes)<=2,:) = [];
db_sim_p50.data(db_sim_p50.data(:,PulseSpikes)<=2,:) = [];

% Remove all models containing any spikes in the last 700ms of the 500pA CIP
db_sim_m100.data(db_sim_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_sim_p20.data(db_sim_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_sim_p50.data(db_sim_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];
db_sim_p500.data(db_sim_p500.data(:,PulseIni100msRest1SpikeRate)>0,:) = [];

db_sim_m100.data(db_sim_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_sim_p20.data(db_sim_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_sim_p50.data(db_sim_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
db_sim_p500.data(db_sim_p500.data(:,PulseIni100msRest2SpikeRate)>0,:) = [];
% 
% % Removes all models not containing any spikes in the first 100ms of the 500pA CIP
% db_sim_m100.data(db_sim_p500.data(:,PulseIni100msSpikeRate)==0,:) = [];
% db_sim_p20.data(db_sim_p500.data(:,PulseIni100msSpikeRate)==0,:) = [];
% db_sim_p50.data(db_sim_p500.data(:,PulseIni100msSpikeRate)==0,:) = [];
% db_sim_p500.data(db_sim_p500.data(:,PulseIni100msSpikeRate)==0,:) = [];
    
%% Ranking

Tests_m100 = {'PulsePotMin','PulsePotMinTime','PulsePotSag','PulsePotTau','PulseIniSpontPotAvgDiff'}; 
Tests_p20 = {'FreqAtMaxThetaPeak','ThetaPower','PulseIniSpontPotAvgDiff'};
Tests_p50 = {'PulseFirstSpikeTime','PulseSFA','PulseSpikeRate','PulseSpikeRateISI',...
    'PulseSpikeAmplitudeMean','PulseSpikeHalfWidthMean','PulseSpikeInitVmMean','PulseSpikeMaxAHPMean',...
    'PulseSpikes','PulseIniSpontPotAvgDiff'};
Tests_p500 = {'PulseIni100msSpikeRate','PulseIni100msRestIniSpontPotAvgDiff'};

% Create a criterion database and rank the models against the criterion
crit_db_m100 = matchingRow(db_exp_m100(:,Tests_m100),critm100file);
crit_db_p20 = matchingRow(db_exp_p20(:,Tests_p20),critp20file);
crit_db_p50 = matchingRow(db_exp_p50(:,Tests_p50),critp50file);
crit_db_p500 = matchingRow(db_exp_p500(:,Tests_p500),critp500file);

% Replace standard deviation in criterion so that sum((xi-yi)/(N*SD)) becomes simply sum((xi-yi)/N)
crit_db_m100.data(2,1:end-1) = 1; % i.e. SD = 1
crit_db_p20.data(2,1:end-1) = 1;
crit_db_p50.data(2,1:end-1) = 1;
crit_db_p50.data(2,5) = 0.01; % Puts  a lot of extra weight on amplitude measurements
crit_db_p500.data(2,1:end-1) = 1;

ranked_db_m100 = rankMatching(db_sim_m100,crit_db_m100,struct('tolerateNaNs',0)); % Note: "testWeights" in props
ranked_db_p20 = rankMatching(db_sim_p20,crit_db_p20,struct('tolerateNaNs',0));
ranked_db_p50 = rankMatching(db_sim_p50,crit_db_p50,struct('tolerateNaNs',0));
ranked_db_p500 = rankMatching(db_sim_p500,crit_db_p500,struct('tolerateNaNs',0));

% Sort rows of the ranked database by the model number
rdb_m100_sortedbyModNum = sortrows(ranked_db_m100.data,length(ranked_db_m100.data(1,:)));
rdb_p20_sortedbyModNum = sortrows(ranked_db_p20.data,length(ranked_db_p20.data(1,:)));
rdb_p50_sortedbyModNum = sortrows(ranked_db_p50.data,length(ranked_db_p50.data(1,:)));
rdb_p500_sortedbyModNum = sortrows(ranked_db_p500.data,length(ranked_db_p500.data(1,:)));

% Normalize the distance values so that they are values between 0 and 1 (i.e. dot divide each vector by it's own max value)
normrankm100 = rdb_m100_sortedbyModNum(:,length(ranked_db_m100.data(1,:))-1) ./ ...
    max(rdb_m100_sortedbyModNum(:,length(ranked_db_m100.data(1,:))-1));
normrankp20 = rdb_p20_sortedbyModNum(:,length(ranked_db_p20.data(1,:))-1) ./ ...
    max(rdb_p20_sortedbyModNum(:,length(ranked_db_p20.data(1,:))-1));
normrankp50 = rdb_p50_sortedbyModNum(:,length(ranked_db_p50.data(1,:))-1) ./ ...
    max(rdb_p50_sortedbyModNum(:,length(ranked_db_p50.data(1,:))-1));
normrankp500 = rdb_p500_sortedbyModNum(:,length(ranked_db_p500.data(1,:))-1) ./ ...
    max(rdb_p500_sortedbyModNum(:,length(ranked_db_p500.data(1,:))-1));

% Sum the distances for each CIP level: CIPdistance = sum(distances)/(# of CIPs)
sum_distances = (normrankm100 + normrankp20 + normrankp50 + normrankp500) ./ 4;

% Concatenate distance vector with model number vector
distanceXmodel_sortedbyModNum = horzcat(sum_distances,rdb_m100_sortedbyModNum(:,length(ranked_db_m100.data(1,:))));
distanceXmodel_sortedbyDistance = sortrows(distanceXmodel_sortedbyModNum,1);

% Plot Distances
figure(1)
plot(sort(db_sim_m100.data(:,1)),distanceXmodel_sortedbyModNum(:,1))
xlabel('Model Number')
ylabel('Normalized Cumulative Distance')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(2)
plot(distanceXmodel_sortedbyDistance(:,1))
xlabel('Model Rank')
ylabel('Normalized Cumulative Distance')
axis([0 length(distanceXmodel_sortedbyDistance(:,1))+1 0 1])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Calling for Simulation Traces

ssd = sortrows(db_sim_m100.data(:,1:6),1);
ssd_params_top10 = ssd(distanceXmodel_sortedbyDistance(1:10,2),:);
ssd_params_dist_top10 = horzcat(ssd_params_top10,distanceXmodel_sortedbyDistance(1:10,1));
ssd_params_sortedbydistance = ssd(distanceXmodel_sortedbyDistance(:,2),:);
ssd_params_dist = horzcat(ssd_params_sortedbydistance,distanceXmodel_sortedbyDistance(:,1));

for Rank_To_Plot = 1;
    ssd_params = ssd(distanceXmodel_sortedbyDistance(Rank_To_Plot,2),:);

    
    f1 = [TopDirSim 'model_' num2str(ssd_params(1,1)) '_ModNum_'...
        num2str(ssd_params(1,2)) '_NaT_' num2str(ssd_params(1,3)) '_NaP_' num2str(ssd_params(1,4)) ...
        '_Kdrf_' num2str(ssd_params(1,5)) '_Kdrs_' num2str(ssd_params(1,6)) '_KA_-0.1_InjectionMagnitude.dat'];
    f2 = [TopDirSim 'model_' num2str(ssd_params(1,1)) '_ModNum_'...
        num2str(ssd_params(1,2)) '_NaT_' num2str(ssd_params(1,3)) '_NaP_' num2str(ssd_params(1,4)) ...
        '_Kdrf_' num2str(ssd_params(1,5)) '_Kdrs_' num2str(ssd_params(1,6)) '_KA_0.02_InjectionMagnitude.dat'];
    f3 = [TopDirSim 'model_' num2str(ssd_params(1,1)) '_ModNum_'...
        num2str(ssd_params(1,2)) '_NaT_' num2str(ssd_params(1,3)) '_NaP_' num2str(ssd_params(1,4)) ...
        '_Kdrf_' num2str(ssd_params(1,5)) '_Kdrs_' num2str(ssd_params(1,6)) '_KA_0.05_InjectionMagnitude.dat'];
    f4 = [TopDirSim 'model_' num2str(ssd_params(1,1)) '_ModNum_'...
        num2str(ssd_params(1,2)) '_NaT_' num2str(ssd_params(1,3)) '_NaP_' num2str(ssd_params(1,4)) ...
        '_Kdrf_' num2str(ssd_params(1,5)) '_Kdrs_' num2str(ssd_params(1,6)) '_KA_0.5_InjectionMagnitude.dat'];
    
    ssdm100TraceSimN1 = cip_trace(f1,dt_sim,dy_sim,cip_start_sim,cip_end_sim,'simdata',props_sim);
    ssdp20TraceSimN1 = cip_trace(f2,dt_sim,dy_sim,cip_start_sim,cip_end_sim,'simdata',props_sim);
    ssdp50TraceSimN1 = cip_trace(f3,dt_sim,dy_sim,cip_start_sim,cip_end_sim,'simdata',props_sim);
    ssdp500TraceSimN1 = cip_trace(f4,dt_sim,dy_sim,cip_start_sim,cip_end_sim,'simdata',props_sim);
    
    x = vertcat(ssdm100TraceSimN1.data,ssdp20TraceSimN1.data,ssdp50TraceSimN1.data,ssdp500TraceSimN1.data);
%     tv = 0.1:0.1:12000.4;
    tv = 0.1:0.1:3000.1;
%     figure(1)
%     subplot(2,1,Rank_To_Plot)
    fig = figure(Rank_To_Plot+2);
%     subplot('Position',[0.01 0 1 1]) % If minimizing white space
    subplot('Position',[0.01 0 1 0.92]) % If plotting legend    %     plot(tv,x)
    p1 = plot(tv(1:13500),ssdm100TraceSimN1.data(1:13500),'Color','r');
    hold on
    p3 = plot(tv(1:13500),ssdp50TraceSimN1.data(1:13500),'Color','b');
    hold on
    p2 = plot(tv(1:13500),ssdp20TraceSimN1.data(1:13500),'Color','g');
    hold on
    p4 = plot(tv(1:13500),ssdp500TraceSimN1.data(1:13500),'Color',[1 .4 0]);
    hold on
%     text(1350,20,'S.1','FontSize',font_size+2,'FontWeight','bold')
    hold on
    plot([1100 1300],[-100 -100],'k','LineWidth',2)
    hold on
    text(1120,-105,'200 ms','FontSize',font_size)
    hold on
    plot([1300 1300],[-100 -80],'k','LineWidth',2)
    hold on
    rtext = text(1320,-80,'20 mV','FontSize',font_size);
    set(rtext,'rotation',270)
    ax = gca; % current axes
    ax.FontSize = font_size;
    axis off
    hold off
%     legend([p1 p2 p3 p4],'Hyperpolarization','Passive Depolarization','Active Depolarization','Depolarization Block','Position',[430 350 0.1 0.1])
%     xlabel('Time (ms)')
%     ylabel('Voltage (mV)')
%     axis([0 max(tv) -150 50])
    
end
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Calling for Experimental Criterion Traces
ssdm100TraceExpN1 = cip_trace(char(strcat(TopDirExp,critm100)),dt_exp,dy_exp,cip_start_exp,cip_end_exp,'expdata',props_exp);
ssdp20TraceExpN1 = cip_trace(char(strcat(TopDirExp,critp20)),dt_exp,dy_exp,cip_start_exp,cip_end_exp,'expdata',props_exp);
ssdp50TraceExpN1 = cip_trace(char(strcat(TopDirExp,critp50)),dt_exp,dy_exp,cip_start_exp,cip_end_exp,'expdata',props_exp);
ssdp500TraceExpN1 = cip_trace(char(strcat(TopDirExp,critp500)),dt_exp,dy_exp,cip_start_exp,cip_end_exp,'expdata',props_exp);

x2 = vertcat(ssdm100TraceExpN1.data,ssdp20TraceExpN1.data,ssdp50TraceExpN1.data,ssdp500TraceExpN1.data);
tv2 = 0.1:0.1:12000;

figure(13)
% subplot(2,1,2)
plot(tv2,x2)
xlabel('Time (ms)')
ylabel('Voltage (mV)')
% title('IS3 Experimental CIP Recordings')
axis([0 max(tv) -150 50])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% CBDR Dimensional Stacking plot 

%%% Normalized Cumulative Distance Across All CIPS %%%
NaTnumparams = length(unique(m100db(:,2))); % Find number of parameter values for each conductance
NaPnumparams = length(unique(m100db(:,3))); 
Kdrfnumparams = length(unique(m100db(:,4)));
Kdrsnumparams = length(unique(m100db(:,5)));
Kanumparams = length(unique(m100db(:,6)));
NaTmin = min(unique(m100db(:,2))); % Find minimum parameter value for each conductance
NaPmin = min(unique(m100db(:,3)));
Kdrfmin = min(unique(m100db(:,4)));
Kdrsmin = min(unique(m100db(:,5)));
Kamin = min(unique(m100db(:,6)));
NaTmax = max(unique(m100db(:,2))); % Find maximum parameter value for each conductance
NaPmax = max(unique(m100db(:,3)));
Kdrfmax = max(unique(m100db(:,4)));
Kdrsmax = max(unique(m100db(:,5)));
Kamax = max(unique(m100db(:,6)));

% Concatenate overall distances with a parameter matrix
m100dbsorted = sortrows(m100db,1); % Sort rows according to model number
ssd_params_dist_sorted = sortrows(ssd_params_dist,1); % Sort rows according to model number
inidistmat = ones(length(m100dbsorted(:,1)),1); % Initialize all distances to be 1
db_dists = horzcat(m100dbsorted,inidistmat); % Concatenate initilized distance vector to sorted parameter matrix
db_dists(ssd_params_dist_sorted(:,1),end) = ssd_params_dist_sorted(:,end); % Change all post-processed model distances to its appropriate value

% Create N-Dimensional matrix of distance values
sorteddists = sortrows(sortrows(sortrows(sortrows(sortrows(db_dists,2),3),4),5),6); % Sort rows for reshaping
Ndimdb = reshape(sorteddists(:,end),[NaTnumparams,NaPnumparams,Kdrfnumparams,Kdrsnumparams,Kanumparams]); % Reshapes distance vector into N-dimensional matrix

% optimize edginess
order0 = randperm(5); % Randomizes the order of dimensions for initial plotting
order = descend_edginess_order(order0,round(Ndimdb*100)); % Optimize dimension order for minimal edginess

% Create colormap (should range in values from 0 to 100)
cmap = horzcat(vertcat(ones(68,1),[1:-0.03:0.06]',0),vertcat(ones(34,1),[1:-0.03:0.03]',...
    zeros(34,1)),vertcat([1:-0.03:0.03]',zeros(68,1)));

% show best
figure_dim_stack(round(Ndimdb*100),order,[0 100],cmap,...
    [],{['Na,t'],...
    ['Na,p'],...
    ['Kdrf'],...
    ['Kdrs'],...
    ['Ka']});
legend('off')
h = colorbar;
ylabel(h,'Normalized Cumulative Distance Metric','FontSize',font_size)
% title([Case ' CBDR'],'FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%%% Individual CIP Distances %%%
CIP_dists = horzcat(normrankm100,normrankp20,normrankp50,normrankp500); % Concatenate distance vectors for each CIP
db_CIPdists = db_dists; % Re-initialize dists matrix
CIP_str = [-100 20 50 500];

for i = 1:length(CIP_dists(1,:))
    
    % Concatenate overall distances with a parameter matrix
    db_CIPdists(sort(db_sim_m100.data(:,1)),end) = CIP_dists(:,i);
    
    % Create N-Dimensional matrix of distance values
    sortedCIPdists = sortrows(sortrows(sortrows(sortrows(sortrows(db_CIPdists,2),3),4),5),6); % Sort rows for reshaping
    NdimdbCIP = reshape(sortedCIPdists(:,end),[NaTnumparams,NaPnumparams,Kdrfnumparams,Kdrsnumparams,Kanumparams]); % Reshapes distance vector into N-dimensional matrix
    
    % optimize edginess
    orderCIP = descend_edginess_order(order0,round(NdimdbCIP*100)); % Optimize dimension order for minimal edginess
    
    % show best
    figure_dim_stack(round(NdimdbCIP*100),order,[0 100],cmap,...
        [],{['NaT (' num2str(NaTmin) ' to ' num2str(NaTmax) ' S/cm^2)'],...
    ['NaP (' num2str(NaPmin) ' to ' num2str(NaPmax) ' S/cm^2)'],...
    ['Kdrf (' num2str(Kdrfmin) ' to ' num2str(Kdrfmax) ' S/cm^2)'],...
    ['Kdrs (' num2str(Kdrsmin) ' to ' num2str(Kdrsmax) ' S/cm^2)'],...
    ['Ka (' num2str(Kamin) ' to ' num2str(Kamax) ' S/cm^2)']});
    legend('off')
    h = colorbar;
    ylabel(h,['Normalized ' num2str(CIP_str(i)) ' pA Distance Metric'],'FontSize',font_size)
    title([Case ' CBDR'],'FontSize',font_size)
    set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
    ax = gca; % current axes
    ax.FontSize = font_size-2;

end

%%% Individual Measurements: FreqAtMaxThetaPeak %%%

% Concatenate overall distances with a parameter matrix
FreqAtMaxThetaPeak = 7;
p20dbsorted = sortrows(p20db,1); % Sort rows according to model #
p20dbsorted(:,FreqAtMaxThetaPeak) = 12; % Replace all values with highest possible theta peak frequency
PPp20dbsorted = sortrows(db_sim_p20.data,1); % Sort post-processed db according to model #
p20dbsorted(PPp20dbsorted(:,1),FreqAtMaxThetaPeak) = PPp20dbsorted(:,FreqAtMaxThetaPeak); % Replace all post-processed model values with appropriate values

% Create N-Dimensional matrix of distance values
sortedFreqs = sortrows(sortrows(sortrows(sortrows(sortrows(p20dbsorted,2),3),4),5),6); % Sort rows for reshaping
NdimdbFreq = reshape(sortedFreqs(:,FreqAtMaxThetaPeak),...
    [NaTnumparams,NaPnumparams,Kdrfnumparams,Kdrsnumparams,Kanumparams]); % Reshapes distance vector into N-dimensional matrix

% optimize edginess
orderFreq = descend_edginess_order(order0,round(NdimdbFreq)); % Optimize dimension order for minimal edginess

% Create colormap (should have a length of 8)
cmapFreq = horzcat(vertcat(ones(8,1),[1:-0.25:0]'),vertcat(ones(4,1),[1:-0.2:0.2]',...
    zeros(4,1)),vertcat([1:-0.2:0.2]',zeros(8,1)));

% show best
figure_dim_stack(round(NdimdbFreq),order,[0 12],cmapFreq,...
    [],{['NaT (' num2str(NaTmin) ' to ' num2str(NaTmax) ' S/cm^2)'],...
    ['NaP (' num2str(NaPmin) ' to ' num2str(NaPmax) ' S/cm^2)'],...
    ['Kdrf (' num2str(Kdrfmin) ' to ' num2str(Kdrfmax) ' S/cm^2)'],...
    ['Kdrs (' num2str(Kdrsmin) ' to ' num2str(Kdrsmax) ' S/cm^2)'],...
    ['Ka (' num2str(Kamin) ' to ' num2str(Kamax) ' S/cm^2)']});
legend('off')
h = colorbar;
ylabel(h,'Frequency at Maximum Theta Peak (Hz)','FontSize',font_size)
title([Case ' CBDR'],'FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%%% Individual Measurements: 50pA PulseIniSpontPotAvgDiff %%%

% Concatenate overall distances with a parameter matrix
PulseIniSpontPotAvgDiff = 24;
p50dbsorted = sortrows(p50db,1); % Sort rows according to model #
p50dbsorted(:,PulseIniSpontPotAvgDiff) = round(max(p50dbsorted(:,PulseIniSpontPotAvgDiff))+1); % Replace all values with highest possible theta peak frequency
PPp50dbsorted = sortrows(db_sim_p50.data,1); % Sort post-processed db according to model #
p50dbsorted(PPp20dbsorted(:,1),PulseIniSpontPotAvgDiff) = PPp50dbsorted(:,PulseIniSpontPotAvgDiff); % Replace all post-processed model values with appropriate values

% Create N-Dimensional matrix of distance values
sortedPotDiffs = sortrows(sortrows(sortrows(sortrows(sortrows(p50dbsorted,2),3),4),5),6); % Sort rows for reshaping
NdimdbPotDiffs = reshape(sortedPotDiffs(:,PulseIniSpontPotAvgDiff),...
    [NaTnumparams,NaPnumparams,Kdrfnumparams,Kdrsnumparams,Kanumparams]); % Reshapes distance vector into N-dimensional matrix

% optimize edginess
orderPotDiffs = descend_edginess_order(order0,round(NdimdbPotDiffs)); % Optimize dimension order for minimal edginess

% Create colormap (should have a length of 8)
cmapPotDiffs = horzcat(vertcat(ones(11,1),[1:-0.25:0]'),vertcat(ones(6,1),[1:-0.2:0.2]',...
    zeros(5,1)),vertcat([1:-0.2:0.2]',zeros(11,1)));

% show best
figure_dim_stack(round(NdimdbPotDiffs),order,[0 15],cmapPotDiffs,...
    [],{['NaT (' num2str(NaTmin) ' to ' num2str(NaTmax) ' S/cm^2)'],...
    ['NaP (' num2str(NaPmin) ' to ' num2str(NaPmax) ' S/cm^2)'],...
    ['Kdrf (' num2str(Kdrfmin) ' to ' num2str(Kdrfmax) ' S/cm^2)'],...
    ['Kdrs (' num2str(Kdrsmin) ' to ' num2str(Kdrsmax) ' S/cm^2)'],...
    ['Ka (' num2str(Kamin) ' to ' num2str(Kamax) ' S/cm^2)']});
legend('off')
h = colorbar;
ylabel(h,'Pre-CIP/CIP Average Potential Difference (mV)','FontSize',font_size)
title([Case ' CBDR'],'FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Correlations between channels (3D Histograms)

% NaT
figure(15)
hist3(ssd_params_dist_sorted(:,[2 3]),[NaTnumparams NaPnumparams],'FaceAlpha',.65)
xlabel('NaT (S/cm^2)')
ylabel('NaP (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(16)
hist3(ssd_params_dist_sorted(:,[2 4]),[NaTnumparams Kdrfnumparams],'FaceAlpha',.65)
xlabel('NaT (S/cm^2)')
ylabel('Kdrf (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(17)
hist3(ssd_params_dist_sorted(:,[2 5]),[NaTnumparams Kdrsnumparams],'FaceAlpha',.65)
xlabel('NaT (S/cm^2)')
ylabel('Kdrs (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(18)
hist3(ssd_params_dist_sorted(:,[2 6]),[NaTnumparams Kanumparams],'FaceAlpha',.65)
xlabel('NaT (S/cm^2)')
ylabel('Ka (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

% NaP
figure(19)
hist3(ssd_params_dist_sorted(:,[3 4]),[NaPnumparams Kdrfnumparams],'FaceAlpha',.65)
xlabel('NaP (S/cm^2)')
ylabel('Kdrf (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(20)
hist3(ssd_params_dist_sorted(:,[3 5]),[NaPnumparams Kdrsnumparams],'FaceAlpha',.65)
xlabel('NaP (S/cm^2)')
ylabel('Kdrs (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(21)
hist3(ssd_params_dist_sorted(:,[3 6]),[NaPnumparams Kanumparams],'FaceAlpha',.65)
xlabel('NaP (S/cm^2)')
ylabel('Ka (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

% Kdrf
figure(22)
hist3(ssd_params_dist_sorted(:,[4 5]),[Kdrfnumparams Kdrsnumparams],'FaceAlpha',.65)
xlabel('Kdrf (S/cm^2)')
ylabel('Kdrs (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(23)
hist3(ssd_params_dist_sorted(:,[4 6]),[Kdrfnumparams Kanumparams],'FaceAlpha',.65)
xlabel('Kdrf (S/cm^2)')
ylabel('Ka (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

% Kdrs
figure(24)
hist3(ssd_params_dist_sorted(:,[5 6]),[Kdrsnumparams Kanumparams],'FaceAlpha',.65)
xlabel('Kdrs (S/cm^2)')
ylabel('Ka (S/cm^2)')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Measure Histograms in post-processed simulation databases

PulseIniSpontPotAvgDiff = 24;
PulsePotMin = 30;
PulsePotMinTime = 31;
PulsePotSag = 32;
PulsePotTau = 33;
FreqAtMaxThetaPeak = 7;
ThetaPower = 53;
PulseFirstSpikeTime = 13;
PulseSFA = 34;
PulseSpikeRate = 37;
PulseSpikeRateISI = 38;
PulseSpikeAmplitudeMean = 103;
PulseSpikeHalfWidthMean = 121;
PulseSpikeInitVmMean = 130;
PulseSpikeMaxAHPMean = 133;
PulseSpikes = 151;
PulseIni100msSpikeRate = 22;
PulseIni100msRestIniSpontPotAvgDiff = 20;

%%% -100 pA Simulation histograms %%%
figure(25)
hist(db_sim_m100.data(:,PulseIniSpontPotAvgDiff));
xlabel('PulseIniSpontPotAvgDiff (mV)'); ylabel('Count'); 
title('-100 pA Measure Histogram for PulseIniSpontPotAvgDiff')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(26)
hist(db_sim_m100.data(:,PulsePotMin));
xlabel('PulsePotMin (mV)'); ylabel('Count'); 
title('-100 pA Measure Histogram for PulsePotMin')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(27)
hist(db_sim_m100.data(:,PulsePotMinTime));
xlabel('PulsePotMinTime (ms)'); ylabel('Count'); 
title('-100 pA Measure Histogram for PulsePotMinTime')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(28)
hist(db_sim_m100.data(:,PulsePotSag));
xlabel('PulsePotSag (mV)'); ylabel('Count'); 
title('-100 pA Measure Histogram for PulsePotSag')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(29)
hist(db_sim_m100.data(:,PulsePotTau));
xlabel('PulsePotTau (ms)'); ylabel('Count'); 
title('-100 pA Measure Histogram for PulsePotTau')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%%% 20 pA Simulation histograms %%%
figure(30)
hist(db_sim_p20.data(:,PulseIniSpontPotAvgDiff));
xlabel('PulseIniSpontPotAvgDiff (mV)'); ylabel('Count'); 
title('20 pA Measure Histogram for PulseIniSpontPotAvgDiff')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(31)
hist(db_sim_p20.data(:,FreqAtMaxThetaPeak));
xlabel('FreqAtMaxThetaPeak (Hz)'); ylabel('Count'); 
title('20 pA Measure Histogram for FreqAtMaxThetaPeak')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(32)
hist(db_sim_p20.data(:,ThetaPower));
xlabel('ThetaPower ((mV^2/Hz)^2)'); ylabel('Count'); 
title('20 pA Measure Histogram for ThetaPower')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%%% 50 pA Simulation histograms %%%
figure(33)
hist(db_sim_p50.data(:,PulseIniSpontPotAvgDiff));
xlabel('PulseIniSpontPotAvgDiff (mV)'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseIniSpontPotAvgDiff')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(34)
hist(db_sim_p50.data(:,PulseFirstSpikeTime));
xlabel('PulseFirstSpikeTime (ms)'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseFirstSpikeTime')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(35)
hist(db_sim_p50.data(:,PulseSFA));
xlabel('PulseSFA'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseSFA')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(36)
hist(db_sim_p50.data(:,PulseSpikeRate));
xlabel('PulseSpikeRate (Hz)'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseSpikeRate')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(37)
hist(db_sim_p50.data(:,PulseSpikeRateISI));
xlabel('PulseSpikeRateISI (ms)'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseSpikeRateISI')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(38)
hist(db_sim_p50.data(:,PulseSpikeAmplitudeMean));
xlabel('PulseSpikeAmplitudeMean (mV)'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseSpikeAmplitudeMean')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(39)
hist(db_sim_p50.data(:,PulseSpikeHalfWidthMean));
xlabel('PulseSpikeHalfWidthMean (ms)'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseSpikeHalfWidthMean')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(40)
hist(db_sim_p50.data(:,PulseSpikeInitVmMean));
xlabel('PulseSpikeInitVmMean (mV)'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseSpikeInitVmMean')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(41)
hist(db_sim_p50.data(:,PulseSpikeMaxAHPMean));
xlabel('PulseSpikeMaxAHPMean (mV)'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseSpikeMaxAHPMean')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(42)
hist(db_sim_p50.data(:,PulseSpikes));
xlabel('PulseSpikes'); ylabel('Count'); 
title('50 pA Measure Histogram for PulseSpikes')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%%% 500 pA Simulation histograms %%%
figure(43)
hist(db_sim_p500.data(:,PulseIni100msRestIniSpontPotAvgDiff));
xlabel('PulseIni100msRestIniSpontPotAvgDiff (mV)'); ylabel('Count'); 
title('500 pA Measure Histogram for PulseIni100msRestIniSpontPotAvgDiff')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
figure(44)
hist(db_sim_p500.data(:,PulseIni100msSpikeRate));
xlabel('PulseIni100msSpikeRate (Hz)'); ylabel('Count'); 
title('500 pA Measure Histogram for PulseIni100msSpikeRate')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Display some of the results
display('Parameters of top ten models in the database (S/cm2):')
display('Model #      G_NaT        N_NaP         G_Kdrf        G_Kdrs         G_Ka      Distance')
display(num2str(ssd_params_dist_top10))
display(['Number of Models Before Pre-Processing = ' num2str(length(m100db(:,1)))])
display(['Number of Remaining Models After Pre-Processing = ' num2str(length(db_sim_m100.data(:,1)))])

toc
