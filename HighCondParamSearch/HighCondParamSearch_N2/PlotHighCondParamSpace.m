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

Case = 'SDprox1_LooseBalance';
pcinfo=java.net.InetAddress.getLocalHost;

TopDirSim = ['~/Desktop/SkinnerLab/Usages/HighCondParamSearch_N2/NSG/' Case '/Cipres_Data/output/' Case '/model_*_ExcSpikes.dat'];
if min(pcinfo.getHostName == 'mango') == 1
    TopDirSim = ['/home/alexandreguet-mccreight/Resilio Sync/SkinnerLab/Usages/HighCondParamSearch_N2/NSG/' Case '/Cipres_Data/output/' Case '/model_*_ExcSpikes.dat'];
end
% TopDirSim = ['~/Desktop/SkinnerLab/Usages/HighCondParamSearch/NSG/SDprox2/Cipres_Data/output/SDprox2/model_2_NumInh_80_NumExc_2_InhSpikes_5_ExcSpikes.dat'];

%% Simulation Database

props_sim = struct('num_params',4,'type','sim','file_type','neuron','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');

fileset_sim = params_tests_fileset(TopDirSim,...
    dt_sim,dy_sim,'Sim Dataset',props_sim);

db_sim = params_tests_db(fileset_sim);
save(Case) % Save Database
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
tstop = 10; % in seconds

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
Stds_thresh = 2;
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

dir = '~/Desktop/';
if min(pcinfo.getHostName == 'mango') == 1
    dir = '/home/alexandreguet-mccreight/Resilio Sync/';
end

params = db_sim.data(find(ISICVs == max(ISICVs)),1:4);
file1 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N2/NSG/'...
    Case '/Cipres_Data/output/' Case '/model_' num2str(params(1))...
    '_NumInh_' num2str(params(2)) '_NumExc_' num2str(params(3))...
    '_InhSpikes_' num2str(params(4)) '_ExcSpikes.dat'];
tvec = 0:dt_sim:tstop; % seconds
HighISICVTrace = trace(file1,dt_sim,dy_sim,'Sim Dataset',props_sim);
figure(6)
plot(tvec,HighISICVTrace.data)
xlabel('Time (s)','FontSize',font_size)
ylabel('Voltage (mV)','FontSize',font_size)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Plot trace with highest average potential
params2 = db_sim.data(find(avgPots == max(avgPots)),1:4);
file2 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N2/NSG/'...
    Case '/Cipres_Data/output/' Case '/model_' num2str(params2(1))...
    '_NumInh_' num2str(params2(2)) '_NumExc_' num2str(params2(3))...
    '_InhSpikes_' num2str(params2(4)) '_ExcSpikes.dat'];
tvec = 0:dt_sim:tstop; % seconds
HighMeanVmTrace = trace(file2,dt_sim,dy_sim,'Sim Dataset',props_sim);
figure(7)
plot(tvec,HighMeanVmTrace.data)
xlabel('Time (s)','FontSize',font_size)
ylabel('Voltage (mV)','FontSize',font_size)
ax = gca; % current axes
ax.FontSize = font_size-2;

%% Plot trace with highest standard deviation of potential
params3 = db_sim.data(find(Stds == max(Stds)),1:4);
file3 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N2/NSG/'...
    Case '/Cipres_Data/output/' Case '/model_' num2str(params3(1))...
    '_NumInh_' num2str(params3(2)) '_NumExc_' num2str(params3(3))...
    '_InhSpikes_' num2str(params3(4)) '_ExcSpikes.dat'];
tvec = 0:dt_sim:tstop; % seconds
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
plotstats = 1;
if plotstats
    vind = [1 3];
    rind = [5 7];
    isiind = [9 11];
    finde = [13 15];
    cind = [14 16];
else
    vind = [1 3 9 11];
    rind = [5 7 13 15];
end

