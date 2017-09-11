clear
close all
tic

directory1 = '~/Desktop/SkinnerLab/Usages/PassiveOptimization_N1/Case9StarOutput/';
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
error_vec1 = load([directory1 'model_errvec.dat']);
decaytime_vec1 = load([directory1 'model_decaytimevec.dat']);
risetime_vec1 = load([directory1 'model_risetimevec.dat']);
singlesynapseweightinh_vec1 = load([directory1 'model_minweightinhvec.dat']);
errorinh_vec1 = load([directory1 'model_errinhvec.dat']);
decaytimeinh_vec1 = load([directory1 'model_decaytimeinhvec.dat']);
risetimeinh_vec1 = load([directory1 'model_risetimeinhvec.dat']);
Dendsec_vec1 = load([directory1 'model_dendsectionvec.dat']);

dist_vec1((dist_vec1(:,1) == 0),:) = [];
singlesynapseweight_vec1((singlesynapseweight_vec1(:,1) == 0),:) = [];
error_vec1((error_vec1(:,1) == 0),:) = [];
decaytime_vec1((decaytime_vec1(:,1) == 0),:) = [];
risetime_vec1((risetime_vec1(:,1) == 0),:) = [];
singlesynapseweightinh_vec1((singlesynapseweightinh_vec1(:,1) == 0),:) = [];
errorinh_vec1((errorinh_vec1(:,1) == 0),:) = [];
decaytimeinh_vec1((decaytimeinh_vec1(:,1) == 0),:) = [];
risetimeinh_vec1((risetimeinh_vec1(:,1) == 0),:) = [];
Dendsec_vec1((Dendsec_vec1(6:end,1) == 0),:) = []; % since there are sections assigned with a zero value

Dendsec_vec1((Dendsec_vec1 == 18),:) = [];
Dendsec_vec1((Dendsec_vec1 == 19),:) = [];
Dendsec_vec1((Dendsec_vec1 == 20),:) = [];
Dendsec_vec1((Dendsec_vec1 == 21),:) = [];
Dendsec_vec1((Dendsec_vec1 == 22),:) = [];

singlesynapseweight_vec1(dist_vec1<Border) = [];
error_vec1(dist_vec1<Border) = [];
decaytime_vec1(dist_vec1<Border) = [];
risetime_vec1(dist_vec1<Border) = [];
singlesynapseweightinh_vec1(dist_vec1<Border) = [];
errorinh_vec1(dist_vec1<Border) = [];
decaytimeinh_vec1(dist_vec1<Border) = [];
risetimeinh_vec1(dist_vec1<Border) = [];
Dendsec_vec1(dist_vec1<Border) = [];
dist_vec1(dist_vec1<Border) = [];

singlesynapseweight_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
error_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
decaytime_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
risetime_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
singlesynapseweightinh_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
errorinh_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
decaytimeinh_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
risetimeinh_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
dist_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points
Dendsec_vec1(Dendsec_vec1<SecStart) = []; % only keep tree 1 data points

singlesynapseweight_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
error_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
decaytime_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
risetime_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
singlesynapseweightinh_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
errorinh_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
decaytimeinh_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
risetimeinh_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
dist_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points
Dendsec_vec1(Dendsec_vec1>SecEnd) = []; % only keep tree 1 data points

%% Plot Optimization Error at Each Distance Point
fig1 = figure(1);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [error_vec1(t(1)); error_vec1(l:i)],'k')
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
    [error_vec1(t(1)); error_vec1(i+1)],'k') % Plot last data point in vector
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Sum of Squared Error')
title('Tree 1 Distal Dendrites (SLM)')
% axis([300 max(dist_vec1)+5 -0.1 max(singlesynapseweight_vec1(dist_vec1>300))])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
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
    [singlesynapseweight_vec1(t(1)); singlesynapseweight_vec1(i+1)],'k') % Plot last data point in vector
hold on

SR_AMPA_Weights = zeros(1,length(dist_vec1));
for i = 1:length(dist_vec1)
    SR_AMPA_Weights(i) = 0.00000230814*dist_vec1(i)+0.00022016666;
