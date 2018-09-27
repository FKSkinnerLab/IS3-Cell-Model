clear
close all
tic

directory1 = '~/Desktop/SkinnerLab/Usages/LayerSpecificInputTests_N3/Case7Output/';
directory2 = '~/Desktop/SkinnerLab/Usages/LayerSpecificInputTests_N3/Case8Output/';
directory3 = '~/Desktop/SkinnerLab/Usages/LayerSpecificInputTests_N3/Case8StarOutput/';
directory4 = '~/Desktop/SkinnerLab/Usages/LayerSpecificInputTests_N3/Case9StarOutput/';
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

SecStart = 23; % Plot sections SecStart to SecEnd; Tree 1 = 3-17; Tree 2A, 2B and C = 23-57; Axon = 18-22; Tree 3 = 0-2
SecEnd = 57;
Border = 300; % Border location between SR and SLM
plotSD = 0; % Whether to plot the SD (uniform channel soma and dendrites)

%%
dist_vec1 = load([directory1 '/model_distvec.dat']);
weight_vec1 = load([directory1 'model_weightvec.dat']);
singlesynapseweight_vec1 = load([directory1 'model_minweightvec.dat']);
error_vec1 = load([directory1 'model_errvec.dat']);
decaytime_vec1 = load([directory1 'model_decaytimevec.dat']);
risetime_vec1 = load([directory1 'model_risetimevec.dat']);
NSynapses_vec1 = load([directory1 'model_NSynapsesvec.dat']);
NSpikes_vec1 = load([directory1 'model_NumSpikes.dat']);
SpikeInterval_vec1 = load([directory1 'model_SpikeInterval.dat']);
Dendsec_vec1 = load([directory1 'model_dendsectionvec.dat']);

dist_vec1((dist_vec1(:,1) == 0),:) = [];
weight_vec1((weight_vec1(:,1) == 0),:) = [];
singlesynapseweight_vec1((singlesynapseweight_vec1(:,1) == 0),:) = [];
error_vec1((error_vec1(:,1) == 0),:) = [];
decaytime_vec1((decaytime_vec1(:,1) == 0),:) = [];
risetime_vec1((risetime_vec1(:,1) == 0),:) = [];
NSynapses_vec1((NSynapses_vec1(:,1) == 0),:) = [];
NSpikes_vec1((NSpikes_vec1(:,1) == 0),:) = [];
SpikeInterval_vec1((SpikeInterval_vec1(:,1) == 0),:) = [];
Dendsec_vec1(end) = []; % since there are sections assigned with a zero value

weight_vec1(dist_vec1>Border) = []; % Remove distance coordinates less than 300
singlesynapseweight_vec1(dist_vec1>Border) = [];
error_vec1(dist_vec1>Border) = [];
decaytime_vec1(dist_vec1>Border) = [];
risetime_vec1(dist_vec1>Border) = [];
NSynapses_vec1(dist_vec1>Border) = [];
NSpikes_vec1(dist_vec1>Border) = [];
SpikeInterval_vec1(dist_vec1>Border) = [];
Dendsec_vec1(dist_vec1>Border) = [];
dist_vec1(dist_vec1>Border) = [];

weight_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
singlesynapseweight_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
error_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
decaytime_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
risetime_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
NSynapses_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
NSpikes_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
SpikeInterval_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
dist_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
Dendsec_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
weight_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
singlesynapseweight_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
error_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
decaytime_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
risetime_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
NSynapses_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
NSpikes_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
SpikeInterval_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
dist_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
Dendsec_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points

dist_vec2 = load([directory2 '/model_distvec.dat']);
weight_vec2 = load([directory2 'model_weightvec.dat']);
singlesynapseweight_vec2 = load([directory2 'model_minweightvec.dat']);
error_vec2 = load([directory2 'model_errvec.dat']);
decaytime_vec2 = load([directory2 'model_decaytimevec.dat']);
risetime_vec2 = load([directory2 'model_risetimevec.dat']);
NSynapses_vec2 = load([directory2 'model_NSynapsesvec.dat']);
NSpikes_vec2 = load([directory2 'model_NumSpikes.dat']);
SpikeInterval_vec2 = load([directory2 'model_SpikeInterval.dat']);
Dendsec_vec2 = load([directory2 'model_dendsectionvec.dat']);