for i = 1:length(params4(:,1))
    if i > 2 && plotstats
        break
    elseif i > 4
        break
    end
    subplot(4,4,[vind(i),vind(i)+1])
    file4 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N2/NSG/'...
        Case '/Cipres_Data/output/' Case '/model_' num2str(params4(index(i),1))...
        '_NumInh_' num2str(params4(index(i),2)) '_NumExc_' num2str(params4(index(i),3))...
        '_InhSpikes_' num2str(params4(index(i),4)) '_ExcSpikes.dat'];
    tvec = 0:dt_sim:tstop; % seconds
    HighHCTrace = trace(file4,dt_sim,dy_sim,'Sim Dataset',props_sim);
    plot(tvec,HighHCTrace.data)
    axis([0 max(tvec) -75 20])
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    ylabel('Voltage (mV)')
    xlabel('Time (s)')
    
    
    subplot(4,4,[rind(i),rind(i)+1])
    file5 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N2/NSG/'...
        Case '/Cipres_Data/output/' Case '/InhPreSpikeTrains_' num2str(params4(index(i),1))...
        '_NumInh_' num2str(params4(index(i),2)) '_NumExc_' num2str(params4(index(i),3))...
        '_InhSpikes_' num2str(params4(index(i),4)) '_ExcSpikes.dat'];
    file6 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N2/NSG/'...
        Case '/Cipres_Data/output/' Case '/ExcPreSpikeTrains_' num2str(params4(index(i),1))...
        '_NumInh_' num2str(params4(index(i),2)) '_NumExc_' num2str(params4(index(i),3))...
        '_InhSpikes_' num2str(params4(index(i),4)) '_ExcSpikes.dat'];
    inhspikemat = dlmread(file5,'',1,0);
    excspikemat = dlmread(file6,'',1,0);
    
    for k = 1:length(excspikemat(:,1))
        scatter(excspikemat(k,:)./1000,ones(length(excspikemat(k,:)),1).*k,5,'filled','b')
        hold on
    end
    indexpoint = k;
    for k = 1:length(inhspikemat(:,1))
        scatter(inhspikemat(k,:)./1000,ones(length(inhspikemat(k,:)),1).*k + indexpoint,5,'filled','r')
        hold on
    end
    hold off
    axis([0 tstop 0 indexpoint+k])
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    xlabel('Time (s)')
    ylabel('Neuron Index')
    
    if plotstats
        subplot(4,4,[isiind(i),isiind(i)+1])
        inhISIs = diff(inhspikemat,1,2);
        excISIs = diff(excspikemat,1,2);
        histogram(excISIs)
        hold on
        histogram(inhISIs)
        hold off
        ax = gca; % current axes
        ax.FontSize = font_size-2;
        ylabel('Count')
        xlabel('ISI (ms)')

        subplot(4,4,finde(i))
        excISIs = diff(excspikemat./1000,1,2);
        excISIs(excISIs == 0) = 0.005; % Since larger decimal point is 0.01, this prevents divisions by zero
        excrate = 1./excISIs;
        avgexcrate = mean(excrate,1);
        stdexcrate = std(excrate,0,1);
        x = 10/length(excspikemat(1,:)):10/length(excspikemat(1,:)):10-10/length(excspikemat(1,:));
        y = avgexcrate;
        err = stdexcrate;
        plot(x,-y,'b')
%         patch([x fliplr(x)],[y+err fliplr(y-err)],'b');
        hold on
        inhISIs = diff(inhspikemat./1000,1,2);
        inhISIs(inhISIs == 0) = 0.005;
        inhrate = 1./inhISIs;
        avginhrate = mean(inhrate,1);
        stdinhrate = std(inhrate,0,1);
        x2 = 10/length(inhspikemat(1,:)):10/length(inhspikemat(1,:)):10-10/length(inhspikemat(1,:));
        y2 = avginhrate;
        err2 = stdinhrate;
        plot(x2,y2,'r')
%         patch([x2 fliplr(x2)],[y2+err2 fliplr(y2-err2)],'r');
        hold off
        axis([0 tstop min(-y) max(y2)])
        xlabel('Time (s)')
        ylabel('Frequency (Hz)')
        ax = gca; % current axes
        ax.FontSize = font_size-2;
        
        subplot(4,4,cind(i))
        [acor,lag] = xcorr(y,y2);
        plot(lag,acor,'k')
        xlabel('Lag (s)')
        ylabel('X-Corr')
        ax = gca; % current axes
        ax.FontSize = font_size-2;
    end
