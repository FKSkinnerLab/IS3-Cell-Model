clear variables
close all
tic

addpath('~/Dropbox/MSC_THESIS/CBDR_Scripts/stack-ordering')
addpath('~/Dropbox/MSC_THESIS/npy-matlab-master')

Case = 'SDprox2';
Subset = 'E_COM_I_COM';
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';
Directory = [Case '/' Subset '/Cipres_Data/output/' Subset '/NPYfiles/'];

%% Load Parameter Vectors
NumExc = readNPY([Directory Case '_' Subset '_NumExc.npy']);
NumInh = readNPY([Directory Case '_' Subset '_NumInh.npy']);
ExcSpikes = readNPY([Directory Case '_' Subset '_ExcSRSpikes.npy']);
InhSpikes = readNPY([Directory Case '_' Subset '_InhSpikes.npy']);
NumExcCommon = readNPY([Directory Case '_' Subset '_NumExcCommon.npy']);
NumInhCommon = readNPY([Directory Case '_' Subset '_NumInhCommon.npy']);

%% Load Measurement Vectors
ISICV = readNPY([Directory Case '_' Subset '_ISICV.npy']);
MeanAPamp = readNPY([Directory Case '_' Subset '_MeanAPamp.npy']);
MeanVolt = readNPY([Directory Case '_' Subset '_MeanVolt.npy']);
NumSpikes = readNPY([Directory Case '_' Subset '_NumSpikes.npy']);
StdVolt = readNPY([Directory Case '_' Subset '_StdVolt.npy']);

%% Build Database
db_sim = [double(NumInh) double(NumExc) double(InhSpikes) double(ExcSpikes) double(NumExcCommon) double(NumInhCommon) ISICV MeanVolt StdVolt double(NumSpikes) MeanAPamp];

%% Indexing of Parameters in Database
NumberOfInhibitorySyns = 1;
NumberOfExcitatorySyns = 2;
NumberOfInhibitorySpikes = 3;
NumberOfExcitatorySpikes = 4;
NumberCommonExcitatorySyns = 5;
NumberCommonInhibitorySyns = 6;

iISICV = 7;
avgPot = 8;
Std = 9;
Spikes = 10;
SpikeAmplitudeMean = 11;

% Simulation Time
tstop = 10; % in seconds

%% CBDR Variables
db_sim = sortrows(sortrows(sortrows(sortrows(db_sim,1),2),3),4);

ExcitatorySRSpikeRate = db_sim(:,NumberOfExcitatorySpikes)./tstop;
ExcitatorySLMSpikeRate = db_sim(:,NumberOfExcitatorySpikes)./tstop;
InhibitorySpikeRate = db_sim(:,NumberOfInhibitorySpikes)./tstop;

InhSynsnumparams = length(unique(db_sim(:,NumberOfInhibitorySyns))); % Find number of parameter values for each conductance
ExcSynsnumparams = length(unique(db_sim(:,NumberOfExcitatorySyns)));
InhSpikesnumparams = length(unique(InhibitorySpikeRate));
ExcSpikesnumparams = length(unique(ExcitatorySRSpikeRate)); % Only do the SR spike rates for now since the SLM spike rates are the same
InhCommonnumparams = length(unique(db_sim(:,NumberCommonInhibitorySyns)));
ExcCommonnumparams = length(unique(db_sim(:,NumberCommonExcitatorySyns)));

InhSynsmin = min(unique(db_sim(:,NumberOfInhibitorySyns))); % Find minimum parameter value for each conductance
ExcSynsmin = min(unique(db_sim(:,NumberOfExcitatorySyns)));
InhSpikesmin = min(unique(InhibitorySpikeRate));
ExcSpikesmin = min(unique(ExcitatorySRSpikeRate));
InhCommonmin = min(unique(db_sim(:,NumberCommonInhibitorySyns)));
ExcCommonmin = min(unique(db_sim(:,NumberCommonExcitatorySyns)));

InhSynsmax = max(unique(db_sim(:,NumberOfInhibitorySyns))); % Find maximum parameter value for each conductance
ExcSynsmax = max(unique(db_sim(:,NumberOfExcitatorySyns)));
InhSpikesmax = max(unique(InhibitorySpikeRate));
ExcSpikesmax = max(unique(ExcitatorySRSpikeRate));
InhCommonmax = max(unique(db_sim(:,NumberCommonInhibitorySyns)));
ExcCommonmax = max(unique(db_sim(:,NumberCommonExcitatorySyns)));

order0 = randperm(4); % Randomizes the order of dimensions for initial plotting

%% CBDR Average Potential Plots
avgPots = db_sim(:,avgPot);
Norm2 = (length(hot)-1)/diff([min(avgPots) max(avgPots)]);

