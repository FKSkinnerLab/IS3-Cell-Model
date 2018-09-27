tic
clear variables
close all

addpath('~/Dropbox/MSC_THESIS/Pandora 1.3b/pandora')
addpath('~/Dropbox/MSC_THESIS/Pandora_Matlab - In Progress Scripts/stack-ordering')

font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

%% Parameters

dt_sim = 0.0001;
dy_sim = 0.001;

Case = 'SDprox2';

% dir = '~/Desktop/';
dir = '/home/alexandreguet-mccreight/Resilio Sync/';
TopDirSim = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/' Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/model_*_NumInhCommon.dat'];
NumInhCommonRef = [1 3 9];
NumExcCommonRef = [1 4 16];
NumSLMSpikesRef = [0 100 200 300];
TopDirSim1 = {length(NumInhCommonRef)*length(NumExcCommonRef)*length(NumSLMSpikesRef),1};
count = 1;
for k = 1:length(NumSLMSpikesRef)
    for j = 1:length(NumExcCommonRef)
        for i = 1:length(NumInhCommonRef)
            TopDirSim1{count} = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/' Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/model_*' '_ExcSRSpikes_' num2str(NumSLMSpikesRef(k)) '_ExcSLMSpikes_' num2str(NumExcCommonRef(j)) '_NumExcCommon_' num2str(NumInhCommonRef(i)) '_NumInhCommon.dat'];
            count = count + 1;
        end
    end
end

%% Simulation Database
props_sim = struct('num_params',7,'type','sim','file_type','neuron','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');

% Parallel Implementation
tic
if length(dir) == 10
    parpool(4)
elseif length(dir) == 43
    parpool(8)
end

p = gcp();

parfor i = 1:length(TopDirSim1)
    fileset_sim = params_tests_fileset(TopDirSim1{i},dt_sim,dy_sim,'Sim Dataset',props_sim)
    db_sim_results(i) = params_tests_db(fileset_sim);
end

% Construct full database structure from database pieces
db_sim = db_sim_results(1);
for i = 2:length(TopDirSim1)
    db_sim = [db_sim; db_sim_results(i)];
end

delete(p)
toc

% Serial Implementation
% db_sim = params_tests_db(fileset_sim);

% Save Database
save(Case) % Save Database

%% Plot Results

% Indexing of Parameters in Database
NumberOfInhibitorySyns = 1;
NumberOfExcitatorySyns = 2;
NumberOfInhibitorySpikes = 3;
NumberOfSRExcitatorySpikes = 4;
NumberOfSLMExcitatorySpikes = 5;
NumberCommonExcitatorySyns = 6;
NumberCommonInhibitorySyns = 7;

ISICV = 8;
avgPot = 14;
maxPot = 15;
minPot = 16;
Std = 17;
Spikes = 67;

% Simulation Time
tstop = 10; % in seconds

%% CBDR ISICV Plot
db_sim.data = sortrows(sortrows(sortrows(sortrows(sortrows(sortrows(db_sim.data,1),2),3),4),6),7);

ExcitatorySRSpikeRate = db_sim.data(:,NumberOfSRExcitatorySpikes)./tstop;
ExcitatorySLMSpikeRate = db_sim.data(:,NumberOfSLMExcitatorySpikes)./tstop;
InhibitorySpikeRate = db_sim.data(:,NumberOfInhibitorySpikes)./tstop;

InhSynsnumparams = length(unique(db_sim.data(:,NumberOfInhibitorySyns))); % Find number of parameter values for each conductance
ExcSynsnumparams = length(unique(db_sim.data(:,NumberOfExcitatorySyns)));
InhSpikesnumparams = length(unique(InhibitorySpikeRate));
ExcSpikesnumparams = length(unique(ExcitatorySRSpikeRate)); % Only do the SR spike rates for now since the SLM spike rates are the same
InhCommonnumparams = length(unique(db_sim.data(:,NumberCommonInhibitorySyns)));
ExcCommonnumparams = length(unique(db_sim.data(:,NumberCommonExcitatorySyns)));

InhSynsmin = min(unique(db_sim.data(:,NumberOfInhibitorySyns))); % Find minimum parameter value for each conductance
ExcSynsmin = min(unique(db_sim.data(:,NumberOfExcitatorySyns)));
InhSpikesmin = min(unique(InhibitorySpikeRate));
ExcSpikesmin = min(unique(ExcitatorySRSpikeRate));
InhCommonmin = min(unique(db_sim.data(:,NumberCommonInhibitorySyns)));
ExcCommonmin = min(unique(db_sim.data(:,NumberCommonExcitatorySyns)));

