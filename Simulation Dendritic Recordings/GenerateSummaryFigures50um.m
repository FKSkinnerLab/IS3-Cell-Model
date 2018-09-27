clear all
close all
clc

font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

%%
%%% Generates Summary figures of action potential amplitudes along
%%% dendrites

files1 = dir('~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/Recordings50um/Case 8/*.dat');
files2 = dir('~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/Recordings50um/Case 9/*.dat');
files3 = dir('~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/Recordings50um/Dendritic/Case 8/*.dat');
files4 = dir('~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/Recordings50um/Dendritic/Case 9/*.dat');

for i=1:length(files1)
    load(['~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/Recordings50um/Case 8/' files1(i).name]); %eval(['load ' files1(i).name ' -dat']);
end
for i=1:length(files2)
    load(['~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/Recordings50um/Case 9/' files2(i).name]); %eval(['load ' files1(i).name ' -dat']);
end
for i=1:length(files3)
    load(['~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/Recordings50um/Dendritic/Case 8/' files3(i).name]); %eval(['load ' files1(i).name ' -dat']);
end
for i=1:length(files4)
    load(['~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/Recordings50um/Dendritic/Case 9/' files4(i).name]); %eval(['load ' files1(i).name ' -dat']);
end

Distances = [0 9.2220606 46.110303 101.44267 156.77503 202.88533];
tvec = 0.1:0.1:12000.4;

SomaRecsCase8 = [minus100pA50umCase8(:,2); X20pA50umCase8(:,2);...
    X50pA50umCase8(:,2); X500pA50umCase8(:,2)];
SomaRecsCase9 = [minus100pA50umCase9(:,2); X20pA50umCase9(:,2);...
    X50pA50umCase9(:,2); X500pA50umCase9(:,2)];
DendRecsCase8 = [X800pA50umCase8Soma(:,2) X800pA50umCase8dend045(:,2)...
    X800pA50umCase8dend25(:,2) X800pA50umCase8dend5(:,2)...
    X800pA50umCase8dend75(:,2) X800pA50umCase8dend100(:,2)];
DendRecsCase9 = [X800pA50umCase9Soma(:,2) X800pA50umCase9dend045(:,2)...
    X800pA50umCase9dend25(:,2) X800pA50umCase9dend5(:,2)...
    X800pA50umCase9dend75(:,2) X800pA50umCase9dend100(:,2)];

AmplitudesCase8 = max(DendRecsCase8)-min(DendRecsCase8); % Spike Amplitudes from baseline to peak
AmplitudesCase9 = max(DendRecsCase9)-min(DendRecsCase9); 

figure(1)
plot(Distances,AmplitudesCase8,'k-o','MarkerFaceColor',[0 0 0])
xlabel('Distance From Soma (\mum)')
ylabel('Spike Amplitude (mV)')
axis([0 210 0 150])
% title('Case 8* Dendritic Amplitudes')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(2)
plot(Distances,AmplitudesCase9,'k-o','MarkerFaceColor',[0 0 0])
xlabel('Distance From Soma (\mum)')
ylabel('Spike Amplitude (mV)')
axis([0 210 0 150])
% title('Case 9* Dendritic Amplitudes')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(3)
plot(tvec,SomaRecsCase8)
xlabel('Time (ms)')
ylabel('Membrane Potential (mV)')
axis([0 max(tvec) -150 50])
% title('Case 8* Model')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

figure(4)
plot(tvec,SomaRecsCase9)
xlabel('Time (ms)')
ylabel('Membrane Potential (mV)')
axis([0 max(tvec) -150 50])
% title('Case 9* Model')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