dist_vec2((dist_vec2(:,1) == 0),:) = [];
weight_vec2((weight_vec2(:,1) == 0),:) = [];
singlesynapseweight_vec2((singlesynapseweight_vec2(:,1) == 0),:) = [];
error_vec2((error_vec2(:,1) == 0),:) = [];
decaytime_vec2((decaytime_vec2(:,1) == 0),:) = [];
risetime_vec2((risetime_vec2(:,1) == 0),:) = [];
NSynapses_vec2((NSynapses_vec2(:,1) == 0),:) = [];
NSpikes_vec2((NSpikes_vec2(:,1) == 0),:) = [];
SpikeInterval_vec2((SpikeInterval_vec2(:,1) == 0),:) = [];
Dendsec_vec2(end) = [];

weight_vec2(dist_vec2>Border) = []; % Remove distance coordinates less than 300
singlesynapseweight_vec2(dist_vec2>Border) = [];
error_vec2(dist_vec2>Border) = [];
decaytime_vec2(dist_vec2>Border) = [];
risetime_vec2(dist_vec2>Border) = [];
NSynapses_vec2(dist_vec2>Border) = [];
NSpikes_vec2(dist_vec2>Border) = [];
SpikeInterval_vec2(dist_vec2>Border) = [];
Dendsec_vec2(dist_vec2>Border) = [];
dist_vec2(dist_vec2>Border) = [];

weight_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
singlesynapseweight_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
error_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
decaytime_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
risetime_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
NSynapses_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
NSpikes_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
SpikeInterval_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
dist_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
Dendsec_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
weight_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
singlesynapseweight_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
error_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
decaytime_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
risetime_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
NSynapses_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
NSpikes_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
SpikeInterval_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
dist_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
Dendsec_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points

dist_vec3 = load([directory3 '/model_distvec.dat']);
weight_vec3 = load([directory3 'model_weightvec.dat']);
singlesynapseweight_vec3 = load([directory3 'model_minweightvec.dat']);
error_vec3 = load([directory3 'model_errvec.dat']);
decaytime_vec3 = load([directory3 'model_decaytimevec.dat']);
risetime_vec3 = load([directory3 'model_risetimevec.dat']);
NSynapses_vec3 = load([directory3 'model_NSynapsesvec.dat']);
NSpikes_vec3 = load([directory3 'model_NumSpikes.dat']);
SpikeInterval_vec3 = load([directory3 'model_SpikeInterval.dat']);
Dendsec_vec3 = load([directory3 'model_dendsectionvec.dat']);

dist_vec3((dist_vec3(:,1) == 0),:) = [];
weight_vec3((weight_vec3(:,1) == 0),:) = [];
singlesynapseweight_vec3((singlesynapseweight_vec3(:,1) == 0),:) = [];
error_vec3((error_vec3(:,1) == 0),:) = [];
decaytime_vec3((decaytime_vec3(:,1) == 0),:) = [];
risetime_vec3((risetime_vec3(:,1) == 0),:) = [];
NSynapses_vec3((NSynapses_vec3(:,1) == 0),:) = [];
NSpikes_vec3((NSpikes_vec3(:,1) == 0),:) = [];
SpikeInterval_vec3((SpikeInterval_vec3(:,1) == 0),:) = [];
Dendsec_vec3(end) = [];

weight_vec3(dist_vec3>Border) = []; % Remove distance coordinates less than 300
singlesynapseweight_vec3(dist_vec3>Border) = [];
error_vec3(dist_vec3>Border) = [];
decaytime_vec3(dist_vec3>Border) = [];
risetime_vec3(dist_vec3>Border) = [];
NSynapses_vec3(dist_vec3>Border) = [];
NSpikes_vec3(dist_vec3>Border) = [];
SpikeInterval_vec3(dist_vec3>Border) = [];
Dendsec_vec3(dist_vec3>Border) = [];
dist_vec3(dist_vec3>Border) = [];

