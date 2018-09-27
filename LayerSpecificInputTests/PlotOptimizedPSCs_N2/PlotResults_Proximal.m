clear
close all
tic

directory1 = '~/Desktop/SkinnerLab/Usages/PlotOptimizedPSCs_N2/Output/';
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

SecStart = 3; % Plot sections SecStart to SecEnd; Tree 1 = 3-17; Tree 2A, 2B and C = 23-57; Axon = 18-22; Tree 3 = 0-2
SecEnd = 17;
Border = 300; % Border location between SR and SLM
plotSD = 1; % Whether to plot the SD (uniform channel soma and dendrites)

%%
dist_vec1 = load([directory1 '/model_distvec.dat']);
singlesynapseweight_vec1 = load([directory1 'model_minweightvec.dat']);
decaytime_vec1 = load([directory1 'model_decaytimevec.dat']);
risetime_vec1 = load([directory1 'model_risetimevec.dat']);
singlesynapseweightinh_vec1 = load([directory1 'model_minweightinhvec.dat']);
decaytimeinh_vec1 = load([directory1 'model_decaytimeinhvec.dat']);
risetimeinh_vec1 = load([directory1 'model_risetimeinhvec.dat']);
Dendsec_vec1 = load([directory1 'model_dendsectionvec.dat']);

dist_vec1((dist_vec1(:,1) == 0),:) = [];
singlesynapseweight_vec1((singlesynapseweight_vec1(:,1) == 0),:) = [];
decaytime_vec1((decaytime_vec1(:,1) == 0),:) = [];
risetime_vec1((risetime_vec1(:,1) == 0),:) = [];
singlesynapseweightinh_vec1((singlesynapseweightinh_vec1(:,1) == 0),:) = [];
decaytimeinh_vec1((decaytimeinh_vec1(:,1) == 0),:) = [];
risetimeinh_vec1((risetimeinh_vec1(:,1) == 0),:) = [];
Dendsec_vec1((Dendsec_vec1(6:end,1) == 0),:) = []; % since there are sections assigned with a zero value

Dendsec_vec1((Dendsec_vec1 == 18),:) = [];
Dendsec_vec1((Dendsec_vec1 == 19),:) = [];
Dendsec_vec1((Dendsec_vec1 == 20),:) = [];
Dendsec_vec1((Dendsec_vec1 == 21),:) = [];
Dendsec_vec1((Dendsec_vec1 == 22),:) = [];

singlesynapseweight_vec1(dist_vec1>Border) = [];
decaytime_vec1(dist_vec1>Border) = [];
risetime_vec1(dist_vec1>Border) = [];
singlesynapseweightinh_vec1(dist_vec1>Border) = [];
decaytimeinh_vec1(dist_vec1>Border) = [];
risetimeinh_vec1(dist_vec1>Border) = [];
Dendsec_vec1(dist_vec1>Border) = [];
dist_vec1(dist_vec1>Border) = [];

singlesynapseweight_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
decaytime_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
risetime_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
singlesynapseweightinh_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
decaytimeinh_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
risetimeinh_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
dist_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
Dendsec_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points

singlesynapseweight_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
decaytime_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
risetime_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
singlesynapseweightinh_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
decaytimeinh_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
risetimeinh_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
dist_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
Dendsec_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points

%% Plot Single Synapse Weights at Each Distance Point
fig2 = figure(2);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [singlesynapseweight_vec1(t(1)); singlesynapseweight_vec1(l:i)],'k')
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

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Optimized Single Synaptic Weight (\muS)')
title('Tree 1 Proximal Dendrites (SR)')
% axis([0 300 -1 max(singlesynapseweight_vec1)])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
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

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Rise Time (ms)')
title('Tree 1 Proximal Dendrites (SR)')
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
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

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Decay Time (ms)')
title('Tree 1 Proximal Dendrites (SR)')
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
grid on

