tic
clear all
close all

addpath('~/Dropbox/MSC_THESIS/Pandora 1.3b/pandora')
addpath('~/Dropbox/MSC_THESIS/Pandora_Matlab - In Progress Scripts/stack-ordering')


%%% Plot noise standard deviation against ISI standard deviation %%%

%% Paramaters

dt_sim = 0.0001;
dy_sim = 0.001;

% Case = '7';
% CaseModel = 'Case7TopModel';
% Case = '8';
% CaseModel = 'Case8TopModel';
% Case = '8Star';
% CaseModel = 'Case8Star';
Case = '9Star';
CaseModel = 'Case9Star';

TopDirSim = ['~/Desktop/Irregular Firing Analysis/Case' Case...
    'Output/NSG_' CaseModel '/*_NoiseStDev_IrregularFiring.dat'];

%% Simulation Database

props_sim = struct('num_params',2,'type','sim','file_type','neuron','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');
fileset_sim = params_tests_fileset(TopDirSim,...
    dt_sim,dy_sim,'Sim Dataset',props_sim);
db_sim = params_tests_db(fileset_sim);

%% Plot all coefficients of variation of the interspike intervals
StimAmp = db_sim.data(:,1);
NoiseStDev = db_sim.data(:,2);
ISICV = db_sim.data(:,3);

% Resort vectors according to StimAmp
[StimAmp, a_order] = sort(StimAmp); 
NoiseStDev = NoiseStDev(a_order,:);
ISICV = ISICV(a_order,:);

% Reorganize vectors into matrices
X = reshape(StimAmp,[61,10]); 
Y = reshape(NoiseStDev,[61,10]);
Z = reshape(ISICV,[61,10]);

% Create surface plot
figure(1)
surf(X,Y,Z,'FaceAlpha',.8)
xlabel('I_I_n_j (nA)')
ylabel('I_N_o_i_s_e Std. Dev. (nA)')
zlabel('ISI CV')
title(CaseModel)
colormap(flipud(bone))
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
axis([0.02 0.05 0.01 0.1 0 max(ISICV)+0.1])
box on
% line([0.02 0.02],[0.1 0.1],[0 max(ISICV)+0.1],'LineWidth',1.3,'Color','k')
% line([0.02 0.02],[0.01 0.01],[0 max(ISICV)+0.1],'LineWidth',1.3,'Color','k') % Add line to replace axis

%% Plot max & min ISI CV traces
% Max ISI CV Plot
maxISICV = max(db_sim.data(:,3));
maxStimAmp = db_sim.data(find(db_sim.data(:,3) == max(db_sim.data(:,3))),1);
maxNoiseStDev = db_sim.data(find(db_sim.data(:,3) == max(db_sim.data(:,3))),2);

maxDirSim = ['~/Desktop/Irregular Firing Analysis/Case' Case...
    'Output/NSG_' CaseModel '/zmodel_' num2str(maxStimAmp) '_StimAmp_' ...
    num2str(maxNoiseStDev) '_NoiseStDev_IrregularFiring.dat'];

maxISICVtrace = trace(maxDirSim,dt_sim,dy_sim,'simdata',props_sim);
x = maxISICVtrace.data;
tv = 0.1:0.1:5000.1;

figure(2)
plot(tv,x)
xlabel('Time [ms]')
ylabel('Voltage [mV]')
title('Max ISI CV Trace')
a1 = annotation('textbox',[0.6 0.8 0.25 0.06],'string',['ISI CV = ' num2str(maxISICV)]);
a2 = annotation('textbox',[0.6 0.74 0.25 0.06],'string',['I_i_n_j = ' num2str(maxStimAmp) ' nA']);
a3 = annotation('textbox',[0.6 0.68 0.25 0.06],'string',['I_N_o_i_s_e = ' num2str(maxNoiseStDev) ' nA']);
a1.BackgroundColor = 'w';
a2.BackgroundColor = 'w';
a3.BackgroundColor = 'w';
axis([0 max(tv) -80 60])

% Median ISI CV Plot
[idx,idx] = min(abs(db_sim.data(:,3)-nanmedian(db_sim.data(:,3))));
midISICV = db_sim.data(idx,3);
midStimAmp = db_sim.data(find(db_sim.data(:,3) == db_sim.data(idx,3)),1);
midNoiseStDev = db_sim.data(find(db_sim.data(:,3) == db_sim.data(idx,3)),2);

