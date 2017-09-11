close all; clear all;

%%% Plot the results from the single synapse simulations %%%
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';
LocalVmChangeMatrix = nan(58,30);
LocalDistanceMatrix = nan(58,30);
LocalWeightMatrix = nan(58,30);
PlotSaturation = 0; % i.e. whether or not to plot saturation

%% Load Files
% Case = 'Case8StarOutput';
Case1 = '9Star';
ResultFiles = dir(['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/NSG_SIMS_Saturation/' Case1 '/*.dat']);
xaxis_range = [0 510];
yaxis1_range = [0 10];
% yaxis1_range = [0 0.6];
yaxis2_range = [0 71];
% yaxis2_range = [60 71];

for i=1:length(ResultFiles)
    load([['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/NSG_SIMS_Saturation/' Case1 '/'] ResultFiles(i).name]); %eval(['load ' files1(i).name ' -dat']);
end

for j = 0:57
    
    ResultFiles1 = dir(['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/NSG_SIMS_Saturation/' Case1 '/*_' num2str(j) '_dend_distvec.dat']);
    ResultFiles2 = dir(['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/NSG_SIMS_Saturation/' Case1 '/*_' num2str(j) '_DendriteNumber.dat']); % look at values for each dendritic section incrementally
    ResultFiles3 = dir(['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/NSG_SIMS_Saturation/' Case1 '/*_' num2str(j) '_dend_weightvec.dat']);
    
    temp1 = load([['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/NSG_SIMS_Saturation/' Case1 '/'] ResultFiles1.name]);
    temp2 = load([['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/NSG_SIMS_Saturation/' Case1 '/'] ResultFiles3.name]);
    LocalDistanceMatrix(j+1,1:length(temp1)) = temp1;
    LocalWeightMatrix(j+1,1:length(temp2)) = temp2;
    
    for k = 1:length(ResultFiles2)
        tempVtrace = load([['~/Desktop/SkinnerLab/Usages/Single Synapse Tests/NSG_SIMS_Saturation/' Case1 '/'] ResultFiles2(k).name]); %eval(['load ' files1(i).name ' -dat']);
        LocalVmChangeMatrix(j+1,k) = max(tempVtrace(1:10))-min(tempVtrace(1:10)); % Find the change in membrane potential within the first 1ms
    end  
end

model_0_dend_VmChangeVec = LocalVmChangeMatrix(1,isnan(LocalVmChangeMatrix(1,:))==0)';
model_1_dend_VmChangeVec = LocalVmChangeMatrix(2,isnan(LocalVmChangeMatrix(2,:))==0)';
model_2_dend_VmChangeVec = LocalVmChangeMatrix(3,isnan(LocalVmChangeMatrix(3,:))==0)';
model_3_dend_VmChangeVec = LocalVmChangeMatrix(4,isnan(LocalVmChangeMatrix(4,:))==0)';
model_4_dend_VmChangeVec = LocalVmChangeMatrix(5,isnan(LocalVmChangeMatrix(5,:))==0)';
model_5_dend_VmChangeVec = LocalVmChangeMatrix(6,isnan(LocalVmChangeMatrix(6,:))==0)';
model_6_dend_VmChangeVec = LocalVmChangeMatrix(7,isnan(LocalVmChangeMatrix(7,:))==0)';
model_7_dend_VmChangeVec = LocalVmChangeMatrix(8,isnan(LocalVmChangeMatrix(8,:))==0)';
model_8_dend_VmChangeVec = LocalVmChangeMatrix(9,isnan(LocalVmChangeMatrix(9,:))==0)';
model_9_dend_VmChangeVec = LocalVmChangeMatrix(10,isnan(LocalVmChangeMatrix(10,:))==0)';

model_10_dend_VmChangeVec = LocalVmChangeMatrix(11,isnan(LocalVmChangeMatrix(11,:))==0)';
model_11_dend_VmChangeVec = LocalVmChangeMatrix(12,isnan(LocalVmChangeMatrix(12,:))==0)';
model_12_dend_VmChangeVec = LocalVmChangeMatrix(13,isnan(LocalVmChangeMatrix(13,:))==0)';
model_13_dend_VmChangeVec = LocalVmChangeMatrix(14,isnan(LocalVmChangeMatrix(14,:))==0)';
model_14_dend_VmChangeVec = LocalVmChangeMatrix(15,isnan(LocalVmChangeMatrix(15,:))==0)';
model_15_dend_VmChangeVec = LocalVmChangeMatrix(16,isnan(LocalVmChangeMatrix(16,:))==0)';
model_16_dend_VmChangeVec = LocalVmChangeMatrix(17,isnan(LocalVmChangeMatrix(17,:))==0)';
model_17_dend_VmChangeVec = LocalVmChangeMatrix(18,isnan(LocalVmChangeMatrix(18,:))==0)';
model_18_dend_VmChangeVec = LocalVmChangeMatrix(19,isnan(LocalVmChangeMatrix(19,:))==0)';
model_19_dend_VmChangeVec = LocalVmChangeMatrix(20,isnan(LocalVmChangeMatrix(20,:))==0)';