%% Plot Single Synapse Weights at Each Distance Point (Inhibitory Fits)
fig11 = figure(11);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [singlesynapseweightinh_vec1(t(1)); singlesynapseweightinh_vec1(l:i)],'k')
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
    [singlesynapseweightinh_vec1(t(1)); singlesynapseweightinh_vec1(i+1)],'k') % Plot last data point in vector
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Optimized Inhibitory Single Synaptic Weight (\muS)')
title('Tree 1 Proximal Dendrites (SR)')
% axis([0 300 -1 max(singlesynapseweight_vec1)])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
grid on

%% Plot Rise Time at Each Distance Point (Inhibitory Fits)
fig12 = figure(12);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [risetimeinh_vec1(t(1)); risetimeinh_vec1(l:i)],'k')
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
    [risetimeinh_vec1(t(1)); risetimeinh_vec1(i+1)],'k') % Plot last data point in vector
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Inhibitory Rise Time (ms)')
title('Tree 1 Proximal Dendrites (SR)')
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
grid on

%% Plot Decay Time at Each Distance Point (Inhibitory Fits)
fig13 = figure(13);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [decaytimeinh_vec1(t(1)); decaytimeinh_vec1(l:i)],'k')
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
    [decaytimeinh_vec1(t(1)); decaytimeinh_vec1(i+1)],'k') % Plot last data point in vector
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Inhibitory Decay Time (ms)')
title('Tree 1 Proximal Dendrites (SR)')
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
grid on

%% Plot Predicted Receptor/Synapse Numbers at Each Distance Point (Inhibitory Fits)
fig14 = figure(14);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        x = [dist_vec1(t(1)), dist_vec1(l:i)'];
        y1 = [singlesynapseweightinh_vec1(t(1))./0.00003, singlesynapseweightinh_vec1(l:i)'./0.00003];
        y2 = [singlesynapseweightinh_vec1(t(1))./0.000025, singlesynapseweightinh_vec1(l:i)'./0.000025];
        X=[x,fliplr(x)];
        Y=[y1,fliplr(y2)]; 
        h = fill(X,Y,'b'); set(h,'EdgeColor','b');
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

x = [dist_vec1(t(1)), dist_vec1(i+1)'];
y1 = [singlesynapseweightinh_vec1(t(1))./0.00003, singlesynapseweightinh_vec1(i+1)'./0.00003];
y2 = [singlesynapseweightinh_vec1(t(1))./0.000025, singlesynapseweightinh_vec1(i+1)'./0.000025];
X=[x,fliplr(x)];
Y=[y1,fliplr(y2)]; 
h = fill(X,Y,'b'); set(h,'EdgeColor','b');
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Predicted Inhibitory Receptors Per Synapse')
title('Tree 1 Dendrites')
% axis([0 300 -1 max(singlesynapseweight_vec1)])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
grid on

%% Plot Predicted Receptor/Synapse Numbers at Each Distance Point (Excitatory Fits)
fig15 = figure(15);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        x = [dist_vec1(t(1)), dist_vec1(l:i)'];
        y1 = [singlesynapseweight_vec1(t(1))./0.00003, singlesynapseweight_vec1(l:i)'./0.00003];
        y2 = [singlesynapseweight_vec1(t(1))./0.00001, singlesynapseweight_vec1(l:i)'./0.00001];
        X=[x,fliplr(x)];
        Y=[y1,fliplr(y2)]; 
        h = fill(X,Y,'b'); set(h,'EdgeColor','b');
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

x = [dist_vec1(t(1)), dist_vec1(i+1)'];
y1 = [singlesynapseweight_vec1(t(1))./0.00003, singlesynapseweight_vec1(i+1)'./0.00003];
y2 = [singlesynapseweight_vec1(t(1))./0.00001, singlesynapseweight_vec1(i+1)'./0.00001];
X=[x,fliplr(x)];
Y=[y1,fliplr(y2)]; 
h = fill(X,Y,'b'); set(h,'EdgeColor','b');
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Predicted Excitatory Receptors Per Synapse')
title('Tree 1 Proximal Dendrites (SR)')
% axis([0 300 -1 max(singlesynapseweight_vec1)])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
grid on

%%

toc