end
plot(dist_vec1,SR_AMPA_Weights,'--r')

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Optimized Single Synaptic Weight (\muS)')
title('Tree 1 Distal Dendrites (SLM)')
% axis([300 max(dist_vec1)+5 -0.1 max(singlesynapseweight_vec1(dist_vec1>300))])
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
            t = l; % If no previous data points, than just replot the point after the branching point (since origing index is continuous from the proximal dendrites and therefore cutoff in this graph)
        end
        t = t(end); % Choose most recent distance that is smaller than the next branching point
        
    end
    
end

plot([dist_vec1(t(1)); dist_vec1(i+1)],...
    [risetime_vec1(t(1)); risetime_vec1(i+1)],'k') % Plot last data point in vector
hold on

SR_AMPA_Tau1 = zeros(1,length(dist_vec1));
for i = 1:length(dist_vec1)
    SR_AMPA_Tau1(i) = 0.00000109327*dist_vec1(i) + 0.00028371348;
end
plot(dist_vec1,SR_AMPA_Tau1,'--r')

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Rise Time (ms)')
title('Tree 1 Distal Dendrites (SLM)')
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
            t = l; % If no previous data points, than just replot the point after the branching point (since origing index is continuous from the proximal dendrites and therefore cutoff in this graph)
        end
        t = t(end); % Choose most recent distance that is smaller than the next branching point
        
    end
    
end

plot([dist_vec1(t(1)); dist_vec1(i+1)],...
    [decaytime_vec1(t(1)); decaytime_vec1(i+1)],'k') % Plot last data point in vector
hold on

SR_AMPA_Tau2 = zeros(1,length(dist_vec1));
for i = 1:length(dist_vec1)
    SR_AMPA_Tau2(i) = 0.00265623844*dist_vec1(i) + 2.38358338593;
end
plot(dist_vec1,SR_AMPA_Tau2,'--r')

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Decay Time (ms)')
title('Tree 1 Distal Dendrites (SLM)')
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
grid on

%% Plot Optimization Error at Each Distance Point (Inhibitory Fits)
fig10 = figure(10);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section or end of the vector
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [errorinh_vec1(t(1)); errorinh_vec1(l:i)],'k')
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
    [errorinh_vec1(t(1)); errorinh_vec1(i+1)],'k') % Plot last data point in vector
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Sum of Squared Error (Inhibitory Fits)')
title('Tree 1 Distal Dendrites (SLM)')
% axis([0 300 -1 max(singlesynapseweight_vec1)])
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

GABAA_Weights = zeros(1,length(dist_vec1));
for i = 1:length(dist_vec1)
    GABAA_Weights(i) = 0.00000469125*dist_vec1(i)+0.0002695779;
end
plot(dist_vec1,GABAA_Weights,'--r')

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Optimized Inhibitory Single Synaptic Weight (\muS)')
title('Tree 1 Distal Dendrites (SLM)')
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

GABAA_Tau1 = zeros(1,length(dist_vec1));
for i = 1:length(dist_vec1)
    GABAA_Tau1(i) = 0.00269747258*dist_vec1(i)+0.05809323294;
end
plot(dist_vec1,GABAA_Tau1,'--r')

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Inhibitory Rise Time (ms)')
title('Tree 1 Distal Dendrites (SLM)')
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

GABAA_Tau2 = zeros(1,length(dist_vec1));
for i = 1:length(dist_vec1)
    GABAA_Tau2(i) = -0.03753005336*dist_vec1(i)+5.42273762969;
end
plot(dist_vec1,GABAA_Tau2,'--r')

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Inhibitory Decay Time (ms)')
title('Tree 1 Distal Dendrites (SLM)')
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

GABAA_Pred1 = GABAA_Weights./0.00003;
GABAA_Pred2 = GABAA_Weights./0.000025;
X2 = [sort(dist_vec1)', fliplr(sort(dist_vec1)')];
Y2 = [sort(GABAA_Pred1), fliplr(sort(GABAA_Pred2))];
h2 = fill(X2,Y2,'r'); set(h2,'EdgeColor','r');

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