model_20_dend_VmChangeVec = LocalVmChangeMatrix(21,isnan(LocalVmChangeMatrix(21,:))==0)';
model_21_dend_VmChangeVec = LocalVmChangeMatrix(22,isnan(LocalVmChangeMatrix(22,:))==0)';
model_22_dend_VmChangeVec = LocalVmChangeMatrix(23,isnan(LocalVmChangeMatrix(23,:))==0)';
model_23_dend_VmChangeVec = LocalVmChangeMatrix(24,isnan(LocalVmChangeMatrix(24,:))==0)';
model_24_dend_VmChangeVec = LocalVmChangeMatrix(25,isnan(LocalVmChangeMatrix(25,:))==0)';
model_25_dend_VmChangeVec = LocalVmChangeMatrix(26,isnan(LocalVmChangeMatrix(26,:))==0)';
model_26_dend_VmChangeVec = LocalVmChangeMatrix(27,isnan(LocalVmChangeMatrix(27,:))==0)';
model_27_dend_VmChangeVec = LocalVmChangeMatrix(28,isnan(LocalVmChangeMatrix(28,:))==0)';
model_28_dend_VmChangeVec = LocalVmChangeMatrix(29,isnan(LocalVmChangeMatrix(29,:))==0)';
model_29_dend_VmChangeVec = LocalVmChangeMatrix(30,isnan(LocalVmChangeMatrix(30,:))==0)';

model_30_dend_VmChangeVec = LocalVmChangeMatrix(31,isnan(LocalVmChangeMatrix(31,:))==0)';
model_31_dend_VmChangeVec = LocalVmChangeMatrix(32,isnan(LocalVmChangeMatrix(32,:))==0)';
model_32_dend_VmChangeVec = LocalVmChangeMatrix(33,isnan(LocalVmChangeMatrix(33,:))==0)';
model_33_dend_VmChangeVec = LocalVmChangeMatrix(34,isnan(LocalVmChangeMatrix(34,:))==0)';
model_34_dend_VmChangeVec = LocalVmChangeMatrix(35,isnan(LocalVmChangeMatrix(35,:))==0)';
model_35_dend_VmChangeVec = LocalVmChangeMatrix(36,isnan(LocalVmChangeMatrix(36,:))==0)';
model_36_dend_VmChangeVec = LocalVmChangeMatrix(37,isnan(LocalVmChangeMatrix(37,:))==0)';
model_37_dend_VmChangeVec = LocalVmChangeMatrix(38,isnan(LocalVmChangeMatrix(38,:))==0)';
model_38_dend_VmChangeVec = LocalVmChangeMatrix(39,isnan(LocalVmChangeMatrix(39,:))==0)';
model_39_dend_VmChangeVec = LocalVmChangeMatrix(40,isnan(LocalVmChangeMatrix(40,:))==0)';

model_40_dend_VmChangeVec = LocalVmChangeMatrix(41,isnan(LocalVmChangeMatrix(41,:))==0)';
model_41_dend_VmChangeVec = LocalVmChangeMatrix(42,isnan(LocalVmChangeMatrix(42,:))==0)';
model_42_dend_VmChangeVec = LocalVmChangeMatrix(43,isnan(LocalVmChangeMatrix(43,:))==0)';
model_43_dend_VmChangeVec = LocalVmChangeMatrix(44,isnan(LocalVmChangeMatrix(44,:))==0)';
model_44_dend_VmChangeVec = LocalVmChangeMatrix(45,isnan(LocalVmChangeMatrix(45,:))==0)';
model_45_dend_VmChangeVec = LocalVmChangeMatrix(46,isnan(LocalVmChangeMatrix(46,:))==0)';
model_46_dend_VmChangeVec = LocalVmChangeMatrix(47,isnan(LocalVmChangeMatrix(47,:))==0)';
model_47_dend_VmChangeVec = LocalVmChangeMatrix(48,isnan(LocalVmChangeMatrix(48,:))==0)';
model_48_dend_VmChangeVec = LocalVmChangeMatrix(49,isnan(LocalVmChangeMatrix(49,:))==0)';
model_49_dend_VmChangeVec = LocalVmChangeMatrix(50,isnan(LocalVmChangeMatrix(50,:))==0)';

