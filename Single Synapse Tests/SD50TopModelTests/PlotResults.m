close all; clear all;

%%% Plot the results from the single synapse simulations %%%
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

%% Load Files
Case = 'Case9StarOutput';
Case1 = '9Star';
ResultFiles = dir(['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/SD50TopModelTests/NSG_SIMS/output/' Case '/Cipres_Data/output/' Case1 '/*.dat']);

for i=1:length(ResultFiles)
    load([['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/SD50TopModelTests/NSG_SIMS/output/' Case '/Cipres_Data/output/' Case1 '/'] ResultFiles(i).name]); %eval(['load ' files1(i).name ' -dat']);
end

%% Adjust distances: Tree 1 (i.e. dist = total previous dist + dist)

model_1_dend_distvec = model_0_dend_distvec(end) + model_1_dend_distvec;
model_2_dend_distvec = model_0_dend_distvec(end) + model_2_dend_distvec;

%% Adjust distances: Tree 2

model_4_dend_distvec = model_3_dend_distvec(end) + model_4_dend_distvec;
model_5_dend_distvec = model_3_dend_distvec(end) + model_5_dend_distvec;

model_6_dend_distvec = model_5_dend_distvec(end) + model_6_dend_distvec;
model_7_dend_distvec = model_5_dend_distvec(end) + model_7_dend_distvec;

model_8_dend_distvec = model_7_dend_distvec(end) + model_8_dend_distvec;
model_9_dend_distvec = model_8_dend_distvec(end) + model_9_dend_distvec;
model_10_dend_distvec = model_8_dend_distvec(end) + model_10_dend_distvec;

model_11_dend_distvec = model_7_dend_distvec(end) + model_11_dend_distvec;
model_12_dend_distvec = model_11_dend_distvec(end) + model_12_dend_distvec;
model_13_dend_distvec = model_12_dend_distvec(end) + model_13_dend_distvec;
model_14_dend_distvec = model_12_dend_distvec(end) + model_14_dend_distvec;

model_15_dend_distvec = model_11_dend_distvec(end) + model_15_dend_distvec;
model_16_dend_distvec = model_15_dend_distvec(end) + model_16_dend_distvec;
model_17_dend_distvec = model_15_dend_distvec(end) + model_17_dend_distvec;

%% Adjust distances: Tree 23

model_24_dend_distvec = model_23_dend_distvec(end) + model_24_dend_distvec;
model_25_dend_distvec = model_24_dend_distvec(end) + model_25_dend_distvec;
model_26_dend_distvec = model_25_dend_distvec(end) + model_26_dend_distvec;
model_27_dend_distvec = model_25_dend_distvec(end) + model_27_dend_distvec;

model_28_dend_distvec = model_24_dend_distvec(end) + model_28_dend_distvec;
model_29_dend_distvec = model_28_dend_distvec(end) + model_29_dend_distvec;
model_30_dend_distvec = model_29_dend_distvec(end) + model_30_dend_distvec;
model_31_dend_distvec = model_29_dend_distvec(end) + model_31_dend_distvec;

model_32_dend_distvec = model_28_dend_distvec(end) + model_32_dend_distvec;
model_33_dend_distvec = model_32_dend_distvec(end) + model_33_dend_distvec;
model_34_dend_distvec = model_32_dend_distvec(end) + model_34_dend_distvec;
model_35_dend_distvec = model_34_dend_distvec(end) + model_35_dend_distvec;
model_36_dend_distvec = model_35_dend_distvec(end) + model_36_dend_distvec;
model_37_dend_distvec = model_35_dend_distvec(end) + model_37_dend_distvec;

model_38_dend_distvec = model_34_dend_distvec(end) + model_38_dend_distvec;
model_39_dend_distvec = model_38_dend_distvec(end) + model_39_dend_distvec;
model_40_dend_distvec = model_38_dend_distvec(end) + model_40_dend_distvec;

model_41_dend_distvec = model_23_dend_distvec(end) + model_41_dend_distvec;

