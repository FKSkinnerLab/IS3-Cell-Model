tic
clear
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
TopDirSim = ['~/Desktop/SkinnerLab/Usages/HighCondParamSearch/NSG/' Case '/Cipres_Data/output/' Case '/*_ExcSpikes.dat'];
% TopDirSim = ['~/Desktop/SkinnerLab/Usages/HighCondParamSearch/NSG/SDprox2/Cipres_Data/output/SDprox2/model_2_NumInh_80_NumExc_2_InhSpikes_5_ExcSpikes.dat'];

%% Simulation Database

props_sim = struct('num_params',4,'type','sim','file_type','neuron','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');

fileset_sim = params_tests_fileset(TopDirSim,...
    dt_sim,dy_sim,'Sim Dataset',props_sim);

db_sim = params_tests_db(fileset_sim);

%% Plot Results

NumberOfInhibitorySyns = 1;
NumberOfExcitatorySyns = 2;
NumberOfInhibitorySpikes = 3;
NumberOfExcitatorySpikes = 4;
ISICV = 5;
avgPot = 11;
maxPot = 12;
minPot = 13;
Std = 14;
Spikes = 64;
tstop = 0.5; % in seconds

%% CBDR ISICV Plot
db_sim.data = sortrows(sortrows(sortrows(sortrows(db_sim.data,1),2),3),4);

ExcitatorySpikeRate = db_sim.data(:,NumberOfExcitatorySpikes)./tstop;
InhibitorySpikeRate = db_sim.data(:,NumberOfInhibitorySpikes)./tstop;

InhSynsnumparams = length(unique(db_sim.data(:,NumberOfInhibitorySyns))); % Find number of parameter values for each conductance
ExcSynsnumparams = length(unique(db_sim.data(:,NumberOfExcitatorySyns)));
InhSpikesnumparams = length(unique(InhibitorySpikeRate));
ExcSpikesnumparams = length(unique(ExcitatorySpikeRate));

InhSynsmin = min(unique(db_sim.data(:,NumberOfInhibitorySyns))); % Find minimum parameter value for each conductance
ExcSynsmin = min(unique(db_sim.data(:,NumberOfExcitatorySyns)));
InhSpikesmin = min(unique(InhibitorySpikeRate));
ExcSpikesmin = min(unique(ExcitatorySpikeRate));

InhSynsmax = max(unique(db_sim.data(:,NumberOfInhibitorySyns))); % Find maximum parameter value for each conductance
ExcSynsmax = max(unique(db_sim.data(:,NumberOfExcitatorySyns)));
InhSpikesmax = max(unique(InhibitorySpikeRate));
ExcSpikesmax = max(unique(ExcitatorySpikeRate));

order0 = randperm(4); % Randomizes the order of dimensions for initial plotting

ISICVs = db_sim.data(:,ISICV); 
ISICVs(find(isnan(ISICVs))) = 0; % Replace nans with zeros
Norm1 = (length(hot)-1)/diff([min(ISICVs) max(ISICVs)]);

Ndimdb1 = reshape(ISICVs(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams]); % Reshapes distance vector into N-dimensional matrix
order = descend_edginess_order(order0,round(Ndimdb1*63)); % Optimize dimension order for minimal edginess

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

%% CBDR Average Potential Plots
avgPots = db_sim.data(:,avgPot); 
Norm2 = (length(hot)-1)/diff([min(avgPots) max(avgPots)]);