model_50_dend_VmChangeVec = LocalVmChangeMatrix(51,isnan(LocalVmChangeMatrix(51,:))==0)';
model_51_dend_VmChangeVec = LocalVmChangeMatrix(52,isnan(LocalVmChangeMatrix(52,:))==0)';
model_52_dend_VmChangeVec = LocalVmChangeMatrix(53,isnan(LocalVmChangeMatrix(53,:))==0)';
model_53_dend_VmChangeVec = LocalVmChangeMatrix(54,isnan(LocalVmChangeMatrix(54,:))==0)';
model_54_dend_VmChangeVec = LocalVmChangeMatrix(55,isnan(LocalVmChangeMatrix(55,:))==0)';
model_55_dend_VmChangeVec = LocalVmChangeMatrix(56,isnan(LocalVmChangeMatrix(56,:))==0)';
model_56_dend_VmChangeVec = LocalVmChangeMatrix(57,isnan(LocalVmChangeMatrix(57,:))==0)';
model_57_dend_VmChangeVec = LocalVmChangeMatrix(58,isnan(LocalVmChangeMatrix(58,:))==0)';

%% Concatenate path vectors for distance and weight threshold: Tree 1

path1_dist = [model_0_dend_distvec; model_1_dend_distvec];
path1_weight = [model_0_dend_weightvec; model_1_dend_weightvec];
path1_VmChangeVec = [model_0_dend_VmChangeVec; model_1_dend_VmChangeVec];

path2_dist = [model_0_dend_distvec; model_2_dend_distvec];
path2_weight = [model_0_dend_weightvec; model_2_dend_weightvec];
path2_VmChangeVec = [model_0_dend_VmChangeVec; model_2_dend_VmChangeVec];

%% Concatenate path vectors for distance and weight threshold: Tree 2

path3_dist = [model_3_dend_distvec; model_4_dend_distvec];
path3_weight = [model_3_dend_weightvec; model_4_dend_weightvec];
path3_VmChangeVec = [model_3_dend_VmChangeVec; model_4_dend_VmChangeVec];

path4_dist = [model_3_dend_distvec; model_5_dend_distvec; model_6_dend_distvec];
path4_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_6_dend_weightvec];
path4_VmChangeVec = [model_3_dend_VmChangeVec; model_5_dend_VmChangeVec; model_6_dend_VmChangeVec];

path5_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_8_dend_distvec; model_10_dend_distvec];
path5_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_8_dend_weightvec; model_10_dend_weightvec];
path5_VmChangeVec = [model_3_dend_VmChangeVec; model_5_dend_VmChangeVec; model_7_dend_VmChangeVec;...
    model_8_dend_VmChangeVec; model_10_dend_VmChangeVec];

path6_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_8_dend_distvec; model_9_dend_distvec];
path6_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_8_dend_weightvec; model_9_dend_weightvec];
path6_VmChangeVec = [model_3_dend_VmChangeVec; model_5_dend_VmChangeVec; model_7_dend_VmChangeVec;...
    model_8_dend_VmChangeVec; model_9_dend_VmChangeVec];

path7_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_11_dend_distvec; model_12_dend_distvec; model_13_dend_distvec];
path7_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_11_dend_weightvec; model_12_dend_weightvec; model_13_dend_weightvec];
path7_VmChangeVec = [model_3_dend_VmChangeVec; model_5_dend_VmChangeVec; model_7_dend_VmChangeVec;...
    model_11_dend_VmChangeVec; model_12_dend_VmChangeVec; model_13_dend_VmChangeVec];

path8_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_11_dend_distvec; model_12_dend_distvec; model_14_dend_distvec];
path8_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_11_dend_weightvec; model_12_dend_weightvec; model_14_dend_weightvec];
path8_VmChangeVec = [model_3_dend_VmChangeVec; model_5_dend_VmChangeVec; model_7_dend_VmChangeVec;...
    model_11_dend_VmChangeVec; model_12_dend_VmChangeVec; model_14_dend_VmChangeVec];

path9_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_11_dend_distvec; model_15_dend_distvec; model_16_dend_distvec];
path9_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_11_dend_weightvec; model_15_dend_weightvec; model_16_dend_weightvec];
path9_VmChangeVec = [model_3_dend_VmChangeVec; model_5_dend_VmChangeVec; model_7_dend_VmChangeVec;...
    model_11_dend_VmChangeVec; model_15_dend_VmChangeVec; model_16_dend_VmChangeVec];

