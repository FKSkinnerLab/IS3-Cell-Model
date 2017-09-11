clear
close all
tic

directory1 = '~/Desktop/SkinnerLab/Usages/SynapsesAcrossArbor/Case7Output/';
directory2 = '~/Desktop/SkinnerLab/Usages/SynapsesAcrossArbor/Case8Output/';
directory3 = '~/Desktop/SkinnerLab/Usages/SynapsesAcrossArbor/Case8StarOutput/';
directory4 = '~/Desktop/SkinnerLab/Usages/SynapsesAcrossArbor/Case9StarOutput/';
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

singlesynapseweight_vec1(dist_vec1>Border) = [];
error_vec1(dist_vec1>Border) = [];
decaytime_vec1(dist_vec1>Border) = [];
risetime_vec1(dist_vec1>Border) = [];
singlesynapseweightinh_vec1(dist_vec1>Border) = [];
errorinh_vec1(dist_vec1>Border) = [];
decaytimeinh_vec1(dist_vec1>Border) = [];
risetimeinh_vec1(dist_vec1>Border) = [];
Dendsec_vec1(dist_vec1>Border) = [];
dist_vec1(dist_vec1>Border) = [];

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

dist_vec2 = load([directory2 '/model_distvec.dat']);
singlesynapseweight_vec2 = load([directory2 'model_minweightvec.dat']);
error_vec2 = load([directory2 'model_errvec.dat']);
decaytime_vec2 = load([directory2 'model_decaytimevec.dat']);
risetime_vec2 = load([directory2 'model_risetimevec.dat']);
singlesynapseweightinh_vec2 = load([directory2 'model_minweightinhvec.dat']);
errorinh_vec2 = load([directory2 'model_errinhvec.dat']);
decaytimeinh_vec2 = load([directory2 'model_decaytimeinhvec.dat']);
risetimeinh_vec2 = load([directory2 'model_risetimeinhvec.dat']);
Dendsec_vec2 = load([directory2 'model_dendsectionvec.dat']);

dist_vec2((dist_vec2(:,1) == 0),:) = [];
singlesynapseweight_vec2((singlesynapseweight_vec2(:,1) == 0),:) = [];
error_vec2((error_vec2(:,1) == 0),:) = [];
decaytime_vec2((decaytime_vec2(:,1) == 0),:) = [];
risetime_vec2((risetime_vec2(:,1) == 0),:) = [];
singlesynapseweightinh_vec2((singlesynapseweightinh_vec2(:,1) == 0),:) = [];
errorinh_vec2((errorinh_vec2(:,1) == 0),:) = [];
decaytimeinh_vec2((decaytimeinh_vec2(:,1) == 0),:) = [];
risetimeinh_vec2((risetimeinh_vec2(:,1) == 0),:) = [];
Dendsec_vec2((Dendsec_vec2(6:end,1) == 0),:) = []; % since there are sections assigned with a zero value

Dendsec_vec2((Dendsec_vec2 == 18),:) = [];
Dendsec_vec2((Dendsec_vec2 == 19),:) = [];
Dendsec_vec2((Dendsec_vec2 == 20),:) = [];
Dendsec_vec2((Dendsec_vec2 == 21),:) = [];
Dendsec_vec2((Dendsec_vec2 == 22),:) = [];

singlesynapseweight_vec2(dist_vec2>Border) = [];
error_vec2(dist_vec2>Border) = [];
decaytime_vec2(dist_vec2>Border) = [];
risetime_vec2(dist_vec2>Border) = [];
singlesynapseweightinh_vec2(dist_vec2>Border) = [];
errorinh_vec2(dist_vec2>Border) = [];
decaytimeinh_vec2(dist_vec2>Border) = [];
risetimeinh_vec2(dist_vec2>Border) = [];
Dendsec_vec2(dist_vec2>Border) = [];
dist_vec2(dist_vec2>Border) = [];

singlesynapseweight_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
error_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
decaytime_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
risetime_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
singlesynapseweightinh_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
errorinh_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
decaytimeinh_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
risetimeinh_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
dist_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points
Dendsec_vec2(Dendsec_vec2<SecStart) = []; % only keep tree 1 data points

