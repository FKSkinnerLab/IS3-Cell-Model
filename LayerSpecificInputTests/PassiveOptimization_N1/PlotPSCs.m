clear variables
close all

ExcDirectory = '~/Desktop/SkinnerLab/Usages/PassiveOptimization_N1/Case9StarOutput/modelE_*_DendriteNumber.dat';
InhDirectory = '~/Desktop/SkinnerLab/Usages/PassiveOptimization_N1/Case9StarOutput/modelI_*_DendriteNumber.dat';
GenDirectory = '~/Desktop/SkinnerLab/Usages/PassiveOptimization_N1/Case9StarOutput/';
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

%%
filenames_Exc = dir(ExcDirectory);
filenames_Inh = dir(InhDirectory);
data_ExcSR = zeros(1003,173);
data_ExcSLM = zeros(1003,173);
data_Inh = zeros(152,173); 

for i = 1:length(filenames_Exc)
    
    % Find distance from soma
    distance = str2num(filenames_Exc(i).name(8:14));
    
    if distance < 300
        data_ExcSR(:,i) = load([GenDirectory filenames_Exc(i).name]);
    elseif distance > 300
        data_ExcSLM(:,i) = load([GenDirectory filenames_Exc(i).name]);
    end
    
    data_Inh(:,i) = load([GenDirectory filenames_Inh(i).name]);
    
end

data_ExcSR(:,sum(data_ExcSR(:,:))==0) = [];
data_ExcSLM(:,sum(data_ExcSLM(:,:))==0) = [];
data_Inh(:,sum(data_Inh(:,:))==0) = [];

data_ExcSR = data_ExcSR.*1000;
data_ExcSLM = data_ExcSLM.*1000;
data_Inh = data_Inh.*1000;

tvecExc = 0:0.1:100.2;
tvecInh = 0:0.1:15.1;

SLMEPSC_exp = load('~/Desktop/SkinnerLab/Usages/PassiveOptimization_N1/PPDatFile.dat');
SLMEPSC_exp(:,2) = SLMEPSC_exp(:,2).*1000;
RADEPSC_exp = load('~/Desktop/SkinnerLab/Usages/PassiveOptimization_N1/SCDatFile.dat');
RADEPSC_exp(:,2) = RADEPSC_exp(:,2).*1000;
IPSC_exp = load('~/Desktop/SkinnerLab/Usages/PassiveOptimization_N1/ISPCDatFile.dat');
IPSC_exp(:,2) = IPSC_exp(:,2).*1000;

figure(1)
plot(tvecInh,data_Inh,'Color','k')
hold on
plot(IPSC_exp(:,1),IPSC_exp(:,2),'Color','r')
title('IPSCs')
xlabel('Time (ms)')
ylabel('Current (pA)')
axis([0 max(tvecInh) 0 25])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
hold off

figure(2)
plot(tvecExc,data_ExcSR,'Color','k')
hold on
plot(RADEPSC_exp(:,1),RADEPSC_exp(:,2),'Color','r')
title('SR EPSCs')
xlabel('Time (ms)')
ylabel('Current (pA)')
axis([0 max(tvecExc) -18 0])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
hold off

figure(3)
plot(tvecExc,data_ExcSLM,'Color','k')
hold on
plot(SLMEPSC_exp(:,1),SLMEPSC_exp(:,2),'Color','r')
title('SLM EPSCs')
xlabel('Time (ms)')
ylabel('Current (pA)')
axis([0 max(tvecExc) -18 0])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
hold off