path10_dist = [model_3_dend_distvec; model_5_dend_distvec; model_7_dend_distvec;...
    model_11_dend_distvec; model_15_dend_distvec; model_17_dend_distvec];
path10_weight = [model_3_dend_weightvec; model_5_dend_weightvec; model_7_dend_weightvec;...
    model_11_dend_weightvec; model_15_dend_weightvec; model_17_dend_weightvec];
path10_VmChangeVec = [model_3_dend_VmChangeVec; model_5_dend_VmChangeVec; model_7_dend_VmChangeVec;...
    model_11_dend_VmChangeVec; model_15_dend_VmChangeVec; model_17_dend_VmChangeVec];

%% Concatenate path vectors for distance and weight threshold: Tree 3

path11_dist = [model_23_dend_distvec; model_24_dend_distvec; model_25_dend_distvec;...
    model_26_dend_distvec];
path11_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_25_dend_weightvec;...
    model_26_dend_weightvec];
path11_VmChangeVec = [model_23_dend_VmChangeVec; model_24_dend_VmChangeVec; model_25_dend_VmChangeVec;...
    model_26_dend_VmChangeVec];

path12_dist = [model_23_dend_distvec; model_24_dend_distvec; model_25_dend_distvec;...
    model_27_dend_distvec];
path12_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_25_dend_weightvec;...
    model_27_dend_weightvec];
path12_VmChangeVec = [model_23_dend_VmChangeVec; model_24_dend_VmChangeVec; model_25_dend_VmChangeVec;...
    model_27_dend_VmChangeVec];

path13_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_29_dend_distvec; model_30_dend_distvec];
path13_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_29_dend_weightvec; model_30_dend_weightvec];
path13_VmChangeVec = [model_23_dend_VmChangeVec; model_24_dend_VmChangeVec; model_28_dend_VmChangeVec;...
    model_29_dend_VmChangeVec; model_30_dend_VmChangeVec];

path14_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_29_dend_distvec; model_31_dend_distvec];
path14_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_29_dend_weightvec; model_31_dend_weightvec];
path14_VmChangeVec = [model_23_dend_VmChangeVec; model_24_dend_VmChangeVec; model_28_dend_VmChangeVec;...
    model_29_dend_VmChangeVec; model_31_dend_VmChangeVec];

path15_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_33_dend_distvec];
path15_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_33_dend_weightvec];
path15_VmChangeVec = [model_23_dend_VmChangeVec; model_24_dend_VmChangeVec; model_28_dend_VmChangeVec;...
    model_32_dend_VmChangeVec; model_33_dend_VmChangeVec];

path16_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_34_dend_distvec; model_35_dend_distvec; model_36_dend_distvec];
path16_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_34_dend_weightvec; model_35_dend_weightvec; model_36_dend_weightvec];
path16_VmChangeVec = [model_23_dend_VmChangeVec; model_24_dend_VmChangeVec; model_28_dend_VmChangeVec;...
    model_32_dend_VmChangeVec; model_34_dend_VmChangeVec; model_35_dend_VmChangeVec; model_36_dend_VmChangeVec];

path17_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_34_dend_distvec; model_35_dend_distvec; model_37_dend_distvec];
path17_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_34_dend_weightvec; model_35_dend_weightvec; model_37_dend_weightvec];
path17_VmChangeVec = [model_23_dend_VmChangeVec; model_24_dend_VmChangeVec; model_28_dend_VmChangeVec;...
    model_32_dend_VmChangeVec; model_34_dend_VmChangeVec; model_35_dend_VmChangeVec; model_37_dend_VmChangeVec];

path18_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_34_dend_distvec; model_38_dend_distvec; model_39_dend_distvec];
path18_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_34_dend_weightvec; model_38_dend_weightvec; model_39_dend_weightvec];
path18_VmChangeVec = [model_23_dend_VmChangeVec; model_24_dend_VmChangeVec; model_28_dend_VmChangeVec;...
    model_32_dend_VmChangeVec; model_34_dend_VmChangeVec; model_38_dend_VmChangeVec; model_39_dend_VmChangeVec];

path19_dist = [model_23_dend_distvec; model_24_dend_distvec; model_28_dend_distvec;...
    model_32_dend_distvec; model_34_dend_distvec; model_38_dend_distvec; model_40_dend_distvec];
path19_weight = [model_23_dend_weightvec; model_24_dend_weightvec; model_28_dend_weightvec;...
    model_32_dend_weightvec; model_34_dend_weightvec; model_38_dend_weightvec; model_40_dend_weightvec];