singlesynapseweight_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
error_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
decaytime_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
risetime_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
singlesynapseweightinh_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
errorinh_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
decaytimeinh_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
risetimeinh_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
dist_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points
Dendsec_vec2(Dendsec_vec2>SecEnd) = []; % only keep tree 1 data points

dist_vec3 = load([directory3 '/model_distvec.dat']);
singlesynapseweight_vec3 = load([directory3 'model_minweightvec.dat']);
error_vec3 = load([directory3 'model_errvec.dat']);
decaytime_vec3 = load([directory3 'model_decaytimevec.dat']);
risetime_vec3 = load([directory3 'model_risetimevec.dat']);
singlesynapseweightinh_vec3 = load([directory3 'model_minweightinhvec.dat']);
errorinh_vec3 = load([directory3 'model_errinhvec.dat']);
decaytimeinh_vec3 = load([directory3 'model_decaytimeinhvec.dat']);
risetimeinh_vec3 = load([directory3 'model_risetimeinhvec.dat']);
Dendsec_vec3 = load([directory3 'model_dendsectionvec.dat']);

dist_vec3((dist_vec3(:,1) == 0),:) = [];
singlesynapseweight_vec3((singlesynapseweight_vec3(:,1) == 0),:) = [];
error_vec3((error_vec3(:,1) == 0),:) = [];
decaytime_vec3((decaytime_vec3(:,1) == 0),:) = [];
risetime_vec3((risetime_vec3(:,1) == 0),:) = [];
singlesynapseweightinh_vec3((singlesynapseweightinh_vec3(:,1) == 0),:) = [];
errorinh_vec3((errorinh_vec3(:,1) == 0),:) = [];
decaytimeinh_vec3((decaytimeinh_vec3(:,1) == 0),:) = [];
risetimeinh_vec3((risetimeinh_vec3(:,1) == 0),:) = [];
Dendsec_vec3((Dendsec_vec3(6:end,1) == 0),:) = []; % since there are sections assigned with a zero value

Dendsec_vec3((Dendsec_vec3 == 18),:) = [];
Dendsec_vec3((Dendsec_vec3 == 19),:) = [];
Dendsec_vec3((Dendsec_vec3 == 20),:) = [];
Dendsec_vec3((Dendsec_vec3 == 21),:) = [];
Dendsec_vec3((Dendsec_vec3 == 22),:) = [];

singlesynapseweight_vec3(dist_vec3>Border) = [];
error_vec3(dist_vec3>Border) = [];
decaytime_vec3(dist_vec3>Border) = [];
risetime_vec3(dist_vec3>Border) = [];
singlesynapseweightinh_vec3(dist_vec3>Border) = [];
errorinh_vec3(dist_vec3>Border) = [];
decaytimeinh_vec3(dist_vec3>Border) = [];
risetimeinh_vec3(dist_vec3>Border) = [];
Dendsec_vec3(dist_vec3>Border) = [];
dist_vec3(dist_vec3>Border) = [];

singlesynapseweight_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
error_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
decaytime_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
risetime_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
singlesynapseweightinh_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
errorinh_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
decaytimeinh_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
risetimeinh_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
dist_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points
Dendsec_vec3(Dendsec_vec3<SecStart) = []; % only keep tree 1 data points

singlesynapseweight_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
error_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
decaytime_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
risetime_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
singlesynapseweightinh_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
errorinh_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
decaytimeinh_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
risetimeinh_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
dist_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points
Dendsec_vec3(Dendsec_vec3>SecEnd) = []; % only keep tree 1 data points

dist_vec4 = load([directory4 '/model_distvec.dat']);
singlesynapseweight_vec4 = load([directory4 'model_minweightvec.dat']);
error_vec4 = load([directory4 'model_errvec.dat']);
decaytime_vec4 = load([directory4 'model_decaytimevec.dat']);
risetime_vec4 = load([directory4 'model_risetimevec.dat']);
singlesynapseweightinh_vec4 = load([directory4 'model_minweightinhvec.dat']);
errorinh_vec4 = load([directory4 'model_errinhvec.dat']);
decaytimeinh_vec4 = load([directory4 'model_decaytimeinhvec.dat']);
risetimeinh_vec4 = load([directory4 'model_risetimeinhvec.dat']);
Dendsec_vec4 = load([directory4 'model_dendsectionvec.dat']);

