clear all
close all
clc

font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

%%
%%% Generates Summary figures of action potential amplitudes along
%%% dendrites
Case = 9;
tvec = 0.1:0.1:3000.1;
Recordings = load(['~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/SD50TopModels/Case'...
    num2str(Case) 'StarModel/Recordings/model_' num2str(Case) '_Case_DendriteRecordings.dat']);
Distances = load(['~/Desktop/SkinnerLab/Usages/Simulation Dendritic Recordings/SD50TopModels/Case'...
    num2str(Case) 'StarModel/Recordings/model_' num2str(Case) '_Case_Distances.dat']);

Recs = [Recordings(1:30001) Recordings(30002:60002) Recordings(60003:90003) ...
    Recordings(90004:120004) Recordings(120005:150005) Recordings(150006:180006)];

Amplitudes = max(Recs)-min(Recs); % Spike Amplitudes from baseline to peak

plot(Distances,Amplitudes,'k-o','MarkerFaceColor',[0 0 0])
xlabel('Distance From Soma (\mum)')
ylabel('Spike Amplitude (mV)')
axis([0 max(Distances)+5 0 150])
% title(['Case ' num2str(Case) ' Dendritic Amplitudes'])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;