path19_VmChangeVec = [model_23_dend_VmChangeVec; model_24_dend_VmChangeVec; model_28_dend_VmChangeVec;...
    model_32_dend_VmChangeVec; model_34_dend_VmChangeVec; model_38_dend_VmChangeVec; model_40_dend_VmChangeVec];

path20_dist = [model_23_dend_distvec; model_41_dend_distvec];
path20_weight = [model_23_dend_weightvec; model_41_dend_weightvec];
path20_VmChangeVec = [model_23_dend_VmChangeVec; model_41_dend_VmChangeVec];

path21_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_44_dend_distvec; model_45_dend_distvec];
path21_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_44_dend_weightvec; model_45_dend_weightvec];
path21_VmChangeVec = [model_23_dend_VmChangeVec; model_42_dend_VmChangeVec; model_43_dend_VmChangeVec;...
    model_44_dend_VmChangeVec; model_45_dend_VmChangeVec];

path22_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_44_dend_distvec; model_46_dend_distvec; model_47_dend_distvec];
path22_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_44_dend_weightvec; model_46_dend_weightvec; model_47_dend_weightvec];
path22_VmChangeVec = [model_23_dend_VmChangeVec; model_42_dend_VmChangeVec; model_43_dend_VmChangeVec;...
    model_44_dend_VmChangeVec; model_46_dend_VmChangeVec; model_47_dend_VmChangeVec];

path23_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_48_dend_distvec; model_49_dend_distvec; model_50_dend_distvec];
path23_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_48_dend_weightvec; model_49_dend_weightvec; model_50_dend_weightvec];
path23_VmChangeVec = [model_23_dend_VmChangeVec; model_42_dend_VmChangeVec; model_43_dend_VmChangeVec;...
    model_48_dend_VmChangeVec; model_49_dend_VmChangeVec; model_50_dend_VmChangeVec];

path24_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_48_dend_distvec; model_49_dend_distvec; model_51_dend_distvec];
path24_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_48_dend_weightvec; model_49_dend_weightvec; model_51_dend_weightvec];
path24_VmChangeVec = [model_23_dend_VmChangeVec; model_42_dend_VmChangeVec; model_43_dend_VmChangeVec;...
    model_48_dend_VmChangeVec; model_49_dend_VmChangeVec; model_51_dend_VmChangeVec];

path25_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_48_dend_distvec; model_52_dend_distvec; model_53_dend_distvec];
path25_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_48_dend_weightvec; model_52_dend_weightvec; model_53_dend_weightvec];
path25_VmChangeVec = [model_23_dend_VmChangeVec; model_42_dend_VmChangeVec; model_43_dend_VmChangeVec;...
    model_48_dend_VmChangeVec; model_52_dend_VmChangeVec; model_53_dend_VmChangeVec];

path26_dist = [model_23_dend_distvec; model_42_dend_distvec; model_43_dend_distvec;...
    model_48_dend_distvec; model_52_dend_distvec; model_54_dend_distvec];
path26_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_43_dend_weightvec;...
    model_48_dend_weightvec; model_52_dend_weightvec; model_54_dend_weightvec];
path26_VmChangeVec = [model_23_dend_VmChangeVec; model_42_dend_VmChangeVec; model_43_dend_VmChangeVec;...
    model_48_dend_VmChangeVec; model_52_dend_VmChangeVec; model_54_dend_VmChangeVec];

path27_dist = [model_23_dend_distvec; model_42_dend_distvec; model_55_dend_distvec;...
    model_56_dend_distvec];
path27_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_55_dend_weightvec;...
    model_56_dend_weightvec];
path27_VmChangeVec = [model_23_dend_VmChangeVec; model_42_dend_VmChangeVec; model_55_dend_VmChangeVec;...
    model_56_dend_VmChangeVec];

path28_dist = [model_23_dend_distvec; model_42_dend_distvec; model_55_dend_distvec;...
    model_57_dend_distvec];
path28_weight = [model_23_dend_weightvec; model_42_dend_weightvec; model_55_dend_weightvec;...
    model_57_dend_weightvec];
path28_VmChangeVec = [model_23_dend_VmChangeVec; model_42_dend_VmChangeVec; model_55_dend_VmChangeVec;...
    model_57_dend_VmChangeVec];

%% Generate spike reliability plots
Y1Color = [0.1 0.2 0.3];
Y2Color = [0.6 0.1 0.3];