model_42_dend_distvec = model_23_dend_distvec(end) + model_42_dend_distvec;
model_43_dend_distvec = model_42_dend_distvec(end) + model_43_dend_distvec;
model_44_dend_distvec = model_43_dend_distvec(end) + model_44_dend_distvec;
model_45_dend_distvec = model_44_dend_distvec(end) + model_45_dend_distvec;
model_46_dend_distvec = model_44_dend_distvec(end) + model_46_dend_distvec;
model_47_dend_distvec = model_46_dend_distvec(end) + model_47_dend_distvec;

model_48_dend_distvec = model_43_dend_distvec(end) + model_48_dend_distvec;
model_49_dend_distvec = model_48_dend_distvec(end) + model_49_dend_distvec;
model_50_dend_distvec = model_49_dend_distvec(end) + model_50_dend_distvec;
model_51_dend_distvec = model_49_dend_distvec(end) + model_51_dend_distvec;

model_52_dend_distvec = model_48_dend_distvec(end) + model_52_dend_distvec;
model_53_dend_distvec = model_52_dend_distvec(end) + model_53_dend_distvec;
model_54_dend_distvec = model_52_dend_distvec(end) + model_54_dend_distvec;

model_55_dend_distvec = model_42_dend_distvec(end) + model_55_dend_distvec;
model_56_dend_distvec = model_55_dend_distvec(end) + model_56_dend_distvec;
model_57_dend_distvec = model_55_dend_distvec(end) + model_57_dend_distvec;

%% Concatenate path vectors for distance and weight threshold: Tree 1

path1_dist = [model_0_dend_distvec; model_1_dend_distvec];
path1_weight = [model_0_dend_weightvec; model_1_dend_weightvec];

path2_dist = [model_0_dend_distvec; model_2_dend_distvec];
path2_weight = [model_0_dend_weightvec; model_2_dend_weightvec];

%% Concatenate path vectors for distance and weight threshold: Tree 2

path3_dist = [model_3_dend_distvec; model_4_dend_distvec];
path3_weight = [model_3_dend_weightvec; model_4_dend_weightvec];

path4_dist = [model_3_dend_distvec; model_5_dend_distvec; model_6_dend_distvec];
path4_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_6_dend_weightvec];

path5_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_8_dend_distvec; model_10_dend_distvec];
path5_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_8_dend_weightvec; model_10_dend_weightvec];

path6_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_8_dend_distvec; model_9_dend_distvec];
path6_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_8_dend_weightvec; model_9_dend_weightvec];

path7_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_11_dend_distvec; model_12_dend_distvec; model_13_dend_distvec];
path7_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_11_dend_weightvec; model_12_dend_weightvec; model_13_dend_weightvec];

path8_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_11_dend_distvec; model_12_dend_distvec; model_14_dend_distvec];
path8_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_11_dend_weightvec; model_12_dend_weightvec; model_14_dend_weightvec];

path9_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_11_dend_distvec; model_15_dend_distvec; model_16_dend_distvec];
path9_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_11_dend_weightvec; model_15_dend_weightvec; model_16_dend_weightvec];

path10_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_11_dend_distvec; model_15_dend_distvec; model_17_dend_distvec];
path10_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_11_dend_weightvec; model_15_dend_weightvec; model_17_dend_weightvec];

%% Concatenate path vectors for distance and weight threshold: Tree 3

path11_dist = [model_23_dend_distvec; model_24_dend_distvec; model_25_dend_distvec;...
    model_26_dend_distvec];
path11_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_25_dend_weightvec;...
    model_26_dend_weightvec];

path12_dist = [model_23_dend_distvec; model_24_dend_distvec; model_25_dend_distvec;...
    model_27_dend_distvec];
path12_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_25_dend_weightvec;...
    model_27_dend_weightvec];

path13_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_29_dend_distvec; model_30_dend_distvec];
path13_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_29_dend_weightvec; model_30_dend_weightvec];

path14_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_29_dend_distvec; model_31_dend_distvec];
path14_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_29_dend_weightvec; model_31_dend_weightvec];

path15_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_33_dend_distvec];
path15_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_33_dend_weightvec];