end

%% Plot E/I High Conductance Models in Scatter
Erate = nan(1,length(params4(:,1)));
Irate = nan(1,length(params4(:,1)));
Esyns = nan(1,length(params4(:,1)));
Isyns = nan(1,length(params4(:,1)));
EIrateRatio = nan(1,length(params4(:,1)));
EIsynRatio = nan(1,length(params4(:,1)));

figure(10)
for i = 1:length(params4(:,1))
    
    file5 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N2/NSG/'...
        Case '/Cipres_Data/output/' Case '/InhPreSpikeTrains_' num2str(params4(index(i),1))...
        '_NumInh_' num2str(params4(index(i),2)) '_NumExc_' num2str(params4(index(i),3))...
        '_InhSpikes_' num2str(params4(index(i),4)) '_ExcSpikes.dat'];
    file6 = [dir 'SkinnerLab/Usages/HighCondParamSearch_N2/NSG/'...
        Case '/Cipres_Data/output/' Case '/ExcPreSpikeTrains_' num2str(params4(index(i),1))...
        '_NumInh_' num2str(params4(index(i),2)) '_NumExc_' num2str(params4(index(i),3))...
        '_InhSpikes_' num2str(params4(index(i),4)) '_ExcSpikes.dat'];
    inhspikemat = dlmread(file5,'',1,0);
    excspikemat = dlmread(file6,'',1,0);
    
    Erate(i) = length(excspikemat(1,:))/tstop;
    Irate(i) = length(inhspikemat(1,:))/tstop;
    EIrateRatio(i) = Erate(i)/Irate(i);
    Esyns(i) = length(excspikemat(:,1));
    Isyns(i) = length(inhspikemat(:,1));
    EIsynRatio(i) = Esyns(i)/Isyns(i);
end
Edom_syn = EIsynRatio(EIsynRatio>1 & EIrateRatio>1);
Edom_rate = EIrateRatio(EIsynRatio>1 & EIrateRatio>1);
Idom_syn = EIsynRatio(EIsynRatio<1 & EIrateRatio<1);
Idom_rate = EIrateRatio(EIsynRatio<1 & EIrateRatio<1);
Esyndom_Iratedom_syn = EIsynRatio(EIsynRatio>1 & EIrateRatio<1);
Esyndom_Iratedom_rate = EIrateRatio(EIsynRatio>1 & EIrateRatio<1);
Eratedom_Isyndom_syn = EIsynRatio(EIsynRatio<1 & EIrateRatio>1);
Eratedom_Isyndom_rate = EIrateRatio(EIsynRatio<1 & EIrateRatio>1);
Even_syn = EIsynRatio(EIsynRatio==1 | EIrateRatio==1);
Even_rate = EIrateRatio(EIsynRatio==1 | EIrateRatio==1);

scatter(Edom_syn,Edom_rate,10,'filled','b')
hold on
scatter(Idom_syn,Idom_rate,10,'filled','r')
scatter(Esyndom_Iratedom_syn,Esyndom_Iratedom_rate,10,'filled','g')
scatter(Eratedom_Isyndom_syn,Eratedom_Isyndom_rate,10,'filled','o')
scatter(Even_syn,Even_rate,10,'filled','k')
plot([1 1],[0 max(EIrateRatio)],'--r')
plot([0 max(EIsynRatio)],[1 1],'--r')
hold off
xlabel('E/I Synapse Ratio')
ylabel('E/I Spike Rate Ratio')
title('E/I Balances in HC Models')
ax = gca; % current axes
ax.FontSize = font_size-6;
[h, ~] = legend('show','E Dominant','I Dominant',sprintf('E Syn/I Rate \nDominant'),sprintf('I Syn/E Rate \nDominant'),'Even');
h.Location = 'northeast';

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