SR_AMPA_Pred1 = SR_AMPA_Weights./0.00003;
SR_AMPA_Pred2 = SR_AMPA_Weights./0.00001;
X2 = [sort(dist_vec1)', fliplr(sort(dist_vec1)')];
Y2 = [sort(SR_AMPA_Pred1), fliplr(sort(SR_AMPA_Pred2))];
h2 = fill(X2,Y2,'r'); set(h2,'EdgeColor','r');

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Predicted Excitatory Receptors Per Synapse')
title('Tree 1 Distal Dendrites (SLM)')
% axis([0 300 -1 max(singlesynapseweight_vec1)])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-5;
grid on

%%
% %% SLM Inputs Test
% tvec = 0:0.1:2000;
% SLMInputsVtrace1 = load([directory1 '/model_SRInputs.dat']);
% SLMnputsVtrace2 = load([directory2 '/model_SRInputs.dat']);
% SLMnputsVtrace3 = load([directory3 '/model_SRInputs.dat']);
% SLMnputsVtrace4 = load([directory4 '/model_SRInputs.dat']);
% 
% figure(5)
% plot(tvec,SLMInputsVtrace1,'k')
% hold on
% if plotSD == 1
%     plot(tvec,SLMnputsVtrace2,'b')
%     hold on
% end
% plot(tvec,SLMnputsVtrace3,'r')
% hold on
% plot(tvec,SLMnputsVtrace4,'g')
% hold off
% xlabel('Time (ms)')
% ylabel('Voltage (mV)')
% title('Simultaneous Single Synapse Input On Each Compartment')
% if plotSD == 1
%     legend('S.2','SD','SD50.1','SD50.2');
% else
%     legend('S.2','SD50.1','SD50.2');
% end
% 
% tvec = 0:0.1:2000;
% SLMInputsVtrace1 = load([directory1 '/model_SRInputs.dat']);
% SLMnputsVtrace2 = load([directory2 '/model_SRInputs.dat']);
% SLMnputsVtrace3 = load([directory3 '/model_SRInputs.dat']);
% SLMnputsVtrace4 = load([directory4 '/model_SRInputs.dat']);
% 
% figure(5)
% plot(tvec,SLMInputsVtrace1,'k')
% hold on
% if plotSD == 1
%     plot(tvec,SLMnputsVtrace2,'b')
%     hold on
% end
% plot(tvec,SLMnputsVtrace3,'r')
% hold on
% plot(tvec,SLMnputsVtrace4,'g')
% hold off
% xlabel('Time (ms)')
% ylabel('Voltage (mV)')
% title('Simultaneous Single Synapse Input On Each Compartment')
% ax = gca; % current axes
% ax.FontSize = font_size-5;
% if plotSD == 1
%     h = legend('S.2','SD','SD50.1','SD50.2');
% else
%     h = legend('S.2','SD50.1','SD50.2');
% end
% set(h,'FontSize',font_size-5)
% grid on
% 
% %% Random Inputs Test
% RandInputsVtrace1 = load([directory1 '/model_RandomInputs.dat']);
% RandInputsVtrace2 = load([directory2 '/model_RandomInputs.dat']);
% RandInputsVtrace3 = load([directory3 '/model_RandomInputs.dat']);
% RandInputsVtrace4 = load([directory4 '/model_RandomInputs.dat']);
% 
% figure(6)
% plot(tvec,RandInputsVtrace1,'k')
% hold on
% if plotSD == 1
%     plot(tvec,RandInputsVtrace2,'b')
%     hold on
% end
% plot(tvec,RandInputsVtrace3,'r')
% hold on
% plot(tvec,RandInputsVtrace4,'g')
% hold off
% xlabel('Time (ms)')
% ylabel('Voltage (mV)')
% title('Randomly Timed Inputs')
% ax = gca; % current axes
% ax.FontSize = font_size-5;
% if plotSD == 1
%     h = legend('S.2','SD','SD50.1','SD50.2');
% else
%     h = legend('S.2','SD50.1','SD50.2');
% end
% set(h,'FontSize',font_size-5)
% grid on
% 
% %% Synchronous Inhibitory Inputs and Random Excitatory Inputs
% SyncInhRandExcInputsVtrace1 = load([directory1 '/model_SyncInhRandExcInputs.dat']);
% SyncInhRandExcInputsVtrace2 = load([directory2 '/model_SyncInhRandExcInputs.dat']);
% SyncInhRandExcInputsVtrace3 = load([directory3 '/model_SyncInhRandExcInputs.dat']);
% SyncInhRandExcInputsVtrace4 = load([directory4 '/model_SyncInhRandExcInputs.dat']);
% 
% figure(7)
% plot(tvec,SyncInhRandExcInputsVtrace1,'k')
% hold on
% if plotSD == 1
%     plot(tvec,SyncInhRandExcInputsVtrace2,'b')
%     hold on
% end
% plot(tvec,SyncInhRandExcInputsVtrace3,'r')
% hold on
% plot(tvec,SyncInhRandExcInputsVtrace4,'g')
% hold off
% xlabel('Time (ms)')
% ylabel('Voltage (mV)')
% title('Synchronous (Theta) Inhibitory Inputs with Random Excitatory Inputs')
% ax = gca; % current axes
% ax.FontSize = font_size-5;
% if plotSD == 1
%     h = legend('S.2','SD','SD50.1','SD50.2');
% else
%     h = legend('S.2','SD50.1','SD50.2');
% end
% set(h,'FontSize',font_size-5)
% grid on
% 
% %% Synchronous Inhibitory Inputs and Random Excitatory Inputs
% SyncInhExcInputsVtrace1 = load([directory1 '/model_SyncInhExcInputs.dat']);
% SyncInhExcInputsVtrace2 = load([directory2 '/model_SyncInhExcInputs.dat']);
% SyncInhExcInputsVtrace3 = load([directory3 '/model_SyncInhExcInputs.dat']);
% SyncInhExcInputsVtrace4 = load([directory4 '/model_SyncInhExcInputs.dat']);
% 
% figure(8)
% plot(tvec,SyncInhExcInputsVtrace1,'k')
% hold on
% if plotSD == 1
%     plot(tvec,SyncInhExcInputsVtrace2,'b')
%     hold on
% end
% plot(tvec,SyncInhExcInputsVtrace3,'r')
% hold on
% plot(tvec,SyncInhExcInputsVtrace4,'g')
% hold off
% xlabel('Time (ms)')
% ylabel('Voltage (mV)')
% title('Synchronous (Theta) Inhibitory & Excitatory Inputs')
% ax = gca; % current axes
% ax.FontSize = font_size-5;
% if plotSD == 1
%     h = legend('S.2','SD','SD50.1','SD50.2');
% else
%     h = legend('S.2','SD50.1','SD50.2');
% end
% set(h,'FontSize',font_size-5)
% grid on
% 
% %% Bursting SR Inputs
% BurstSRInputsVtrace1 = load([directory1 '/model_SRBurstInputs.dat']);
% BurstSRInputsVtrace2 = load([directory2 '/model_SRBurstInputs.dat']);
% BurstSRInputsVtrace3 = load([directory3 '/model_SRBurstInputs.dat']);
% BurstSRInputsVtrace4 = load([directory4 '/model_SRBurstInputs.dat']);
% 
% figure(9)
% plot(tvec,BurstSRInputsVtrace1,'k')
% hold on
% if plotSD == 1
%     plot(tvec,BurstSRInputsVtrace2,'b')
%     hold on
% end
% plot(tvec,BurstSRInputsVtrace3,'r')
% hold on
% plot(tvec,BurstSRInputsVtrace4,'g')
% hold off
% xlabel('Time (ms)')
% ylabel('Voltage (mV)')
% title('Bursting SR Inputs')
% ax = gca; % current axes
% ax.FontSize = font_size-5;
% if plotSD == 1
%     h = legend('S.2','SD','SD50.1','SD50.2');
% else
%     h = legend('S.2','SD50.1','SD50.2');
% end
% set(h,'FontSize',font_size-5)
% grid on

%%

toc