Ndimdb2 = reshape(avgPots(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams]); % Reshapes distance vector into N-dimensional matrix
order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess
order = [2 4 1 3]; % If keeping axes consistent

figure(2)
figure_dim_stack(round(Ndimdb2*Norm2),order,[min(round(avgPots*Norm2)) max(round(avgPots*Norm2))],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)']});
legend('off')
h = colorbar;
caxis([min(avgPots) max(avgPots)])
ylabel(h,'Average Membrane Potential (mV)','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

saveas(gcf,[Case '_' Subset '_VMEANCBDR.pdf'])

%% ISICV CBDR
ISICVs = db_sim(:,iISICV);
ISICVs(find(isnan(ISICVs))) = 0; % Replace nans with zeros
Norm1 = (length(hot)-1)/diff([min(ISICVs) max(ISICVs)]);

Ndimdb1 = reshape(ISICVs(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb1*63)); % Optimize dimension order for minimal edginess

figure(1)
figure_dim_stack(round(Ndimdb1*Norm1),order,[min(round(ISICVs*Norm1)) max(round(ISICVs*Norm1))],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)']});
legend('off')
h = colorbar;
caxis([0 max(ISICVs)])
ylabel(h,'ISICV','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

saveas(gcf,[Case '_' Subset '_ISICVCBDR.pdf'])

%% CBDR Standard Deviation of Potential Plots
Stds = db_sim(:,Std);
Norm3 = (length(hot)-1)/diff([min(Stds) max(Stds)]);

Ndimdb3 = reshape(Stds(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess

figure(3)
figure_dim_stack(round(Ndimdb3*Norm3),order,[min(round(Stds*Norm3)) max(round(Stds*Norm3))],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)']});
legend('off')
h = colorbar;
caxis([min(Stds) max(Stds)])
ylabel(h,'Standard Deviation of Membrane Potential (mV)','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

saveas(gcf,[Case '_' Subset '_VSTDCBDR.pdf'])

%% CBDR Spike Plots
spikes = db_sim(:,Spikes);
Norm4 = (length(hot)-1)/diff([min(spikes) max(spikes)]);

Ndimdb4 = reshape(spikes(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess

figure(4)
figure_dim_stack(round(Ndimdb4*Norm4),order,[min(round(spikes*Norm4)) max(round(spikes*Norm4))],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)']});
legend('off')
h = colorbar;
caxis([min(spikes) max(spikes)])
ylabel(h,'Number of Spikes','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

saveas(gcf,[Case '_' Subset '_NSpikesCBDR.pdf'])

%% CBDR HC Metric Plots
avgPots_thresh = -66.7; % Previously -60 mV
Stds_thresh = 2.2; % Previously 3 mV
ISICVs_thresh = 0.8;

amps = db_sim(:,SpikeAmplitudeMean);
amps(amps == 0) = nan;
spikeamp_DB_thresh = 40; % Identifies models in depolarization block

HC_metric = zeros(length(db_sim(:,1)),1); % Initialize High-Conductance Metric vector

HC_metric(avgPots >= avgPots_thresh) = HC_metric(avgPots >= avgPots_thresh) + 1;
HC_metric(Stds >= Stds_thresh) = HC_metric(Stds >= Stds_thresh) + 1;
HC_metric(ISICVs >= ISICVs_thresh) = HC_metric(ISICVs >= ISICVs_thresh) + 1;

HC_metric(amps <= spikeamp_DB_thresh) = HC_metric(amps <= spikeamp_DB_thresh) - 4; % i.e. negative HC metric if in DB

Norm5 = (length(hot)-1)/diff([min(HC_metric) max(HC_metric)]);

Ndimdb5 = reshape(HC_metric(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess

figure(5)
figure_dim_stack(round(Ndimdb5*Norm5),order,[min(round(HC_metric*Norm5))+1 max(round(HC_metric*Norm5))-1],hot,...
    [],{['Number of Inhibitory Synapses (' num2str(InhSynsmin) ' to ' num2str(InhSynsmax) ')'],...
    ['Number of Excitatory Synapses (' num2str(ExcSynsmin) ' to ' num2str(ExcSynsmax) ')'],...
    ['Inhibitory Spike Rate (' num2str(InhSpikesmin) 'Hz to ' num2str(InhSpikesmax) 'Hz)'],...
    ['Excitatory Spike Rate (' num2str(ExcSpikesmin) 'Hz to ' num2str(ExcSpikesmax) 'Hz)']});
legend('off')
h = colorbar;
caxis([min(HC_metric) max(HC_metric)])
ylabel(h,'High-Conductance State Metric','FontSize',font_size)
set(findall(gcf,'type','text'),'FontSize',font_size-1,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

saveas(gcf,[Case '_' Subset '_HCMetricCBDR.pdf'])