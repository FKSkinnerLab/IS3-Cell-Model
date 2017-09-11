clear all; close all

% Synchronous Firing Tests

OutputFolder = 'Case7Output';
Case = 'Case 7 Top Model Spike Time Variability';
noisevec = 0.01:0.01:0.1;
weightvec = 0.002:0.0001:0.008;

DATA = zeros(length(noisevec)*length(weightvec),3);
n = 0;
spiketimes_mat = zeros(length(noisevec)*length(weightvec)*10,3);
total_spikes = 1;

for noise = noisevec
    for weight = weightvec
        
        noisestr = num2str(noise);
        weightstr = num2str(weight);
        
        n = n + 1;
        SimFile = dir(['~/Desktop/SkinnerLab/Usages/Synchronous Firing Tests/' OutputFolder '/model_'...
            weightstr '_weight_' noisestr '_noisestdev_spiketimes.dat']);
        
        spiketimes = load([['~/Desktop/SkinnerLab/Usages/Synchronous Firing Tests/' OutputFolder '/'] SimFile.name]);
        spiketimes(find(spiketimes == 0)) = [];
        
        if length(spiketimes) == 1 %if only one spike in the ten cases
            spiketimes = [];
        end
        
        % Look at standard deviation in spike times
        sync = std(spiketimes); % Ensures that scenarios where the model only sometimes spiked are penalized
        
        DATA(n,:) = [noise weight sync];
        
        if sum(spiketimes>0) > 0
            
            spiketimes_vec = horzcat(spiketimes,ones(length(spiketimes),1)*sync,ones(length(spiketimes),1)*n);
            spiketimes_mat(total_spikes:(total_spikes+length(spiketimes))-1,:) = spiketimes_vec;

        end
        total_spikes = length(spiketimes) + total_spikes;
        display(n)
    end
end

spiketimes_mat(spiketimes_mat(:,1)==0,:) = [];
cat = spiketimes_mat(:,3);
spktmes = spiketimes_mat(:,1);
stddev = spiketimes_mat(:,2);
h = scatterhist(spktmes,stddev);
xlabel('Spike Time (ms)')
ylabel('Spike Time Standard Deviation')

bc=get(gcf,'color');
set(h(2:3),'visible','on','color',bc,'box','off');
% - x-axis hist
set(h(2),'xtick',[],'xcolor',bc);
set(h(2),'yticklabel',abs(get(h(2),'ytick')));
% - y-axis hist
set(h(3),'ytick',[],'ycolor',bc);
set(h(3),'xticklabel',abs(get(h(3),'xtick')));
set(h(1),'group',cat)

% Resort vectors according to StimAmp
[DATA(:,1), a_order] = sort(DATA(:,1)); 
DATA(:,2) = DATA(a_order,2);
DATA(:,3) = DATA(a_order,3);

% Reorganize vectors into matrices
X = reshape(DATA(:,1),[61,10]); 
Y = reshape(DATA(:,2),[61,10]);
Z = reshape(DATA(:,3),[61,10]);

% Create surface plot
figure(2)
surf(X,Y,Z,'FaceAlpha',.8)
xlabel('I_N_o_i_s_e Std. Dev. (nA)')
ylabel('Weight (uS)')
zlabel('Spike Time Standard Deviation (ms)')
title(Case)
colormap(flipud(bone))
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
axis([0.01 0.1 0.002 0.008 0 max(DATA(:,3))+0.1])
box on
line([0.1 0.1],[0.008 0.008],[0 max(DATA(:,3))+0.1],'LineWidth',1.3,'Color','k')
% line([0.02 0.02],[0.01 0.01],[0 max(DATA(:,3))+0.1],'LineWidth',1.3,'Color','k') % Add line to replace axis

%% Plot traces of spikes in least and most precise scenarios
% leastprecise_index = find(DATA(:,3) == max(DATA(:,3)));
% leastprecise_spiketimes = load(['~/Desktop/SkinnerLab/Usages/Synchronous Firing Tests/'...
%     OutputFolder '/model_' num2str(DATA(leastprecise_index,2)) '_weight_'...
%     num2str(DATA(leastprecise_index,1)) '_noisestdev_spiketimes.dat']);
% leastprecise_spikecount = sum(leastprecise_spiketimes>0);
% 
% DATA1 = DATA;
% DATA1(isnan(DATA1(:,3)),3) = 0;
% mostprecise_index = find(DATA1(:,3) == min(DATA1(DATA1(:,3)>0,3)));
% mostprecise_spiketimes = load(['~/Desktop/SkinnerLab/Usages/Synchronous Firing Tests/'...
%     OutputFolder '/model_' num2str(DATA1(mostprecise_index(1),2)) '_weight_'...
%     num2str(DATA1(mostprecise_index(1),1)) '_noisestdev_spiketimes.dat']);
% mostprecise_spikecount = sum(mostprecise_spiketimes>0);
% 
% 
% leastprecise_spiketimes(leastprecise_spiketimes==0) = [];
% leastprecise_spiketimes = horzcat(leastprecise_spiketimes,ones(length(leastprecise_spiketimes),1));
% mostprecise_spiketimes(mostprecise_spiketimes==0) = [];
% mostprecise_spiketimes = horzcat(mostprecise_spiketimes,ones(length(mostprecise_spiketimes),1)*2);
% spiketimes = vertcat(leastprecise_spiketimes,mostprecise_spiketimes);
% 
% scatterhist(spiketimes(:,1),spiketimes(:,2))
% xlabel('Spike Time (ms)')
% ylabel('Least Precise                     Most Precise')