path16_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_34_dend_distvec; model_35_dend_distvec; model_36_dend_distvec];
path16_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_34_dend_weightvec; model_35_dend_weightvec; model_36_dend_weightvec];

path17_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_34_dend_distvec; model_35_dend_distvec; model_37_dend_distvec];
path17_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_34_dend_weightvec; model_35_dend_weightvec; model_37_dend_weightvec];

path18_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_34_dend_distvec; model_38_dend_distvec; model_39_dend_distvec];
path18_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_34_dend_weightvec; model_38_dend_weightvec; model_39_dend_weightvec];

path19_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_34_dend_distvec; model_38_dend_distvec; model_40_dend_distvec];
path19_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_34_dend_weightvec; model_38_dend_weightvec; model_40_dend_weightvec];

path20_dist = [model_23_dend_distvec; model_41_dend_distvec];
path20_weight = [model_23_dend_weightvec; model_41_dend_weightvec];

path21_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_44_dend_distvec; model_45_dend_distvec];
path21_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_44_dend_weightvec; model_45_dend_weightvec];

path22_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_44_dend_distvec; model_46_dend_distvec; model_47_dend_distvec];
path22_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_44_dend_weightvec; model_46_dend_weightvec; model_47_dend_weightvec];

path23_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_48_dend_distvec; model_49_dend_distvec; model_50_dend_distvec];
path23_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_48_dend_weightvec; model_49_dend_weightvec; model_50_dend_weightvec];

path24_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_48_dend_distvec; model_49_dend_distvec; model_51_dend_distvec];
path24_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_48_dend_weightvec; model_49_dend_weightvec; model_51_dend_weightvec];

path25_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_48_dend_distvec; model_52_dend_distvec; model_53_dend_distvec];
path25_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_48_dend_weightvec; model_52_dend_weightvec; model_53_dend_weightvec];

path26_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_48_dend_distvec; model_52_dend_distvec; model_54_dend_distvec];
path26_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_48_dend_weightvec; model_52_dend_weightvec; model_54_dend_weightvec];

path27_dist = [model_23_dend_distvec; model_42_dend_distvec; model_55_dend_distvec;...
    model_56_dend_distvec];
path27_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_55_dend_weightvec;...
    model_56_dend_weightvec];

path28_dist = [model_23_dend_distvec; model_42_dend_distvec; model_55_dend_distvec;...
    model_57_dend_distvec];
path28_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_55_dend_weightvec;...
    model_57_dend_weightvec];

%% Generate spike reliability plots

% Plot all paths
figure(1)
h = plot(path1_dist,path1_weight,path2_dist,path2_weight,path3_dist,path3_weight,...
    path4_dist,path4_weight,path5_dist,path5_weight,path6_dist,path6_weight,...
    path7_dist,path7_weight,path8_dist,path8_weight,path9_dist,path9_weight,...
    path10_dist,path10_weight,path11_dist,path11_weight,path12_dist,path12_weight,...
    path12_dist,path12_weight,path13_dist,path13_weight,path14_dist,path14_weight,...
    path15_dist,path15_weight,path16_dist,path16_weight,path17_dist,path17_weight,...
    path18_dist,path18_weight,path19_dist,path19_weight,path20_dist,path20_weight,...
    path21_dist,path21_weight,path22_dist,path22_weight,path23_dist,path23_weight,...
    path24_dist,path24_weight,path25_dist,path25_weight,path26_dist,path26_weight,...
    path27_dist,path27_weight,path28_dist,path28_weight);
% set(h,'Marker','o')
set(h,'Color','k')
% legend('Path 1','Path 2','Path 3','Path 4','Path 5','Path 6','Path 7',...
%     'Path 8','Path 9','Path 10','Path 11','Path 12','Path 13','Path 14',...
%     'Path 15','Path 16','Path 17','Path 18','Path 19','Path 20','Path 21',...
%     'Path 22','Path 23','Path 24','Path 25','Path 26','Path 27','Path 28')
xlabel('Distance from Soma (\mum)')
ylabel('Synaptic Weight to Evoke Somatic Spike (\muS)')
% title([Case1 ' Synaptic Weight Thresholds'])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