dist_vec4((dist_vec4(:,1) == 0),:) = [];
singlesynapseweight_vec4((singlesynapseweight_vec4(:,1) == 0),:) = [];
error_vec4((error_vec4(:,1) == 0),:) = [];
decaytime_vec4((decaytime_vec4(:,1) == 0),:) = [];
risetime_vec4((risetime_vec4(:,1) == 0),:) = [];
singlesynapseweightinh_vec4((singlesynapseweightinh_vec4(:,1) == 0),:) = [];
errorinh_vec4((errorinh_vec4(:,1) == 0),:) = [];
decaytimeinh_vec4((decaytimeinh_vec4(:,1) == 0),:) = [];
risetimeinh_vec4((risetimeinh_vec4(:,1) == 0),:) = [];
Dendsec_vec4((Dendsec_vec4(6:end,1) == 0),:) = []; % since there are sections assigned with a zero value

Dendsec_vec4((Dendsec_vec4 == 18),:) = [];
Dendsec_vec4((Dendsec_vec4 == 19),:) = [];
Dendsec_vec4((Dendsec_vec4 == 20),:) = [];
Dendsec_vec4((Dendsec_vec4 == 21),:) = [];
Dendsec_vec4((Dendsec_vec4 == 22),:) = [];

singlesynapseweight_vec4(dist_vec4>Border) = [];
error_vec4(dist_vec4>Border) = [];
decaytime_vec4(dist_vec4>Border) = [];
risetime_vec4(dist_vec4>Border) = [];
singlesynapseweightinh_vec4(dist_vec4>Border) = [];
errorinh_vec4(dist_vec4>Border) = [];
decaytimeinh_vec4(dist_vec4>Border) = [];
risetimeinh_vec4(dist_vec4>Border) = [];
Dendsec_vec4(dist_vec4>Border) = [];
dist_vec4(dist_vec4>Border) = [];

singlesynapseweight_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
error_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
decaytime_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
risetime_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
singlesynapseweightinh_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
errorinh_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
decaytimeinh_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
risetimeinh_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
dist_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points
Dendsec_vec4(Dendsec_vec4<SecStart) = []; % only keep tree 1 data points

singlesynapseweight_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
error_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
decaytime_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
risetime_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
singlesynapseweightinh_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
errorinh_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
decaytimeinh_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
risetimeinh_vec4(Dendsec_vec4>SecEnd) = []; % only keep tree 1 data points
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

%% Plot Optimization Error at Each Distance Point (Inhibitory Fits)
fig10 = figure(10);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section or end of the vector
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [errorinh_vec1(t(1)); errorinh_vec1(l:i)],'k')
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [errorinh_vec2(t(1)); errorinh_vec2(l:i)],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [errorinh_vec3(t(1)); errorinh_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [errorinh_vec4(t(1)); errorinh_vec4(l:i)],'g')
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
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [errorinh_vec2(t(1)); errorinh_vec2(i+1)],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [errorinh_vec3(t(1)); errorinh_vec3(i+1)],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [errorinh_vec4(t(1)); errorinh_vec4(i+1)],'g')
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Sum of Squared Error (Inhibitory Fits)')
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

%% Plot Single Synapse Weights at Each Distance Point (Inhibitory Fits)
fig11 = figure(11);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [singlesynapseweightinh_vec1(t(1)); singlesynapseweightinh_vec1(l:i)],'k')
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [singlesynapseweightinh_vec2(t(1)); singlesynapseweightinh_vec2(l:i)],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [singlesynapseweightinh_vec3(t(1)); singlesynapseweightinh_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [singlesynapseweightinh_vec4(t(1)); singlesynapseweightinh_vec4(l:i)],'g')
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
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [singlesynapseweightinh_vec2(t(1)); singlesynapseweightinh_vec2(i+1)],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [singlesynapseweightinh_vec3(t(1)); singlesynapseweightinh_vec3(i+1)],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [singlesynapseweightinh_vec4(t(1)); singlesynapseweightinh_vec4(i+1)],'g')
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Optimized Inhibitory Single Synaptic Weight (\muS)')
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