InhSynsmax = max(unique(db_sim.data(:,NumberOfInhibitorySyns))); % Find maximum parameter value for each conductance
ExcSynsmax = max(unique(db_sim.data(:,NumberOfExcitatorySyns)));
InhSpikesmax = max(unique(InhibitorySpikeRate));
ExcSpikesmax = max(unique(ExcitatorySRSpikeRate));
InhCommonmax = max(unique(db_sim.data(:,NumberCommonInhibitorySyns)));
ExcCommonmax = max(unique(db_sim.data(:,NumberCommonExcitatorySyns)));

order0 = randperm(6); % Randomizes the order of dimensions for initial plotting

ISICVs = db_sim.data(:,ISICV);
ISICVs(find(isnan(ISICVs))) = 0; % Replace nans with zeros
Norm1 = (length(hot)-1)/diff([min(ISICVs) max(ISICVs)]);

Ndimdb1 = reshape(ISICVs(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams,ExcCommonnumparams,InhCommonnumparams]); % Reshapes distance vector into N-dimensional matrix
order = descend_edginess_order(order0,round(Ndimdb1*63)); % Optimize dimension order for minimal edginess

figure(1)
figure_dim_stack(round(Ndimdb1*Norm1),order,[min(round(ISICVs*Norm1)) max(round(ISICVs*Norm1))],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)'],...
    ['Number of Common Excitatory Synapses (' num2str(ExcCommonmin) ' to ' num2str(ExcCommonmax) ')'],...
    ['Number of Common Inhibitory Synapses (' num2str(InhCommonmin) ' to ' num2str(InhCommonmax) ')']});