weight_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
singlesynapseweight_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
error_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
decaytime_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
risetime_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
NSynapses_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
NSpikes_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
SpikeInterval_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
dist_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
Dendsec_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
weight_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
singlesynapseweight_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
error_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
decaytime_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
risetime_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
NSynapses_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
NSpikes_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
SpikeInterval_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
dist_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
Dendsec_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points

dist_vec4 = load([directory4 '/model_distvec.dat']);
weight_vec4 = load([directory4 'model_weightvec.dat']);
singlesynapseweight_vec4 = load([directory4 'model_minweightvec.dat']);
error_vec4 = load([directory4 'model_errvec.dat']);
decaytime_vec4 = load([directory4 'model_decaytimevec.dat']);
risetime_vec4 = load([directory4 'model_risetimevec.dat']);
NSynapses_vec4 = load([directory4 'model_NSynapsesvec.dat']);
NSpikes_vec4 = load([directory4 'model_NumSpikes.dat']);
SpikeInterval_vec4 = load([directory4 'model_SpikeInterval.dat']);
Dendsec_vec4 = load([directory4 'model_dendsectionvec.dat']);

dist_vec4((dist_vec4(:,1) == 0),:) = [];
weight_vec4((weight_vec4(:,1) == 0),:) = [];
singlesynapseweight_vec4((singlesynapseweight_vec4(:,1) == 0),:) = [];
error_vec4((error_vec4(:,1) == 0),:) = [];
decaytime_vec4((decaytime_vec4(:,1) == 0),:) = [];
risetime_vec4((risetime_vec4(:,1) == 0),:) = [];
NSynapses_vec4((NSynapses_vec4(:,1) == 0),:) = [];
NSpikes_vec4((NSpikes_vec4(:,1) == 0),:) = [];
SpikeInterval_vec4((SpikeInterval_vec4(:,1) == 0),:) = [];
Dendsec_vec4(end) = [];

weight_vec4(dist_vec4>Border) = []; % Remove distance coordinates less than 300
singlesynapseweight_vec4(dist_vec4>Border) = [];
error_vec4(dist_vec4>Border) = [];
decaytime_vec4(dist_vec4>Border) = [];
risetime_vec4(dist_vec4>Border) = [];
NSynapses_vec4(dist_vec4>Border) = [];
NSpikes_vec4(dist_vec4>Border) = [];
SpikeInterval_vec4(dist_vec4>Border) = [];
Dendsec_vec4(dist_vec4>Border) = [];
dist_vec4(dist_vec4>Border) = [];

weight_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
singlesynapseweight_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
error_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
decaytime_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
risetime_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
NSynapses_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
NSpikes_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
SpikeInterval_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
dist_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
Dendsec_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
weight_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
singlesynapseweight_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
error_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
decaytime_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
risetime_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
NSynapses_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
NSpikes_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
SpikeInterval_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
dist_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
Dendsec_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points

%% Plot Optimization Error at Each Distance Point
fig1 = figure(1);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section or end of the vector
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [error_vec1(t(1)); error_vec1(l:i)],'k')
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [error_vec2(t(1)); error_vec2(l:i)],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [error_vec3(t(1)); error_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [error_vec4(t(1)); error_vec4(l:i)],'g')
        hold on
        
        l = i+1; % Adjust starting index of branch to new branching point
        t = find(dist_vec1 < dist_vec1(i+1)); % Find all distances smaller than the next compartment (which is on a new section)
        t = t(t<l); % all t index points must be earlier (smaller) than the next branching point index
        if isempty(t) % if no smaller distances are available connect to first data point
            t = 1; % If no previous data points, then just replot first data point (since origin index = 1)
        end
        t = t(end); % Choose most recent distance that is smaller than the next branching point
        
    end

end

plot([dist_vec1(t(1)); dist_vec1(i+1)],...
    [error_vec1(t(1)); error_vec1(i+1)],'k') % Plot last data point in vector