%% Plot Rise Time at Each Distance Point (Inhibitory Fits)
fig12 = figure(12);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [risetimeinh_vec1(t(1)); risetimeinh_vec1(l:i)],'k')
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [risetimeinh_vec2(t(1)); risetimeinh_vec2(l:i)],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [risetimeinh_vec3(t(1)); risetimeinh_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [risetimeinh_vec4(t(1)); risetimeinh_vec4(l:i)],'g')
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
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [risetimeinh_vec2(t(1)); risetimeinh_vec2(i+1)],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [risetimeinh_vec3(t(1)); risetimeinh_vec3(i+1)],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [risetimeinh_vec4(t(1)); risetimeinh_vec4(i+1)],'g')
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Inhibitory Rise Time (ms)')
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

%% Plot Decay Time at Each Distance Point (Inhibitory Fits)
fig13 = figure(13);
l = 1;
t = 1;
for i = 1:length(dist_vec1)-1
    
    if Dendsec_vec1(i+1) ~= Dendsec_vec1(i) || i+2 > length(Dendsec_vec1) % i.e. if next data point is on a new section
        
        plot([dist_vec1(t(1)); dist_vec1(l:i)],...
            [decaytimeinh_vec1(t(1)); decaytimeinh_vec1(l:i)],'k')
        hold on
        if plotSD == 1
            plot([dist_vec2(t(1)); dist_vec2(l:i)],...
                [decaytimeinh_vec2(t(1)); decaytimeinh_vec2(l:i)],'b')
            hold on
        end
        plot([dist_vec3(t(1)); dist_vec3(l:i)],...
            [decaytimeinh_vec3(t(1)); decaytimeinh_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],...
            [decaytimeinh_vec4(t(1)); decaytimeinh_vec4(l:i)],'g')
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
if plotSD == 1
    plot([dist_vec2(t(1)); dist_vec2(i+1)],...
        [decaytimeinh_vec2(t(1)); decaytimeinh_vec2(i+1)],'b')
    hold on
end
plot([dist_vec3(t(1)); dist_vec3(i+1)],...
    [decaytimeinh_vec3(t(1)); decaytimeinh_vec3(i+1)],'r')
hold on
plot([dist_vec4(t(1)); dist_vec4(i+1)],...
    [decaytimeinh_vec4(t(1)); decaytimeinh_vec4(i+1)],'g')
hold on

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Inhibitory Decay Time (ms)')
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

%% SR Inputs Test
tvec = 0:0.1:2000;
SRInputsVtrace1 = load([directory1 '/model_SRInputs.dat']);
SRInputsVtrace2 = load([directory2 '/model_SRInputs.dat']);
SRInputsVtrace3 = load([directory3 '/model_SRInputs.dat']);
SRInputsVtrace4 = load([directory4 '/model_SRInputs.dat']);

figure(5)
plot(tvec,SRInputsVtrace1,'k')
hold on
if plotSD == 1
    plot(tvec,SRInputsVtrace2,'b')
    hold on
end
plot(tvec,SRInputsVtrace3,'r')
hold on
plot(tvec,SRInputsVtrace4,'g')
hold off
xlabel('Time (ms)')
ylabel('Voltage (mV)')
title('Simultaneous Single Synapse Input On Each Compartment')
if plotSD == 1
    legend('S.2','SD','SD50.1','SD50.2');
else
    legend('S.2','SD50.1','SD50.2');
end

tvec = 0:0.1:2000;
SRInputsVtrace1 = load([directory1 '/model_SRInputs.dat']);
SRInputsVtrace2 = load([directory2 '/model_SRInputs.dat']);
SRInputsVtrace3 = load([directory3 '/model_SRInputs.dat']);
SRInputsVtrace4 = load([directory4 '/model_SRInputs.dat']);

figure(5)
plot(tvec,SRInputsVtrace1,'k')
hold on
if plotSD == 1
    plot(tvec,SRInputsVtrace2,'b')
    hold on
