clear variables
close all

ExcDirectory = '~/Desktop/SkinnerLab/Usages/PlotOptimizedPSCs_N2/Output/modelE_*_DendriteNumber.dat';
InhDirectory = '~/Desktop/SkinnerLab/Usages/PlotOptimizedPSCs_N2/Output/modelI_*_DendriteNumber.dat';
GenDirectory = '~/Desktop/SkinnerLab/Usages/PlotOptimizedPSCs_N2/Output/';
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

%%
filenames_Exc = dir(ExcDirectory);
filenames_Inh = dir(InhDirectory);
data_ExcSR = zeros(1001,173);
data_ExcSLM = zeros(1001,173);
data_Inh = zeros(151,173); 
data_Exc = zeros(1001,173); 
dist_vec = zeros(length(filenames_Exc),1);
dendnum_vec = zeros(length(filenames_Exc),1);

for i = 1:length(filenames_Exc)
    
    % Find distance from soma
    distance = str2num(filenames_Exc(i).name(8:14));
    if isempty(distance) == 1
        distance = str2num(filenames_Exc(i).name(8:13));
    end
    if isempty(distance) == 1
        distance = str2num(filenames_Exc(i).name(8:12));
    end
    dist_vec(i) = distance;
    
    % Find the dendrite section number
    dendnum = str2num(filenames_Exc(i).name(88:90));
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(89:91));
    end
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(90:92));
    end
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(88:89));
    end
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(89:90));
    end
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(90:91));
    end
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(88));
    end
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(89));
    end
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(90));
    end
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(91));
    end
    if isempty(dendnum) == 1
        dendnum = str2num(filenames_Exc(i).name(92));
    end
    dendnum_vec(i) = dendnum;
    
    if distance < 300
        data_ExcSR(:,i) = load([GenDirectory filenames_Exc(i).name]);
    elseif distance > 300
        data_ExcSLM(:,i) = load([GenDirectory filenames_Exc(i).name]);
    end
    
    data_Exc(:,i) = load([GenDirectory filenames_Exc(i).name]);
    data_Inh(:,i) = load([GenDirectory filenames_Inh(i).name]);
    
end

data_ExcSR(:,sum(data_ExcSR(:,:))==0) = [];
data_ExcSLM(:,sum(data_ExcSLM(:,:))==0) = [];
data_Inh(:,sum(data_Inh(:,:))==0) = [];
data_Exc(:,sum(data_Exc(:,:))==0) = [];

data_ExcSR = data_ExcSR.*1000;
data_ExcSLM = data_ExcSLM.*1000;
data_Inh = data_Inh.*1000;
data_Exc = data_Exc.*1000;

tvecExc = 0:0.1:100.0;
tvecInh = 0:0.1:15.0;

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
axis([5 max(tvecInh) 0 40])
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
axis([0 max(tvecExc) -21 0])
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
axis([0 max(tvecExc) -21 0])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
hold off

%% Plot specific PSCs
i = 30;
figure(4)
subplot(2,1,1)
plot(tvecExc,data_Exc(:,i),'Color','b')
ylabel('EPSC (pA)')
title(['Distance = ' num2str(dist_vec(i)) ' Section = ' num2str(dendnum_vec(i))])
axis([0 max(tvecExc) -21 0])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

subplot(2,1,2)
plot(tvecInh,data_Inh(:,i),'Color','b')
ylabel('IPSC (pA)')
xlabel('Time (ms)')
axis([5 max(tvecInh) 0 40])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