hold on
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [error_vec2(t(1)); error_vec2(i+1)],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [error_vec3(t(1)); error_vec3(i+1)],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [error_vec4(t(1)); error_vec4(i+1)],'g')
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Sum of Squared Error')
title('Tree 1 Proximal Dendrites (SR)')
% axis([0 300 -1 max(singlesynapseweight_vec1)])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2','Location','northwest');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%% Plot Single Synapse Weights at Each Distance Point
fig2 = figure(2);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [singlesynapseweight_vec1(t(1)); singlesynapseweight_vec1(l:i)],'k')
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [singlesynapseweight_vec2(t(1)); singlesynapseweight_vec2(l:i)],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [singlesynapseweight_vec3(t(1)); singlesynapseweight_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [singlesynapseweight_vec4(t(1)); singlesynapseweight_vec4(l:i)],'g')
        hold on
        
        l = i+1; % Adjust starting index of branch to new branching point
        t = find(dist_vec1 < dist_vec1(i+1)); % Find all distances smaller than the next compartment (which is on a new section)
        t = t(t<l); % all t index points must be earlier (smaller) than the next branching point index
        if isempty(t) % if no smaller distances are available connect to first data point
            t = 1; % If no previous data points, then just replot first data point (since origin index = 1)
        end
        t = t(end); % Choose most recent distance that is smaller than the next branching point
        
    end

end

plot([dist_vec1(t(1)); dist_vec1(i+1)],...
    [singlesynapseweight_vec1(t(1)); singlesynapseweight_vec1(i+1)],'k') % Plot last data point in vector
hold on
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [singlesynapseweight_vec2(t(1)); singlesynapseweight_vec2(i+1)],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [singlesynapseweight_vec3(t(1)); singlesynapseweight_vec3(i+1)],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [singlesynapseweight_vec4(t(1)); singlesynapseweight_vec4(i+1)],'g')
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Optimized Single Synaptic Weight (\muS)')
title('Tree 1 Proximal Dendrites (SR)')
% axis([0 300 -1 max(singlesynapseweight_vec1)])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2','Location','northwest');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%% Plot Rise Time at Each Distance Point
fig3 = figure(3);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [risetime_vec1(t(1)); risetime_vec1(l:i)],'k')
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [risetime_vec2(t(1)); risetime_vec2(l:i)],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [risetime_vec3(t(1)); risetime_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [risetime_vec4(t(1)); risetime_vec4(l:i)],'g')
        hold on
        
        l = i+1; % Adjust starting index of branch to new branching point
        t = find(dist_vec1 < dist_vec1(i+1)); % Find all distances smaller than the next branching point
        t = t(t<l); % all t index points must be earlier (smaller) than the next branching point index
        if isempty(t) % if no smaller distances are available connect to first data point
            t = 1; % If no previous data points, than just replot the point after the branching point (since origing index is continuous from the proximal dendrites and therefore cutoff in this graph)
        end
        t = t(end); % Choose most recent distance that is smaller than the next branching point
        
    end
    
end

plot([dist_vec1(t(1)); dist_vec1(i+1)],...
    [risetime_vec1(t(1)); risetime_vec1(i+1)],'k') % Plot last data point in vector
hold on
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [risetime_vec2(t(1)); risetime_vec2(i+1)],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [risetime_vec3(t(1)); risetime_vec3(i+1)],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [risetime_vec4(t(1)); risetime_vec4(i+1)],'g')
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Rise Time (ms)')
title('Tree 1 Proximal Dendrites (SR)')
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%% Plot Decay Time at Each Distance Point
fig4 = figure(4);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [decaytime_vec1(t(1)); decaytime_vec1(l:i)],'k')
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [decaytime_vec2(t(1)); decaytime_vec2(l:i)],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [decaytime_vec3(t(1)); decaytime_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [decaytime_vec4(t(1)); decaytime_vec4(l:i)],'g')
        hold on
        
        l = i+1; % Adjust starting index of branch to new branching point
        t = find(dist_vec1 < dist_vec1(i+1)); % Find all distances smaller than the next branching point
        t = t(t<l); % all t index points must be earlier (smaller) than the next branching point index
        if isempty(t) % if no smaller distances are available connect to first data point
            t = 1; % If no previous data points, than just replot the point after the branching point (since origing index is continuous from the proximal dendrites and therefore cutoff in this graph)
        end
        t = t(end); % Choose most recent distance that is smaller than the next branching point
        
    end
    