% Plot all paths
figure(1)
plot(path1_dist,path1_weight,path2_dist,path2_weight,path3_dist,path3_weight,...
    path4_dist,path4_weight,path5_dist,path5_weight,path6_dist,path6_weight,...
    path7_dist,path7_weight,path8_dist,path8_weight,path9_dist,path9_weight,...
    path10_dist,path10_weight,path11_dist,path11_weight,path12_dist,path12_weight,...
    path12_dist,path12_weight,path13_dist,path13_weight,path14_dist,path14_weight,...
    path15_dist,path15_weight,path16_dist,path16_weight,path17_dist,path17_weight,...
    path18_dist,path18_weight,path19_dist,path19_weight,path20_dist,path20_weight,...
    path21_dist,path21_weight,path22_dist,path22_weight,path23_dist,path23_weight,...
    path24_dist,path24_weight,path25_dist,path25_weight,path26_dist,path26_weight,...
    path27_dist,path27_weight,path28_dist,path28_weight,'Color',Y1Color);

box off
% set(h,'Color','k')
xlabel('Distance from Soma (\mum)')
ylabel('Threshold Weight (\muS)')
% title([Case1 ' Synaptic Weight Thresholds'])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax1 = gca; % current axes
ax1.FontSize = font_size-2;

hold on
if strcmp(Case1,'Case8')
    set(gca, 'YTickLabel', num2str(get(gca, 'YTick')', '%.4f')); % Only for Case 8
    axis([xaxis_range min(path28_weight)-0.0015 max(path1_weight)+0.0015])
elseif strcmp(Case1,'Case7')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
    if PlotSaturation == 0
        text(410,8,'\leftarrow Tree 1','FontSize',15) % Case 7 = 400; Case 8* = 400; Case 9* = 440
        text(270,8,'\leftarrow Tree 2A','FontSize',15) % Case 7 = 260; Case 8* = 260; Case 9* = 295
        text(105,8,'Tree 2B \rightarrow','FontSize',15) % Case 7 = 95; Case 8* = 90; Case 9* = 120
        plot([174 174], get(gca,'ylim')/10,'b');
        plot([216 216], get(gca,'ylim')/10,'b');
        plot([362 362], get(gca,'ylim')/10,'b');
    end
elseif strcmp(Case1,'8Star')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
    if PlotSaturation == 0
        text(390,8,'\leftarrow Tree 1','FontSize',15) % Case 7 = 400; Case 8* = 400; Case 9* = 440
        text(235,8,'\leftarrow Tree 2A','FontSize',15) % Case 7 = 260; Case 8* = 260; Case 9* = 295
        text(90,8,'Tree 2B \rightarrow','FontSize',15) % Case 7 = 95; Case 8* = 90; Case 9* = 120
        plot([172 172], get(gca,'ylim')/10,'b');
        plot([206 206], get(gca,'ylim')/10,'b');
        plot([353 353], get(gca,'ylim')/10,'b');
    end
elseif strcmp(Case1,'9Star')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
    if PlotSaturation == 0
        text(440,8,'\leftarrow Tree 1','FontSize',15) % Case 7 = 400; Case 8* = 400; Case 9* = 440
        text(285,8,'\leftarrow Tree 2A','FontSize',15) % Case 7 = 260; Case 8* = 260; Case 9* = 295
        text(120,8,'Tree 2B \rightarrow','FontSize',15) % Case 7 = 95; Case 8* = 90; Case 9* = 120
        plot([188 188], get(gca,'ylim')/10,'b');
        plot([239 239], get(gca,'ylim')/10,'b');
        plot([380 380], get(gca,'ylim')/10,'b');
    end
end

if PlotSaturation
    ax1.YColor = Y1Color;
    ax1_pos = ax1.Position; % position of first axes
    ax2 = axes('Position',ax1_pos,...
        'XAxisLocation','top',...
        'YAxisLocation','right',...
        'Color','none');
    ax2.YColor = Y2Color;
    hold on
    
    plot(path1_dist,path1_VmChangeVec,path2_dist,path2_VmChangeVec,path3_dist,path3_VmChangeVec,...
        path4_dist,path4_VmChangeVec,path5_dist,path5_VmChangeVec,path6_dist,path6_VmChangeVec,...
        path7_dist,path7_VmChangeVec,path8_dist,path8_VmChangeVec,path9_dist,path9_VmChangeVec,...
        path10_dist,path10_VmChangeVec,path11_dist,path11_VmChangeVec,path12_dist,path12_VmChangeVec,...
        path12_dist,path12_VmChangeVec,path13_dist,path13_VmChangeVec,path14_dist,path14_VmChangeVec,...
        path15_dist,path15_VmChangeVec,path16_dist,path16_VmChangeVec,path17_dist,path17_VmChangeVec,...
        path18_dist,path18_VmChangeVec,path19_dist,path19_VmChangeVec,path20_dist,path20_VmChangeVec,...
        path21_dist,path21_VmChangeVec,path22_dist,path22_VmChangeVec,path23_dist,path23_VmChangeVec,...
        path24_dist,path24_VmChangeVec,path25_dist,path25_VmChangeVec,path26_dist,path26_VmChangeVec,...
        path27_dist,path27_VmChangeVec,path28_dist,path28_VmChangeVec,'Parent',ax2,'Color',Y2Color);
    
    % set(g,'Color','k')
    % xlabel('Distance from Soma (\mum)')
    ylabel('Local Vm Change (mV)')
    axis([xaxis_range yaxis2_range])
    % title([Case1 ' Synaptic Weight Thresholds'])
    set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    set(gca,'xtick',[]);
    set(gca,'xcolor',[1 1 1])
end
% hold on
% if strcmp(Case1,'Case8')
% %     set(gca, 'YTickLabel', num2str(get(gca, 'YTick')', '%.4f')); % Only for Case 8
% elseif strcmp(Case1,'Case7')
%     plot(get(gca,'xlim'), [69 69],'r--');
%     plot([174 174], get(gca,'ylim'),'b--');
%     plot([216 216], get(gca,'ylim'),'b--');
%     plot([362 362], get(gca,'ylim'),'b--');
% elseif strcmp(Case1,'8Star')
%     plot(get(gca,'xlim'), [69 69],'r--');
%     plot([172 172], get(gca,'ylim'),'b--');
%     plot([206 206], get(gca,'ylim'),'b--');
%     plot([353 353], get(gca,'ylim'),'b--');
% elseif strcmp(Case1,'9Star')
%     plot(get(gca,'xlim'), [69 69],'r--');
%     plot([188 188], get(gca,'ylim'),'b--');
%     plot([239 239], get(gca,'ylim'),'b--');
%     plot([380 380], get(gca,'ylim'),'b--');
% end
hold off

%%
% Plot Tree 1small Paths (dend root)
% figure(2)
% j = plot(path1_dist,path1_weight,path2_dist,path2_weight);
% set(j,'Color','k')
% xlabel('Distance from soma (um)')
% ylabel('Threshold synaptic weight to evoke somatic spike (uS)')
% title('Distance dependent synaptic weight thresholds for tree 1small')

%%
% Plot Tree 1 Paths (dend[3] root)
figure(3)
k = plot(path3_dist,path3_weight,path4_dist,path4_weight,path5_dist,...
    path5_weight,path6_dist,path6_weight,path7_dist,path7_weight,...
    path8_dist,path8_weight,path9_dist,path9_weight,path10_dist,path10_weight,'Color',Y1Color);

box off
% set(h,'Color','k')
xlabel('Distance from Soma (\mum)')
ylabel('Threshold Weight (\muS)')
title('Tree 1')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax1 = gca; % current axes
ax1.FontSize = font_size-2;
hold on
if strcmp(Case1,'Case8')
    set(gca, 'YTickLabel', num2str(get(gca, 'YTick')', '%.4f')); % Only for Case 8
    axis([xaxis_range min(path28_weight)-0.0015 max(path1_weight)+0.0015])
elseif strcmp(Case1,'Case7')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
elseif strcmp(Case1,'8Star')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
elseif strcmp(Case1,'9Star')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
end
if PlotSaturation
    ax1.YColor = Y1Color;
    ax1_pos = ax1.Position; % position of first axes
    ax2 = axes('Position',ax1_pos,...
        'XAxisLocation','top',...
        'YAxisLocation','right',...
        'Color','none');
    ax2.YColor = Y2Color;
    
    hold on
    plot(path3_dist,path3_VmChangeVec,path4_dist,path4_VmChangeVec,path5_dist,...
        path5_VmChangeVec,path6_dist,path6_VmChangeVec,path7_dist,path7_VmChangeVec,...
        path8_dist,path8_VmChangeVec,path9_dist,path9_VmChangeVec,path10_dist,path10_VmChangeVec,'Parent',ax2,'Color',Y2Color);
    
    ylabel('Local Vm Change (mV)')
    axis([xaxis_range yaxis2_range])
    set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    set(gca,'xtick',[]);
    set(gca,'xcolor',[1 1 1])
end
hold off

%%
% Plot Tree 2B Paths (dend[23-24] root)
figure(4)
l = plot(path11_dist,path11_weight,path12_dist,path12_weight,...
    path12_dist,path12_weight,path13_dist,path13_weight,path14_dist,path14_weight,...
    path15_dist,path15_weight,path16_dist,path16_weight,path17_dist,path17_weight,...
    path18_dist,path18_weight,path19_dist,path19_weight,'Color',Y1Color);

box off
xlabel('Distance from Soma (\mum)')
ylabel('Threshold Weight (\muS)')
title('Tree 2B')
axis([xaxis_range yaxis1_range])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax1 = gca; % current axes
ax1.FontSize = font_size-2;
hold on
if strcmp(Case1,'Case8')
    set(gca, 'YTickLabel', num2str(get(gca, 'YTick')', '%.4f')); % Only for Case 8
    axis([xaxis_range min(path28_weight)-0.0015 max(path1_weight)+0.0015])
elseif strcmp(Case1,'Case7')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
elseif strcmp(Case1,'8Star')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
elseif strcmp(Case1,'9Star')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
end
if PlotSaturation
    ax1.YColor = Y1Color;
    ax1_pos = ax1.Position; % position of first axes
    ax2 = axes('Position',ax1_pos,...
        'XAxisLocation','top',...
        'YAxisLocation','right',...
        'Color','none');
    ax2.YColor = Y2Color;
    
    hold on
    plot(path11_dist,path11_VmChangeVec,path12_dist,path12_VmChangeVec,...
        path12_dist,path12_VmChangeVec,path13_dist,path13_VmChangeVec,path14_dist,path14_VmChangeVec,...
        path15_dist,path15_VmChangeVec,path16_dist,path16_VmChangeVec,path17_dist,path17_VmChangeVec,...
        path18_dist,path18_VmChangeVec,path19_dist,path19_VmChangeVec,'Parent',ax2,'Color',Y2Color);
    
    ylabel('Local Vm Change (mV)')
    axis([xaxis_range yaxis2_range])
    set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    set(gca,'xtick',[]);
    set(gca,'xcolor',[1 1 1])
end
hold off

%%
% Plot Tree 2A Paths (dend[23-42] root)
figure(5)
m = plot(path21_dist,path21_weight,path22_dist,path22_weight,path23_dist,path23_weight,...
    path24_dist,path24_weight,path25_dist,path25_weight,path26_dist,path26_weight,...
    path27_dist,path27_weight,path28_dist,path28_weight,'Color',Y1Color);

box off
xlabel('Distance from Soma (\mum)')
ylabel('Threshold Weight (\muS)')
title('Tree 2A')
axis([xaxis_range yaxis1_range])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax1 = gca; % current axes
ax1.FontSize = font_size-2;
hold on
if strcmp(Case1,'Case8')
    set(gca, 'YTickLabel', num2str(get(gca, 'YTick')', '%.4f')); % Only for Case 8
    axis([xaxis_range min(path28_weight)-0.0015 max(path1_weight)+0.0015])
elseif strcmp(Case1,'Case7')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
elseif strcmp(Case1,'8Star')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
elseif strcmp(Case1,'9Star')
    plot(get(gca,'xlim'), [0.5 0.5],'r--');
    axis([xaxis_range yaxis1_range])
end
if PlotSaturation
    ax1.YColor = Y1Color;
    ax1_pos = ax1.Position; % position of first axes
    ax2 = axes('Position',ax1_pos,...
        'XAxisLocation','top',...
        'YAxisLocation','right',...
        'Color','none');
    ax2.YColor = Y2Color;
    
    hold on
    plot(path21_dist,path21_VmChangeVec,path22_dist,path22_VmChangeVec,path23_dist,path23_VmChangeVec,...
        path24_dist,path24_VmChangeVec,path25_dist,path25_VmChangeVec,path26_dist,path26_VmChangeVec,...
        path27_dist,path27_VmChangeVec,path28_dist,path28_VmChangeVec,'Parent',ax2,'Color',Y2Color);
    
    ylabel('Local Vm Change (mV)')
    axis([xaxis_range yaxis2_range])
    set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
    ax = gca; % current axes
    ax.FontSize = font_size-2;
    set(gca,'xtick',[]);
    set(gca,'xcolor',[1 1 1])
end
hold off

%%
% Plot Tree 2C Paths (dend[23-41] root)
% figure(6)
% n = plot(path20_dist,path20_weight);
% set(n,'Color','k')
% xlabel('Distance from soma (um)')
% ylabel('Threshold synaptic weight to evoke somatic spike (uS)')
% title('Distance dependent synaptic weight thresholds for tree 2C')

toc