midDirSim = ['~/Desktop/Irregular Firing Analysis/Case' Case...
    'Output/NSG_' CaseModel '/zmodel_' num2str(midStimAmp) '_StimAmp_' ...
    num2str(midNoiseStDev) '_NoiseStDev_IrregularFiring.dat'];

midISICVtrace = trace(midDirSim,dt_sim,dy_sim,'simdata',props_sim);
z = midISICVtrace.data;
tv = 0.1:0.1:5000.1;

figure(3)
plot(tv,z)
xlabel('Time [ms]')
ylabel('Voltage [mV]')
title('Mid ISI CV Trace')
a4 = annotation('textbox',[0.6 0.8 0.25 0.06],'string',['ISI CV = ' num2str(midISICV)]);
a5 = annotation('textbox',[0.6 0.74 0.25 0.06],'string',['I_i_n_j = ' num2str(midStimAmp) ' nA']);
a6 = annotation('textbox',[0.6 0.68 0.25 0.06],'string',['I_N_o_i_s_e = ' num2str(midNoiseStDev) ' nA']);
a4.BackgroundColor = 'w';
a5.BackgroundColor = 'w';
a6.BackgroundColor = 'w';
axis([0 max(tv) -80 60])

% Mean ISI CV plots
[idx2,idx2] = min(abs(db_sim.data(:,3)-nanmean(db_sim.data(:,3))));
meanISICV = db_sim.data(idx2,3);
meanStimAmp = db_sim.data(find(db_sim.data(:,3) == db_sim.data(idx2,3)),1);
meanNoiseStDev = db_sim.data(find(db_sim.data(:,3) == db_sim.data(idx2,3)),2);

meanDirSim = ['~/Desktop/Irregular Firing Analysis/Case' Case...
    'Output/NSG_' CaseModel '/zmodel_' num2str(meanStimAmp) '_StimAmp_' ...
    num2str(meanNoiseStDev) '_NoiseStDev_IrregularFiring.dat'];

meanISICVtrace = trace(meanDirSim,dt_sim,dy_sim,'simdata',props_sim);
v = meanISICVtrace.data;
tv = 0.1:0.1:5000.1;

figure(4)
plot(tv,v)
xlabel('Time [ms]')
ylabel('Voltage [mV]')
title('Mean ISI CV Trace')
a7 = annotation('textbox',[0.6 0.8 0.25 0.06],'string',['ISI CV = ' num2str(meanISICV)]);
a8 = annotation('textbox',[0.6 0.74 0.25 0.06],'string',['I_i_n_j = ' num2str(meanStimAmp) ' nA']);
a9 = annotation('textbox',[0.6 0.68 0.25 0.06],'string',['I_N_o_i_s_e = ' num2str(meanNoiseStDev) ' nA']);
a7.BackgroundColor = 'w';
a8.BackgroundColor = 'w';
a9.BackgroundColor = 'w';
axis([0 max(tv) -80 60])

% Min ISI CV Plot
minISICV = min(db_sim.data(db_sim.data(:,3)>0,3));
minStimAmp = db_sim.data(find(db_sim.data(:,3) == min(db_sim.data(db_sim.data(:,3)>0,3))),1);
minNoiseStDev = db_sim.data(find(db_sim.data(:,3) == min(db_sim.data(db_sim.data(:,3)>0,3))),2);

minDirSim = ['~/Desktop/Irregular Firing Analysis/Case' Case...
    'Output/NSG_' CaseModel '/zmodel_' num2str(minStimAmp) '_StimAmp_' ...
    num2str(minNoiseStDev) '_NoiseStDev_IrregularFiring.dat'];

minISICVtrace = trace(minDirSim,dt_sim,dy_sim,'simdata',props_sim);
y = minISICVtrace.data;
tv = 0.1:0.1:5000.1;

figure(5)
plot(tv,y)
xlabel('Time [ms]')
ylabel('Voltage [mV]')
title('Min ISI CV Trace')
a10 = annotation('textbox',[0.6 0.8 0.25 0.06],'string',['ISI CV = ' num2str(minISICV)]);
a11 = annotation('textbox',[0.6 0.74 0.25 0.06],'string',['I_i_n_j = ' num2str(minStimAmp) ' nA']);
a12 = annotation('textbox',[0.6 0.68 0.25 0.06],'string',['I_N_o_i_s_e = ' num2str(minNoiseStDev) ' nA']);
a10.BackgroundColor = 'w';
a11.BackgroundColor = 'w';
a12.BackgroundColor = 'w';
axis([0 max(tv) -80 60])

%%

toc