end

plot([dist_vec1(t(1)); dist_vec1(i+1)],...
    [decaytime_vec1(t(1)); decaytime_vec1(i+1)],'k') % Plot last data point in vector
hold on
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [decaytime_vec2(t(1)); decaytime_vec2(i+1)],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [decaytime_vec3(t(1)); decaytime_vec3(i+1)],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [decaytime_vec4(t(1)); decaytime_vec4(i+1)],'g')
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Decay Time (ms)')
title('Tree 1 Proximal Dendrites (SR)')
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%% Plot number of synapses required to elicit a spikes at each distance point
fig5 = figure(5);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [NSynapses_vec1(t(1)); NSynapses_vec1(l:i)],'k')
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [NSynapses_vec2(t(1)); NSynapses_vec2(l:i)],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [NSynapses_vec3(t(1)); NSynapses_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [NSynapses_vec4(t(1)); NSynapses_vec4(l:i)],'g')
        hold on
        
        l = i+1; % Adjust starting index of branch to new branching point
        t = find(dist_vec1 < dist_vec1(i+1)); % Find all distances smaller than the next branching point
        t = t(t<l); % all t index points must be earlier (smaller) than the next branching point index
        if isempty(t) % if no smaller distances are available connect to first data point
            t = 1; % If no previous data points, than just replot the point after the branching point (since origin index is continuous from the proximal dendrites and therefore cutoff in this graph)
        end
        t = t(end); % Choose most recent distance that is smaller than the next branching point
        
    end
    
end

plot([dist_vec1(t(1)); dist_vec1(i+1)],...
    [NSynapses_vec1(t(1)); NSynapses_vec1(i+1)],'k') % Plot last data point in vector
hold on
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [NSynapses_vec2(t(1)); NSynapses_vec2(i+1)],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [NSynapses_vec3(t(1)); NSynapses_vec3(i+1)],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [NSynapses_vec4(t(1)); NSynapses_vec4(i+1)],'g')
hold on
plot(xlim,[9 9],'r--') % Maximum density of synapses on a single compartment
xlabel('Synapse Distance from Soma (\mum)')
ylabel('Number of Synapses to Elicit a Somatic Spike')
title('Tree 1 Proximal Dendrites (SR)')
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%% Plot the spike frequency (Hz) required to elicit a spikes at each distance point
fig6 = figure(6);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [NSpikes_vec1(t(1))/0.1; NSpikes_vec1(l:i)/0.1],'k') % divide by 0.1s to convert to Hz (i.e spikes per 100 ms)
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [NSpikes_vec2(t(1))/0.1; NSpikes_vec2(l:i)/0.1],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [NSpikes_vec3(t(1))/0.1; NSpikes_vec3(l:i)/0.1],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [NSpikes_vec4(t(1))/0.1; NSpikes_vec4(l:i)/0.1],'g')
        hold on
                
        l = i+1; % Adjust starting index of branch to new branching point
        t = find(dist_vec1 < dist_vec1(i+1)); % Find all distances smaller than the next branching point
        t = t(t<l); % all t index points must be earlier (smaller) than the next branching point index
        if isempty(t) % if no smaller distances are available connect to first data point
            t = 1; % If no previous data points, than just replot the point after the branching point (since origin index is continuous from the proximal dendrites and therefore cutoff in this graph)
        end
        t = t(end); % Choose most recent distance that is smaller than the next branching point
        
    end
    
end

plot([dist_vec1(t(1)); dist_vec1(i+1)],...
    [NSpikes_vec1(t(1))/0.1; NSpikes_vec1(i+1)/0.1],'k') % Plot last data point in vector
hold on
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [NSpikes_vec2(t(1))/0.1; NSpikes_vec2(i+1)/0.1],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [NSpikes_vec3(t(1))/0.1; NSpikes_vec3(i+1)/0.1],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [NSpikes_vec4(t(1))/0.1; NSpikes_vec4(i+1)/0.1],'g')
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Spike Frequency to Elicit a Somatic Spike (Hz)')
title('Tree 1 Proximal Dendrites (SR)')
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%%

toc