legend('off')
h = colorbar;
caxis([0 max(ISICVs)])
ylabel(h,'ISICV','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% CBDR Average Potential Plots
avgPots = db_sim.data(:,avgPot);
Norm2 = (length(hot)-1)/diff([min(avgPots) max(avgPots)]);

Ndimdb2 = reshape(avgPots(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams,ExcCommonnumparams,InhCommonnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess

figure(2)
figure_dim_stack(round(Ndimdb2*Norm2),order,[min(round(avgPots*Norm2)) max(round(avgPots*Norm2))],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)'],...
    ['Number of Common Excitatory Synapses (' num2str(ExcCommonmin) ' to ' num2str(ExcCommonmax) ')'],...
    ['Number of Common Inhibitory Synapses (' num2str(InhCommonmin) ' to ' num2str(InhCommonmax) ')']});
legend('off')
h = colorbar;
caxis([min(avgPots) max(avgPots)])
ylabel(h,'Average Membrane Potential (mV)','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% CBDR Standard Deviation of Potential Plots
Stds = db_sim.data(:,Std);
Norm3 = (length(hot)-1)/diff([min(Stds) max(Stds)]);

Ndimdb3 = reshape(Stds(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams,ExcCommonnumparams,InhCommonnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess

figure(3)
figure_dim_stack(round(Ndimdb3*Norm3),order,[min(round(Stds*Norm3)) max(round(Stds*Norm3))],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)'],...
    ['Number of Common Excitatory Synapses (' num2str(ExcCommonmin) ' to ' num2str(ExcCommonmax) ')'],...
    ['Number of Common Inhibitory Synapses (' num2str(InhCommonmin) ' to ' num2str(InhCommonmax) ')']});
legend('off')
h = colorbar;
caxis([min(Stds) max(Stds)])
ylabel(h,'Standard Deviation of Membrane Potential (mV)','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% CBDR Spike Plots
spikes = db_sim.data(:,Spikes);
Norm4 = (length(hot)-1)/diff([min(spikes) max(spikes)]);

Ndimdb4 = reshape(spikes(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams,ExcCommonnumparams,InhCommonnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess

figure(4)
figure_dim_stack(round(Ndimdb4*Norm4),order,[min(round(spikes*Norm4)) max(round(spikes*Norm4))],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)'],...
    ['Number of Common Excitatory Synapses (' num2str(ExcCommonmin) ' to ' num2str(ExcCommonmax) ')'],...
    ['Number of Common Inhibitory Synapses (' num2str(InhCommonmin) ' to ' num2str(InhCommonmax) ')']});
legend('off')
h = colorbar;
caxis([min(spikes) max(spikes)])
ylabel(h,'Number of Spikes','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% CBDR HC Metric Plots
avgPots_thresh = -66.7; % Previously -60 mV
Stds_thresh = 2.2; % Previously 3 mV
ISICVs_thresh = 0.8;

SpikeAmplitudeMean = 19;
amps = db_sim.data(:,SpikeAmplitudeMean);
spikeamp_DB_thresh = 40; % Identifies models in depolarization block

HC_metric = zeros(length(db_sim.data(:,1)),1); % Initialize High-Conductance Metric vector

HC_metric(avgPots >= avgPots_thresh) = HC_metric(avgPots >= avgPots_thresh) + 1;
HC_metric(Stds >= Stds_thresh) = HC_metric(Stds >= Stds_thresh) + 1;
HC_metric(ISICVs >= ISICVs_thresh) = HC_metric(ISICVs >= ISICVs_thresh) + 1;

HC_metric(amps <= spikeamp_DB_thresh) = HC_metric(amps <= spikeamp_DB_thresh) - 4; % i.e. negative HC metric if in DB

Norm5 = (length(hot)-1)/diff([min(HC_metric) max(HC_metric)]);

Ndimdb5 = reshape(HC_metric(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams,ExcCommonnumparams,InhCommonnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess

figure(5)
figure_dim_stack(round(Ndimdb5*Norm5),order,[min(round(HC_metric*Norm5)) max(round(HC_metric*Norm5))],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)'],...
    ['Number of Common Excitatory Synapses (' num2str(ExcCommonmin) ' to ' num2str(ExcCommonmax) ')'],...
    ['Number of Common Inhibitory Synapses (' num2str(InhCommonmin) ' to ' num2str(InhCommonmax) ')']});
legend('off')
h = colorbar;
caxis([min(HC_metric) max(HC_metric)])
ylabel(h,'High-Conductance State Metric','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Plot trace with highest ISICV

% dir = '~/Desktop/';
% dir = '/home/alexandreguet-mccreight/Resilio Sync/';


params = db_sim.data(find(ISICVs == max(ISICVs)),1:7);
file1 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/model_'...
    num2str(params(NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params(NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params(NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params(NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params(NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params(NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params(NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];
tvec = 0:dt_sim:tstop; % seconds
HighISICVTrace = trace(file1,dt_sim,dy_sim,'Sim Dataset',props_sim);
figure(6)
plot(tvec,HighISICVTrace.data)
xlabel('Time (s)','FontSize',font_size)
ylabel('Voltage (mV)','FontSize',font_size)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Plot trace with highest average potential
params2 = db_sim.data(find(avgPots == max(avgPots)),1:7);
file2 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/model_'...
    num2str(params2(NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params2(NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params2(NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params2(NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params2(NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params2(NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params2(NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];
tvec = 0:dt_sim:tstop; % seconds
HighMeanVmTrace = trace(file2,dt_sim,dy_sim,'Sim Dataset',props_sim);
figure(7)
plot(tvec,HighMeanVmTrace.data)
xlabel('Time (s)','FontSize',font_size)
ylabel('Voltage (mV)','FontSize',font_size)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Plot trace with highest standard deviation of potential
params3 = db_sim.data(find(Stds == max(Stds)),1:7);
file3 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/model_'...
    num2str(params3(NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params3(NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params3(NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params3(NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params3(NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params3(NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params3(NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];
tvec = 0:dt_sim:tstop; % seconds
HighSTDTrace = trace(file3,dt_sim,dy_sim,'Sim Dataset',props_sim);
figure(8)
plot(tvec,HighSTDTrace.data)
xlabel('Time (s)','FontSize',font_size)
ylabel('Voltage (mV)','FontSize',font_size)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Plot example models with high HC metrics

figure(9)
params4 = db_sim.data(find(HC_metric == 3),1:7);
index = randperm(length(params4(:,1)));
plotstats = 0;

if plotstats
    subplot(4,2,[1,2])
else
    subplot(2,1,1)
end
file4 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/model_'...
    num2str(params4(index(1),NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params4(index(1),NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params4(index(1),NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params4(index(1),NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params4(index(1),NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params4(index(1),NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params4(index(1),NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];
tvec = 0:dt_sim:tstop; % seconds
HighHCTrace = trace(file4,dt_sim,dy_sim,'Sim Dataset',props_sim);
plot(tvec,HighHCTrace.data)
axis([0 max(tvec) -75 30])
ax = gca; % current axes
ax.FontSize = font_size-4;
ylabel('Voltage (mV)')
if plotstats
    xlabel('Time (s)')
end
title(sprintf(['InhSyns = ' num2str(params4(index(1),NumberOfInhibitorySyns))...
    ', ExcSyns = ' num2str(params4(index(1),NumberOfExcitatorySyns))...
    ', InhRate = ' num2str(params4(index(1),NumberOfInhibitorySpikes)/tstop)...
    ' Hz, \nExcRate = ' num2str(params4(index(1),NumberOfSRExcitatorySpikes)/tstop)...
    ' Hz, InhCommon = ' num2str(params4(index(1),NumberCommonInhibitorySyns))...
    ', ExcCommon = ' num2str(params4(index(1),NumberCommonExcitatorySyns))]))

if plotstats
    subplot(4,2,[3,4])
else
    subplot(2,1,2)
end
file5 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/InhPreSpikeTrains_'...
    num2str(params4(index(1),NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params4(index(1),NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params4(index(1),NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params4(index(1),NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params4(index(1),NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params4(index(1),NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params4(index(1),NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];
file6 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/SRExcPreSpikeTrains_'...
    num2str(params4(index(1),NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params4(index(1),NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params4(index(1),NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params4(index(1),NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params4(index(1),NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params4(index(1),NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params4(index(1),NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];
file7 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/SLMExcPreSpikeTrains_'...
    num2str(params4(index(1),NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params4(index(1),NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params4(index(1),NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params4(index(1),NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params4(index(1),NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params4(index(1),NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params4(index(1),NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];

if params4(index(1),NumberOfInhibitorySpikes) > 0
    inhspikemat = dlmread(file5,'',1,0);
else
    inhspikemat = nan;
end
if params4(index(1),NumberOfSRExcitatorySpikes) > 0 && params4(index(1),NumberOfSLMExcitatorySpikes) > 0
    SRexcspikemat = dlmread(file6,'',1,0);
    SLMexcspikemat = dlmread(file7,'',1,0);
else
    SRexcspikemat = nan;
    SLMexcspikemat = nan;
end

for k = 1:length(SRexcspikemat(:,1))
    scatter(SRexcspikemat(k,:)./1000,ones(length(SRexcspikemat(k,:)),1).*k,5,'filled','b')
    hold on
end
indexpoint = k;
for k = 1:length(SLMexcspikemat(:,1))
    scatter(SLMexcspikemat(k,:)./1000,ones(length(SLMexcspikemat(k,:)),1).*k + indexpoint,5,'filled','g')
    hold on
end
indexpoint = indexpoint + k;
for k = 1:length(inhspikemat(:,1))
    scatter(inhspikemat(k,:)./1000,ones(length(inhspikemat(k,:)),1).*k + indexpoint,5,'filled','r')
    hold on
end
hold off
axis([0 tstop 0 indexpoint+k])
ax = gca; % current axes
ax.FontSize = font_size-4;
xlabel('Time (s)')
ylabel('Neuron Index')

if plotstats
    subplot(4,2,[5,6])
    inhISIs = diff(inhspikemat,1,2);
    SRexcISIs = diff(SRexcspikemat,1,2);
    SLMexcISIs = diff(SLMexcspikemat,1,2);
    if params4(index(1),NumberOfInhibitorySpikes) > 0
        h = histogram(inhISIs,30);
        h.FaceColor = 'r';
    else
        histogram(nan)
    end
    hold on
    if params4(index(1),NumberOfSRExcitatorySpikes) > 0 && params4(index(1),NumberOfSLMExcitatorySpikes) > 0
        h = histogram(SRexcISIs,30);
        h.FaceColor = 'b';
        hold on
        h = histogram(SLMexcISIs,30);
        h.FaceColor = 'g';
    else
        histogram(nan)
    end
    hold off
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    ylabel('Count')
    xlabel('ISI (ms)')
    
    subplot(4,2,7)
    SRexcISIs = diff(SRexcspikemat./1000,1,2);
    SRexcISIs(SRexcISIs == 0) = 0.005; % Since larger decimal point is 0.01, this prevents divisions by zero
    SRexcrate = 1./SRexcISIs;
    SRavgexcrate = mean(SRexcrate,1);
    SRstdexcrate = std(SRexcrate,0,1);
    x = 10/length(SRexcspikemat(1,:)):10/length(SRexcspikemat(1,:)):10-10/length(SRexcspikemat(1,:));
    y = SRavgexcrate;
    err = SRstdexcrate;
    if isempty(y)
        plot(nan)
    else
        plot(x,-y,'b')
    end
    hold on
    SLMexcISIs = diff(SLMexcspikemat./1000,1,2);
    SLMexcISIs(SLMexcISIs == 0) = 0.005; % Since larger decimal point is 0.01, this prevents divisions by zero
    SLMexcrate = 1./SLMexcISIs;
    SLMavgexcrate = mean(SLMexcrate,1);
    SLMstdexcrate = std(SLMexcrate,0,1);
    x3 = 10/length(SLMexcspikemat(1,:)):10/length(SLMexcspikemat(1,:)):10-10/length(SLMexcspikemat(1,:));
    y3 = SLMavgexcrate;
    err3 = SLMstdexcrate;
    if isempty(y3)
        plot(nan)
    else
        plot(x3,-y3,'g')
    end
    hold on
    inhISIs = diff(inhspikemat./1000,1,2);
    inhISIs(inhISIs == 0) = 0.005;
    inhrate = 1./inhISIs;
    avginhrate = mean(inhrate,1);
    stdinhrate = std(inhrate,0,1);
    x2 = 10/length(inhspikemat(1,:)):10/length(inhspikemat(1,:)):10-10/length(inhspikemat(1,:));
    y2 = avginhrate;
    err2 = stdinhrate;
    if isempty(y2)
        plot(nan)
    else
        plot(x2,y2,'r')
    end
    %         patch([x2 fliplr(x2)],[y2+err2 fliplr(y2-err2)],'r');
    hold off
    axis([0 tstop -200 200])
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    
    subplot(4,2,8)
    [acor,lag] = xcorr(y,y2); % SR excitatory vs inhibitory
    [acor2,lag2] = xcorr(y3,y2); % SLM excitatory vs inhibitory
    [acor3,lag3] = xcorr(y,y3); % SR excitatory vs SLM excitatory
    
    if isempty(lag) % Replace empty matrices with nans so we can plot them
        acor = nan;
        lag = nan;
    elseif isempty(lag2)
        acor2 = nan;
        lag2 = nan;
    elseif isempty(lag3)
        acor3 = nan;
        lag3 = nan;
    end
    
    plot(lag,acor,'m',lag2,acor2,'y',lag3,acor3,'c')
    xlabel('Lag (s)')
    ylabel('X-Corr')
    %         legend('SR Exc X Inh','SLM Exc X Inh','SR Exc X SLM Exc')
    ax = gca; % current axes
    ax.FontSize = font_size-2;
end

%% Plot E/I High Conductance Models in Scatter
Erate = nan(1,length(params4(:,1)));
Irate = nan(1,length(params4(:,1)));
Esyns = nan(1,length(params4(:,1)));
Isyns = nan(1,length(params4(:,1)));
Ecommon = nan(1,length(params4(:,1)));
Icommon = nan(1,length(params4(:,1)));
EIrateRatio = nan(1,length(params4(:,1)));
EIsynRatio = nan(1,length(params4(:,1)));

for i = 1:length(params4(:,1))
    
    Erate(i) = params4(i,NumberOfSRExcitatorySpikes); % Since the SLM Exc spike rate is the same, we will only consider SR here
    Irate(i) = params4(i,NumberOfInhibitorySpikes);
    EIrateRatio(i) = Erate(i)/Irate(i);
    Esyns(i) = params4(i,NumberOfExcitatorySyns);
    Isyns(i) = params4(i,NumberOfInhibitorySyns);
    EIsynRatio(i) = Esyns(i)/Isyns(i);
    Ecommon(i) = params4(i,NumberCommonExcitatorySyns);
    Icommon(i) = params4(i,NumberCommonInhibitorySyns);
    
end
Edom_syn = EIsynRatio(EIsynRatio>1 & EIrateRatio>1);
Edom_rate = EIrateRatio(EIsynRatio>1 & EIrateRatio>1);
Idom_syn = EIsynRatio(EIsynRatio<1 & EIrateRatio<1);
Idom_rate = EIrateRatio(EIsynRatio<1 & EIrateRatio<1);
Esyndom_Iratedom_syn = EIsynRatio(EIsynRatio>1 & EIrateRatio<1);
Esyndom_Iratedom_rate = EIrateRatio(EIsynRatio>1 & EIrateRatio<1);
Eratedom_Isyndom_syn = EIsynRatio(EIsynRatio<1 & EIrateRatio>1);
Eratedom_Isyndom_rate = EIrateRatio(EIsynRatio<1 & EIrateRatio>1);
% Even_syn = EIsynRatio(EIsynRatio==1 | EIrateRatio==1);
% Even_rate = EIrateRatio(EIsynRatio==1 | EIrateRatio==1);

CommonMat = [Ecommon; Icommon];
Common1E1I = CommonMat(:,sum(CommonMat) == 2);
Common1E3I = CommonMat(:,sum(CommonMat) == 4);
Common1E9I = CommonMat(:,sum(CommonMat) == 10);
Common4E1I = CommonMat(:,sum(CommonMat) == 5);
Common4E3I = CommonMat(:,sum(CommonMat) == 7);
Common4E9I = CommonMat(:,sum(CommonMat) == 13);
Common16E1I = CommonMat(:,sum(CommonMat) == 17);
Common16E3I = CommonMat(:,sum(CommonMat) == 19);
Common16E9I = CommonMat(:,sum(CommonMat) == 25);

figure(10)
subplot(2,1,1)
scatter(Edom_syn,Edom_rate,10,'filled','b')
hold on
scatter(Idom_syn,Idom_rate,10,'filled','r')
scatter(Esyndom_Iratedom_syn,Esyndom_Iratedom_rate,10,'filled','g')
scatter(Eratedom_Isyndom_syn,Eratedom_Isyndom_rate,10,'filled','o')
% scatter(Even_syn,Even_rate,10,'filled','k')
plot([1 1],[0 max(EIrateRatio)+1],'--r')
plot([0 max(EIsynRatio)+1],[1 1],'--r')
hold off
xlabel('E/I Synapse Ratio')
ylabel('E/I Spike Rate Ratio')
title('E/I Balances in HC Models')
ax = gca; % current axes
ax.FontSize = font_size-6;
[h, ~] = legend('show','E Dominant','I Dominant',sprintf('E Syn/I Rate \nDominant'),sprintf('I Syn/E Rate \nDominant'));
h.Location = 'northeast';

subplot(2,1,2)
barlabels = {'E Syn & Rate','I Syn & Rate','E Syn/I Rate','I Syn/E Rate'};
bar([length(Edom_syn), length(Idom_syn), length(Esyndom_Iratedom_syn), length(Eratedom_Isyndom_syn)])
set(gca,'xticklabel',barlabels)
title('E/I Dominance in HC Models')
ax = gca; % current axes
ax.FontSize = font_size-7;

figure(13)
barlabels = {'1E/1I','1E/3I','1E/9I','4E/1I','4E/3I','4E/9I','16E/1I','16E/3I','16E/9I'};
bar([length(Common1E1I), length(Common1E3I), length(Common1E9I),...
    length(Common4E1I), length(Common4E3I), length(Common4E9I),...
    length(Common16E1I), length(Common16E3I), length(Common16E9I)])
set(gca,'xticklabel',barlabels)
title('Common Inputs in HC Models')
ax = gca; % current axes
ax.FontSize = font_size-12;

figure(15)
subplot(2,1,1)
scatter3(Ecommon,EIsynRatio,EIrateRatio)
xlabel('Number of Common Excitatory Synapses')
ylabel('E/I Synapse Ratio')
zlabel('E/I Spike Rate Ratio')
title('High-Conductance Models')

subplot(2,1,2)
scatter3(Icommon,EIsynRatio,EIrateRatio)
xlabel('Number of Common Inhibitory Synapses')
ylabel('E/I Synapse Ratio')
zlabel('E/I Spike Rate Ratio')

%% Plot example models characterized as being in depolarization block

figure(12)
params4 = db_sim.data(find(HC_metric < 0),1:7);
index = randperm(length(params4(:,1)));
plotstats = 0;

if plotstats
    subplot(4,2,[1,2])
else
    subplot(2,1,1)
end
file4 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/model_'...
    num2str(params4(index(1),NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params4(index(1),NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params4(index(1),NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params4(index(1),NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params4(index(1),NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params4(index(1),NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params4(index(1),NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];
tvec = 0:dt_sim:tstop; % seconds
HighHCTrace = trace(file4,dt_sim,dy_sim,'Sim Dataset',props_sim);
plot(tvec,HighHCTrace.data)
axis([0 max(tvec) -75 30])
ax = gca; % current axes
ax.FontSize = font_size-4;
ylabel('Voltage (mV)')
if plotstats
    xlabel('Time (s)')
end
title(sprintf(['InhSyns = ' num2str(params4(index(1),NumberOfInhibitorySyns))...
    ', ExcSyns = ' num2str(params4(index(1),NumberOfExcitatorySyns))...
    ', InhRate = ' num2str(params4(index(1),NumberOfInhibitorySpikes)/tstop)...
    ' Hz, \nExcRate = ' num2str(params4(index(1),NumberOfSRExcitatorySpikes)/tstop)...
    ' Hz, InhCommon = ' num2str(params4(index(1),NumberCommonInhibitorySyns))...
    ', ExcCommon = ' num2str(params4(index(1),NumberCommonExcitatorySyns))]))

if plotstats
    subplot(4,2,[3,4])
else
    subplot(2,1,2)
end
file5 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/InhPreSpikeTrains_'...
    num2str(params4(index(1),NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params4(index(1),NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params4(index(1),NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params4(index(1),NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params4(index(1),NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params4(index(1),NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params4(index(1),NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];
file6 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/SRExcPreSpikeTrains_'...
    num2str(params4(index(1),NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params4(index(1),NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params4(index(1),NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params4(index(1),NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params4(index(1),NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params4(index(1),NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params4(index(1),NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];
file7 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N3/Parallel_BulletinStyle/NSG_Results/'...
    Case '_2Node24Cores_ED1/Cipres_Data/output/' Case '_AwakeMoving/SLMExcPreSpikeTrains_'...
    num2str(params4(index(1),NumberOfInhibitorySyns)) '_NumInh_'...
    num2str(params4(index(1),NumberOfExcitatorySyns)) '_NumExc_'...
    num2str(params4(index(1),NumberOfInhibitorySpikes)) '_InhSpikes_'...
    num2str(params4(index(1),NumberOfSRExcitatorySpikes)) '_ExcSRSpikes_'...
    num2str(params4(index(1),NumberOfSLMExcitatorySpikes)) '_ExcSLMSpikes_'...
    num2str(params4(index(1),NumberCommonExcitatorySyns)) '_NumExcCommon_'...
    num2str(params4(index(1),NumberCommonInhibitorySyns)) '_NumInhCommon.dat'];

if params4(index(1),NumberOfInhibitorySpikes) > 0
    inhspikemat = dlmread(file5,'',1,0);
else
    inhspikemat = nan;
end
if params4(index(1),NumberOfSRExcitatorySpikes) > 0 && params4(index(1),NumberOfSLMExcitatorySpikes) > 0
    SRexcspikemat = dlmread(file6,'',1,0);
    SLMexcspikemat = dlmread(file7,'',1,0);
else
    SRexcspikemat = nan;
    SLMexcspikemat = nan;
end

for k = 1:length(SRexcspikemat(:,1))
    scatter(SRexcspikemat(k,:)./1000,ones(length(SRexcspikemat(k,:)),1).*k,5,'filled','b')
    hold on
end
indexpoint = k;
for k = 1:length(SLMexcspikemat(:,1))
    scatter(SLMexcspikemat(k,:)./1000,ones(length(SLMexcspikemat(k,:)),1).*k + indexpoint,5,'filled','g')
    hold on
end
indexpoint = indexpoint + k;
for k = 1:length(inhspikemat(:,1))
    scatter(inhspikemat(k,:)./1000,ones(length(inhspikemat(k,:)),1).*k + indexpoint,5,'filled','r')
    hold on
end
hold off
axis([0 tstop 0 indexpoint+k])
ax = gca; % current axes
ax.FontSize = font_size-4;
xlabel('Time (s)')
ylabel('Neuron Index')

if plotstats
    subplot(4,2,[5,6])
    inhISIs = diff(inhspikemat,1,2);
    SRexcISIs = diff(SRexcspikemat,1,2);
    SLMexcISIs = diff(SLMexcspikemat,1,2);
    if params4(index(1),NumberOfInhibitorySpikes) > 0
        h = histogram(inhISIs,30);
        h.FaceColor = 'r';
    else
        histogram(nan)
    end
    hold on
    if params4(index(1),NumberOfSRExcitatorySpikes) > 0 && params4(index(1),NumberOfSLMExcitatorySpikes) > 0
        h = histogram(SRexcISIs,30);
        h.FaceColor = 'b';
        hold on
        h = histogram(SLMexcISIs,30);
        h.FaceColor = 'g';
    else
        histogram(nan)
    end
    hold off
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    ylabel('Count')
    xlabel('ISI (ms)')
    
    subplot(4,2,7)
    SRexcISIs = diff(SRexcspikemat./1000,1,2);
    SRexcISIs(SRexcISIs == 0) = 0.005; % Since larger decimal point is 0.01, this prevents divisions by zero
    SRexcrate = 1./SRexcISIs;
    SRavgexcrate = mean(SRexcrate,1);
    SRstdexcrate = std(SRexcrate,0,1);
    x = 10/length(SRexcspikemat(1,:)):10/length(SRexcspikemat(1,:)):10-10/length(SRexcspikemat(1,:));
    y = SRavgexcrate;
    err = SRstdexcrate;
    if isempty(y)
        plot(nan)
    else
        plot(x,-y,'b')
    end
    hold on
    SLMexcISIs = diff(SLMexcspikemat./1000,1,2);
    SLMexcISIs(SLMexcISIs == 0) = 0.005; % Since larger decimal point is 0.01, this prevents divisions by zero
    SLMexcrate = 1./SLMexcISIs;
    SLMavgexcrate = mean(SLMexcrate,1);
    SLMstdexcrate = std(SLMexcrate,0,1);
    x3 = 10/length(SLMexcspikemat(1,:)):10/length(SLMexcspikemat(1,:)):10-10/length(SLMexcspikemat(1,:));
    y3 = SLMavgexcrate;
    err3 = SLMstdexcrate;
    if isempty(y3)
        plot(nan)
    else
        plot(x3,-y3,'g')
    end
    hold on
    inhISIs = diff(inhspikemat./1000,1,2);
    inhISIs(inhISIs == 0) = 0.005;
    inhrate = 1./inhISIs;
    avginhrate = mean(inhrate,1);
    stdinhrate = std(inhrate,0,1);
    x2 = 10/length(inhspikemat(1,:)):10/length(inhspikemat(1,:)):10-10/length(inhspikemat(1,:));
    y2 = avginhrate;
    err2 = stdinhrate;
    if isempty(y2)
        plot(nan)
    else
        plot(x2,y2,'r')
    end
    %         patch([x2 fliplr(x2)],[y2+err2 fliplr(y2-err2)],'r');
    hold off
    axis([0 tstop -200 200])
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    
    subplot(4,2,8)
    [acor,lag] = xcorr(y,y2); % SR excitatory vs inhibitory
    [acor2,lag2] = xcorr(y3,y2); % SLM excitatory vs inhibitory
    [acor3,lag3] = xcorr(y,y3); % SR excitatory vs SLM excitatory
    
    if isempty(lag) % Replace empty matrices with nans so we can plot them
        acor = nan;
        lag = nan;
    elseif isempty(lag2)
        acor2 = nan;
        lag2 = nan;
    elseif isempty(lag3)
        acor3 = nan;
        lag3 = nan;
    end
    
    plot(lag,acor,'m',lag2,acor2,'y',lag3,acor3,'c')
    xlabel('Lag (s)')
    ylabel('X-Corr')
    %         legend('SR Exc X Inh','SLM Exc X Inh','SR Exc X SLM Exc')
    ax = gca; % current axes
    ax.FontSize = font_size-2;
end

%% Plot MaxPot and STD histograms to make sure that the spike cutter is doing its job

figure(11)
subplot(2,1,1)
histogram(db_sim.data(:,maxPot))
xlabel('Max V_m (mV)')
ylabel('Count')
title('Analysis of Traces with Spikes Removed')

if max(db_sim.data(:,maxPot)) > -50
    p = get(gca, 'Position');
    line([-50 -36],[10 850],'Color','r')
    line([10 20],[850 10],'Color','r')
    h = axes('Parent', gcf, 'Position', [p(1)+.3 p(2)+.1 p(3)/2 p(4)/2]);
    histogram(h, db_sim.data(:,maxPot));
    set(h, 'Xlim', [-50 20], 'Ylim', [0 5]);
end
subplot(2,1,2)
histogram(db_sim.data(:,Std))
xlabel('V_m Std (mV)')
ylabel('Count')
if max(db_sim.data(:,maxPot)) > -50
    if sum(Case == 'SDprox1') == 7
        q = get(gca, 'Position');
        line([4 5],[10 500],'Color','r')
        line([8 9],[500 10],'Color','r')
        h = axes('Parent', gcf, 'Position', [q(1)+.45 q(2)+.1 q(3)/3.5 q(4)/2]);
        histogram(h, db_sim.data(:,Std));
        set(h, 'Xlim', [4 9], 'Ylim', [0 5]);
    elseif sum(Case == 'SDprox2') == 7
        q = get(gca, 'Position');
        line([4 5.2],[10 350],'Color','r')
        line([round(max(db_sim.data(:,Std)))-1 round(max(db_sim.data(:,Std)))],[350 10],'Color','r')
        h = axes('Parent', gcf, 'Position', [q(1)+.35 q(2)+.1 q(3)/2.2 q(4)/2]);
        histogram(h, db_sim.data(:,Std));
        set(h, 'Xlim', [4 round(max(db_sim.data(:,Std)))], 'Ylim', [0 5]);
    end
end

%%
toc