Ndimdb2 = reshape(avgPots(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess

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

%% CBDR Standard Deviation of Potential Plots
Stds = db_sim.data(:,Std); 
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

%% CBDR Spike Plots
spikes = db_sim.data(:,Spikes); 
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

%% CBDR HC Metric Plots
avgPots_thresh = -60;
Stds_thresh = 3;
ISICVs_thresh = 0.8;
HC_metric = zeros(length(db_sim.data(:,1)),1); % Initialize High-Conductance Metric vector
HC_metric(avgPots >= avgPots_thresh) = HC_metric(avgPots >= avgPots_thresh) + 1;
HC_metric(Stds >= Stds_thresh) = HC_metric(Stds >= Stds_thresh) + 1;
HC_metric(ISICVs >= ISICVs_thresh) = HC_metric(ISICVs >= ISICVs_thresh) + 1;

Norm5 = (length(hot)-1)/diff([min(HC_metric) max(HC_metric)]);

Ndimdb5 = reshape(HC_metric(:,end),[InhSynsnumparams,ExcSynsnumparams,InhSpikesnumparams,ExcSpikesnumparams]); % Reshapes distance vector into N-dimensional matrix
% order = descend_edginess_order(order0,round(Ndimdb2*63)); % Optimize dimension order for minimal edginess

figure(5)
figure_dim_stack(round(Ndimdb5*Norm5),order,[min(round(HC_metric*Norm5)) max(round(HC_metric*Norm5))],hot,...
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

%% Plot trace with highest ISICV
params = db_sim.data(find(ISICVs == max(ISICVs)),1:4);
file1 = ['~/Desktop/SkinnerLab/Usages/HighCondParamSearch/NSG/'...
    Case '/Cipres_Data/output/' Case '/model_' num2str(params(1))...
    '_NumInh_' num2str(params(2)) '_NumExc_' num2str(params(3))...
    '_InhSpikes_' num2str(params(4)) '_ExcSpikes.dat'];
tvec = 0:dt_sim:0.5; % seconds
HighISICVTrace = trace(file1,dt_sim,dy_sim,'Sim Dataset',props_sim);
figure(6)
plot(tvec,HighISICVTrace.data)
xlabel('Time (s)','FontSize',font_size)
ylabel('Voltage (mV)','FontSize',font_size)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Plot trace with highest average potential
params2 = db_sim.data(find(avgPots == max(avgPots)),1:4);
file2 = ['~/Desktop/SkinnerLab/Usages/HighCondParamSearch/NSG/'...
    Case '/Cipres_Data/output/' Case '/model_' num2str(params2(1))...
    '_NumInh_' num2str(params2(2)) '_NumExc_' num2str(params2(3))...
    '_InhSpikes_' num2str(params2(4)) '_ExcSpikes.dat'];
tvec = 0:dt_sim:0.5; % seconds
HighMeanVmTrace = trace(file2,dt_sim,dy_sim,'Sim Dataset',props_sim);
figure(7)
plot(tvec,HighMeanVmTrace.data)
xlabel('Time (s)','FontSize',font_size)
ylabel('Voltage (mV)','FontSize',font_size)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Plot trace with highest standard deviation of potential
params3 = db_sim.data(find(Stds == max(Stds)),1:4);
file3 = ['~/Desktop/SkinnerLab/Usages/HighCondParamSearch/NSG/'...
    Case '/Cipres_Data/output/' Case '/model_' num2str(params3(1))...
    '_NumInh_' num2str(params3(2)) '_NumExc_' num2str(params3(3))...
    '_InhSpikes_' num2str(params3(4)) '_ExcSpikes.dat'];
tvec = 0:dt_sim:0.5; % seconds
HighSTDTrace = trace(file3,dt_sim,dy_sim,'Sim Dataset',props_sim);
figure(8)
plot(tvec,HighSTDTrace.data)
xlabel('Time (s)','FontSize',font_size)
ylabel('Voltage (mV)','FontSize',font_size)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Plot models with high HC metric

figure(9)
params4 = db_sim.data(find(HC_metric == 3),1:4);
index = randperm(length(params4(:,1)));

for i = 1:length(params4(:,1))
    if i > 8
        break
    end
    subplot(4,2,i)
    file4 = ['~/Desktop/SkinnerLab/Usages/HighCondParamSearch/NSG/'...
        Case '/Cipres_Data/output/' Case '/model_' num2str(params4(index(i),1))...
        '_NumInh_' num2str(params4(index(i),2)) '_NumExc_' num2str(params4(index(i),3))...
        '_InhSpikes_' num2str(params4(index(i),4)) '_ExcSpikes.dat'];
    tvec = 0:dt_sim:0.5; % seconds
    HighHCTrace = trace(file4,dt_sim,dy_sim,'Sim Dataset',props_sim);
    plot(tvec,HighHCTrace.data)
    axis([0 max(tvec) -75 20])
    ax = gca; % current axes
    ax.FontSize = font_size-2;
end
text(-0.2, -125,'Time (s)','FontSize',font_size)
h = text(-0.8,100,'Voltage (mV)','FontSize',font_size);
set(h,'rotation',90)

%% Plot MaxPot and STD histograms to make sure that the spike cutter is doing its job

figure(10)
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