hold on
if strcmp(Case,'Case8Output')
    set(gca, 'YTickLabel', num2str(get(gca, 'YTick')', '%.4f')); % Only for Case 8
elseif strcmp(Case,'Case7Output')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    text(400,8,'\leftarrow Tree 1','FontSize',15) % Case 7 = 400; Case 8* = 400; Case 9* = 440
    text(260,8,'\leftarrow Tree 2A','FontSize',15) % Case 7 = 260; Case 8* = 260; Case 9* = 295
    text(95,8,'Tree 2B \rightarrow','FontSize',15) % Case 7 = 95; Case 8* = 90; Case 9* = 120
elseif strcmp(Case,'Case8StarOutput')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    text(390,8,'\leftarrow Tree 1','FontSize',15) % Case 7 = 400; Case 8* = 400; Case 9* = 440
    text(225,8,'\leftarrow Tree 2A','FontSize',15) % Case 7 = 260; Case 8* = 260; Case 9* = 295
    text(80,8,'Tree 2B \rightarrow','FontSize',15) % Case 7 = 95; Case 8* = 90; Case 9* = 120
elseif strcmp(Case,'Case9StarOutput')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    text(440,8,'\leftarrow Tree 1','FontSize',15) % Case 7 = 400; Case 8* = 400; Case 9* = 440
    text(285,8,'\leftarrow Tree 2A','FontSize',15) % Case 7 = 260; Case 8* = 260; Case 9* = 295
    text(120,8,'Tree 2B \rightarrow','FontSize',15) % Case 7 = 95; Case 8* = 90; Case 9* = 120
end
hold off

%%
% Plot Tree 1small Paths (dend root)
figure(2)
j = plot(path1_dist,path1_weight,path2_dist,path2_weight);
set(j,'Color','k')
xlabel('Distance from soma (um)')
ylabel('Threshold synaptic weight to evoke somatic spike (uS)')
title('Distance dependent synaptic weight thresholds for tree 1small')

% Plot Tree 1 Paths (dend[3] root)
figure(3)
k = plot(path3_dist,path3_weight,path4_dist,path4_weight,path5_dist,...
    path5_weight,path6_dist,path6_weight,path7_dist,path7_weight,...
    path8_dist,path8_weight,path9_dist,path9_weight,path10_dist,path10_weight);
set(k,'Color','k')
xlabel('Distance from soma (um)')
ylabel('Threshold synaptic weight to evoke somatic spike (uS)')
title('Distance dependent synaptic weight thresholds for tree 1')

% Plot Tree 2A Paths (dend[23-24] root)
figure(4)
l = plot(path11_dist,path11_weight,path12_dist,path12_weight,...
    path12_dist,path12_weight,path13_dist,path13_weight,path14_dist,path14_weight,...
    path15_dist,path15_weight,path16_dist,path16_weight,path17_dist,path17_weight,...
    path18_dist,path18_weight,path19_dist,path19_weight);
set(l,'Color','k')
xlabel('Distance from soma (um)')
ylabel('Threshold synaptic weight to evoke somatic spike (uS)')
title('Distance dependent synaptic weight thresholds for tree 2A')

% Plot Tree 2B Paths (dend[23-42] root)
figure(5)
m = plot(path21_dist,path21_weight,path22_dist,path22_weight,path23_dist,path23_weight,...
    path24_dist,path24_weight,path25_dist,path25_weight,path26_dist,path26_weight,...
    path27_dist,path27_weight,path28_dist,path28_weight);
set(m,'Color','k')
xlabel('Distance from soma (um)')
ylabel('Threshold synaptic weight to evoke somatic spike (uS)')
title('Distance dependent synaptic weight thresholds for tree 2B')

% Plot Tree 2C Paths (dend[23-41] root)
figure(6)
n = plot(path20_dist,path20_weight);
set(n,'Color','k')
xlabel('Distance from soma (um)')
ylabel('Threshold synaptic weight to evoke somatic spike (uS)')
title('Distance dependent synaptic weight thresholds for tree 2C')




