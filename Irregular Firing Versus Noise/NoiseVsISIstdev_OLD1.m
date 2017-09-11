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

TopDirSim = ['~/Desktop/Irregular Firing Versus Noise/Case' Case...
    'Output/Cipres_Data/output/NSG_' CaseModel '/*_NoiseStDev_IrregularFiring.dat'];

%% Simulation Database

props_sim = struct('num_params',2,'type','sim','file_type','neuron','spike_finder', 1, 'threshold', 10,...
    'profile_method_name','getProfileAllSpikes');
fileset_sim = params_tests_fileset(TopDirSim,...
    dt_sim,dy_sim,'Sim Dataset',props_sim);
db_sim = params_tests_db(fileset_sim);

%% Plot Data
StimAmp = db_sim.data(:,1);
NoiseStDev = db_sim.data(:,2);
ISICV = db_sim.data(:,3);

% Resort vectors according to StimAmp
[StimAmp, a_order] = sort(StimAmp); 
NoiseStDev = NoiseStDev(a_order,:);
ISICV = ISICV(a_order,:);

% Reorganize vectors into matrices
X = vec2mat(StimAmp,10); 
Y = vec2mat(NoiseStDev,10);
Z = vec2mat(ISICV,10);

% Create surface plot
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
line([0.02 0.02],[0.01 0.01],[0 max(ISICV)+0.1],'LineWidth',1.3,'Color','k') % Add line to replace axis

%%

toc