end
plot(tvec,SRInputsVtrace3,'r')
hold on
plot(tvec,SRInputsVtrace4,'g')
hold off
xlabel('Time (ms)')
ylabel('Voltage (mV)')
title('Simultaneous Single Synapse Input On Each Compartment')
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%% Random Inputs Test
RandInputsVtrace1 = load([directory1 '/model_RandomInputs.dat']);
RandInputsVtrace2 = load([directory2 '/model_RandomInputs.dat']);
RandInputsVtrace3 = load([directory3 '/model_RandomInputs.dat']);
RandInputsVtrace4 = load([directory4 '/model_RandomInputs.dat']);

figure(6)
plot(tvec,RandInputsVtrace1,'k')
hold on
if plotSD == 1
    plot(tvec,RandInputsVtrace2,'b')
    hold on
end
plot(tvec,RandInputsVtrace3,'r')
hold on
plot(tvec,RandInputsVtrace4,'g')
hold off
xlabel('Time (ms)')
ylabel('Voltage (mV)')
title('Randomly Timed Inputs')
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%% Synchronous Inhibitory Inputs and Random Excitatory Inputs
SyncInhRandExcInputsVtrace1 = load([directory1 '/model_SyncInhRandExcInputs.dat']);
SyncInhRandExcInputsVtrace2 = load([directory2 '/model_SyncInhRandExcInputs.dat']);
SyncInhRandExcInputsVtrace3 = load([directory3 '/model_SyncInhRandExcInputs.dat']);
SyncInhRandExcInputsVtrace4 = load([directory4 '/model_SyncInhRandExcInputs.dat']);

figure(7)
plot(tvec,SyncInhRandExcInputsVtrace1,'k')
hold on
if plotSD == 1
    plot(tvec,SyncInhRandExcInputsVtrace2,'b')
    hold on
end
plot(tvec,SyncInhRandExcInputsVtrace3,'r')
hold on
plot(tvec,SyncInhRandExcInputsVtrace4,'g')
hold off
xlabel('Time (ms)')
ylabel('Voltage (mV)')
title('Synchronous (Theta) Inhibitory Inputs with Random Excitatory Inputs')
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%% Synchronous Inhibitory Inputs and Random Excitatory Inputs
SyncInhExcInputsVtrace1 = load([directory1 '/model_SyncInhExcInputs.dat']);
SyncInhExcInputsVtrace2 = load([directory2 '/model_SyncInhExcInputs.dat']);
SyncInhExcInputsVtrace3 = load([directory3 '/model_SyncInhExcInputs.dat']);
SyncInhExcInputsVtrace4 = load([directory4 '/model_SyncInhExcInputs.dat']);

figure(8)
plot(tvec,SyncInhExcInputsVtrace1,'k')
hold on
if plotSD == 1
    plot(tvec,SyncInhExcInputsVtrace2,'b')
    hold on
end
plot(tvec,SyncInhExcInputsVtrace3,'r')
hold on
plot(tvec,SyncInhExcInputsVtrace4,'g')
hold off
xlabel('Time (ms)')
ylabel('Voltage (mV)')
title('Synchronous (Theta) Inhibitory & Excitatory Inputs')
ax = gca; % current axes
ax.FontSize = font_size-5;
if plotSD == 1
    h = legend('S.2','SD','SD50.1','SD50.2');
else
    h = legend('S.2','SD50.1','SD50.2');
end
set(h,'FontSize',font_size-5)
grid on

%% Bursting SR Inputs
BurstSRInputsVtrace1 = load([directory1 '/model_SRBurstInputs.dat']);
BurstSRInputsVtrace2 = load([directory2 '/model_SRBurstInputs.dat']);
BurstSRInputsVtrace3 = load([directory3 '/model_SRBurstInputs.dat']);
BurstSRInputsVtrace4 = load([directory4 '/model_SRBurstInputs.dat']);

figure(9)
plot(tvec,BurstSRInputsVtrace1,'k')
hold on
if plotSD == 1
    plot(tvec,BurstSRInputsVtrace2,'b')
    hold on
end
plot(tvec,BurstSRInputsVtrace3,'r')
hold on
plot(tvec,BurstSRInputsVtrace4,'g')
hold off
xlabel('Time (ms)')
ylabel('Voltage (mV)')
title('Bursting SR Inputs')
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