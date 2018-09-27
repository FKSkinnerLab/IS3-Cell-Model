clear
close all
tic

directory1 = '~/Desktop/SkinnerLab/Usages/AMPAReversalPotential/Output';
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

SecStart = 0; % Plot sections SecStart to SecEnd; Tree 1 = 3-17; Tree 2A, 2B and C = 23-57; Axon = 18-22; Tree 3 = 0-2
SecEnd = 57;
% Border = 300; % Border location between SR and SLM
plotSD = 1; % Whether to plot the SD (uniform channel soma and dendrites)

%%
dist_vec1 = load([directory1 '/model_distvec.dat']);
erev_vec1 = load([directory1 '/model_erevvec.dat']);
singlesynapseweight_vec1 = load([directory1 '/model_minweightvec.dat']);
decaytime_vec1 = load([directory1 '/model_decaytimevec.dat']);
risetime_vec1 = load([directory1 '/model_risetimevec.dat']);
Dendsec_vec1 = load([directory1 '/model_dendsectionvec.dat']);

erev_vec1((dist_vec1(:,1) == 0),:) = []; % Base it on dist_vec1 indices because zeros can exist in erev_vec1
Dendsec_vec1((dist_vec1(:,1) == 0),:) = []; % since there are sections assigned with a zero value
dist_vec1((dist_vec1(:,1) == 0),:) = [];
singlesynapseweight_vec1((singlesynapseweight_vec1(:,1) == 0),:) = [];
decaytime_vec1((decaytime_vec1(:,1) == 0),:) = [];
risetime_vec1((risetime_vec1(:,1) == 0),:) = [];

Dendsec_vec1((Dendsec_vec1 == 18),:) = [];
Dendsec_vec1((Dendsec_vec1 == 19),:) = [];
Dendsec_vec1((Dendsec_vec1 == 20),:) = [];
Dendsec_vec1((Dendsec_vec1 == 21),:) = [];
Dendsec_vec1((Dendsec_vec1 == 22),:) = [];

% erev_vec1(dist_vec1<Border) = [];
% singlesynapseweight_vec1(dist_vec1<Border) = [];
% decaytime_vec1(dist_vec1<Border) = [];
% risetime_vec1(dist_vec1<Border) = [];
% Dendsec_vec1(dist_vec1<Border) = [];
% dist_vec1(dist_vec1<Border) = [];

erev_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
singlesynapseweight_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
decaytime_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
risetime_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
dist_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
Dendsec_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points

erev_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
singlesynapseweight_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
decaytime_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
risetime_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
dist_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
Dendsec_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points

%% Plot Erev at Each Distance Point
fig1 = figure(1);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [erev_vec1(t(1)); erev_vec1(l:i)],'k')
        hold on
                
        l = i+1; % Adjust starting index of branch to new branching point
        t = find(dist_vec1 < dist_vec1(i+1)); % Find all distances smaller than the next branching point
        t = t(t<l); % all t index points must be earlier (smaller) than the next branching point index
        if isempty(t) % if no smaller distances are available connect to first data point
            t = l; % If no previous data points, than just replot the point after the branching point (since origing index is continuous from the proximal dendrites and therefore cutoff in this graph)
        end
        t = t(end); % Choose most recent distance that is smaller than the next branching point
        
    end
    
end

plot([dist_vec1(t(1)); dist_vec1(i+1)],...
    [erev_vec1(t(1)); erev_vec1(i+1)],'k') % Plot last data point in vector
xlabel('Synapse Distance from Soma (\mum)')
ylabel('Reversal Potential Recorded at Soma (mV)')
title('All Dendritic Subtrees')
% axis([300 max(dist_vec1)+5 -0.1 max(singlesynapseweight_vec1(dist_vec1>300))])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
grid on

saveas(gcf,'ErevMeasure.pdf')
saveas(gcf,'ErevMeasure.png')

%%
toc