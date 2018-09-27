clear
close all
tic

directory1 = '~/Desktop/SkinnerLab/Usages/LayerSpecificInputTests/Case7Output/';
directory2 = '~/Desktop/SkinnerLab/Usages/LayerSpecificInputTests/Case8Output/';
directory3 = '~/Desktop/SkinnerLab/Usages/LayerSpecificInputTests/Case8StarOutput/';
directory4 = '~/Desktop/SkinnerLab/Usages/LayerSpecificInputTests/Case9StarOutput/';
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

%%
dist_vec1 = load([directory1 '/model_distvec.dat']);
weight_vec1 = load([directory1 'model_weightvec.dat']);
dist_vec1((dist_vec1(:,1) == 0),:) = [];
weight_vec1((weight_vec1(:,1) == 0),:) = [];

weight_vec1(dist_vec1>300) = []; % Remove distance coordinates less than 300
dist_vec1(dist_vec1>300) = [];

dist_vec2 = load([directory2 '/model_distvec.dat']);
weight_vec2 = load([directory2 'model_weightvec.dat']);
dist_vec2((dist_vec2(:,1) == 0),:) = [];
weight_vec2((weight_vec2(:,1) == 0),:) = [];

weight_vec2(dist_vec2>300) = []; % Remove distance coordinates less than 300
dist_vec2(dist_vec2>300) = [];

dist_vec3 = load([directory3 '/model_distvec.dat']);
weight_vec3 = load([directory3 'model_weightvec.dat']);
dist_vec3((dist_vec3(:,1) == 0),:) = [];
weight_vec3((weight_vec3(:,1) == 0),:) = [];

weight_vec3(dist_vec3>300) = []; % Remove distance coordinates less than 300
dist_vec3(dist_vec3>300) = [];

dist_vec4 = load([directory4 '/model_distvec.dat']);
weight_vec4 = load([directory4 'model_weightvec.dat']);
dist_vec4((dist_vec4(:,1) == 0),:) = [];
weight_vec4((weight_vec4(:,1) == 0),:) = [];

weight_vec4(dist_vec4>300) = []; % Remove distance coordinates less than 300
dist_vec4(dist_vec4>300) = [];

l = 1;
cmap = horzcat(((0:149)/149)',vertcat(zeros(50,1),((0:99)/99)'),vertcat(zeros(100,1),((0:49)/49)'));
border = 300; % Border along dendrites at which synapse parameters change (um)
t = 1;

fig1 = figure(1);
for i = 1:length(dist_vec1)-1
    
    if dist_vec1(i+1) < dist_vec1(i) % If next index is a return to an earlier branching point
        
%         plot([dist_vec(t(1)); dist_vec(l:i)],[weight_vec(t(1)); weight_vec(l:i)],'Color',temp_color)
        plot([dist_vec1(t(1)); dist_vec1(l:i)],[weight_vec1(t(1)); weight_vec1(l:i)],'k')
        hold on
        plot([dist_vec2(t(1)); dist_vec2(l:i)],[weight_vec2(t(1)); weight_vec2(l:i)],'b')
        hold on
        plot([dist_vec3(t(1)); dist_vec3(l:i)],[weight_vec3(t(1)); weight_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],[weight_vec4(t(1)); weight_vec4(l:i)],'g')
        hold on
        
        t = find(dist_vec1 == dist_vec1(i+1)); % Find index of previous branching point
        l = i+1; % Adjust starting index of branch to new branching point
    end

end

xlabel('Synapse Distance from Soma (\mum)')
ylabel('Synaptic Weight to Evoke Somatic Spike (\muS)')
title('Proximal Dendrites (SR)')
axis([0 300 -1 max(weight_vec1)+2.2])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
h = legend('S.2','SD','SD50.1','SD50.2','Location','northwest');
set(h,'FontSize',font_size-2)
hold on

plot([0,30],[0.1,30],'--k'); % zoom in lines
hold on
plot([220,110],[1.5,30],'--k'); % zoom in lines
hold on
% add box proxdist1
plot([88,88],[0.02,0.1],'-.k')
hold on
plot([103,103],[0.02,0.1],'-.k')
hold on
plot([88,103],[0.1,0.1],'-.k')
hold on
plot([88,103],[0.02,0.02],'-.k')
hold on
% add box proxdist2
plot([253,253],[0,20.5],'-.k')
hold on
plot([247,247],[0,20.5],'-.k')
hold on
plot([247,253],[20.5,20.5],'-.k')
hold on
plot([247,253],[0,0],'-.k')
hold on
text(195,18,'Tree 2B \rightarrow','FontSize',font_size-7,'FontWeight','Bold')
hold on
% create smaller axes in top right, and plot on it
axes('Position',[.21 .4 .2 .2])
box on
for i = 1:length(dist_vec1)-1
    
    if dist_vec1(i+1) < dist_vec1(i) % If next index is a return to an earlier branching point
        
%         plot([dist_vec(t(1)); dist_vec(l:i)],[weight_vec(t(1)); weight_vec(l:i)],'Color',temp_color)
        plot([dist_vec1(t(1)); dist_vec1(l:i)],[weight_vec1(t(1)); weight_vec1(l:i)],'k')
        hold on
        plot([dist_vec2(t(1)); dist_vec2(l:i)],[weight_vec2(t(1)); weight_vec2(l:i)],'b')
        hold on
        plot([dist_vec3(t(1)); dist_vec3(l:i)],[weight_vec3(t(1)); weight_vec3(l:i)],'r')
        hold on
        plot([dist_vec4(t(1)); dist_vec4(l:i)],[weight_vec4(t(1)); weight_vec4(l:i)],'g')
        hold on
        
        t = find(dist_vec1 == dist_vec1(i+1)); % Find index of previous branching point
        l = i+1; % Adjust starting index of branch to new branching point
    end

end
axis([0 220 0 0.02])
title('Tree 2 Branching Point')
ax = gca; % current axes
ax.FontSize = font_size-9;
hold on
% add box proxdist1
plot([88,88],[0.002,0.01],'-.k')
hold on
plot([103,103],[0.002,0.01],'-.k')
hold on
plot([88,103],[0.01,0.01],'-.k')
hold on
plot([88,103],[0.002,0.002],'-.k')
hold off

%% Load and Plot Voltage Traces
tvec = 0.1:0.1:100.1;
proxdist1 = 94.5822;
proxdist2 = 250.3660;

files1 = dir([directory1 'modelV*_DendriteNumber.dat']);
VoltMat11 = zeros(1001,length(files1));
VoltMat21 = zeros(1001,length(files1));
dist1 = zeros(length(files1),1);
weight_vec11 = zeros(length(files1),1);
weight_vec21 = zeros(length(files1),1);

files2 = dir([directory2 'modelV*_DendriteNumber.dat']);
VoltMat12 = zeros(1001,length(files2));
VoltMat22 = zeros(1001,length(files2));
dist2 = zeros(length(files2),1);
weight_vec12 = zeros(length(files2),1);
weight_vec22 = zeros(length(files2),1);

files3 = dir([directory3 'modelV*_DendriteNumber.dat']);
VoltMat13 = zeros(1001,length(files3));
VoltMat23 = zeros(1001,length(files3));
dist3 = zeros(length(files3),1);
weight_vec13 = zeros(length(files3),1);
weight_vec23 = zeros(length(files3),1);

files4 = dir([directory4 'modelV*_DendriteNumber.dat']);
VoltMat14 = zeros(1001,length(files4));
VoltMat24 = zeros(1001,length(files4));
dist4 = zeros(length(files4),1);
weight_vec14 = zeros(length(files4),1);
weight_vec24 = zeros(length(files4),1);

for u=1:length(files1)
    temp1 = load([directory1 files1(u).name]); % load individual trace from file
    
    a1 = textscan(files1(u).name,'%*s %f %*s %f %*s %f %*s','delimiter','_');
    if a1{1} == proxdist1
        VoltMat11(:,u) = temp1; % Store trace vector in matrix
        weight_vec11(u,1) = a1{2};
    elseif a1{1} == proxdist2
        VoltMat21(:,u) = temp1;
        weight_vec21(u,1) = a1{2};
    end
    
    dist1(u,1) = a1{1};
    
end

for u2=1:length(files2)
    temp2 = load([directory2 files2(u2).name]); % load individual trace from file
    
    a2 = textscan(files2(u2).name,'%*s %f %*s %f %*s %f %*s','delimiter','_');
    if a2{1} == proxdist1
        VoltMat12(:,u2) = temp2; % Store trace vector in matrix
        weight_vec12(u2,1) = a2{2};
    elseif a2{1} == proxdist2
        VoltMat22(:,u2) = temp2;
        weight_vec22(u2,1) = a2{2};
    end
    
    dist2(u2,1) = a2{1};
    
end

for u3=1:length(files3)
    temp3 = load([directory3 files3(u3).name]); % load individual trace from file
    
    a3 = textscan(files3(u3).name,'%*s %f %*s %f %*s %f %*s','delimiter','_');
    if a3{1} == proxdist1
        VoltMat13(:,u3) = temp3; % Store trace vector in matrix
        weight_vec13(u3,1) = a3{2};
    elseif a3{1} == proxdist2
        VoltMat23(:,u3) = temp3;
        weight_vec23(u3,1) = a3{2};
    end
    
    dist3(u3,1) = a3{1};
    
end

for u4=1:length(files4)
    temp4 = load([directory4 files4(u4).name]); % load individual trace from file
    
    a4 = textscan(files4(u4).name,'%*s %f %*s %f %*s %f %*s','delimiter','_');
    if a4{1} == proxdist1
        VoltMat14(:,u4) = temp4; % Store trace vector in matrix
        weight_vec14(u4,1) = a4{2};
    elseif a4{1} == proxdist2
        VoltMat24(:,u4) = temp4;
        weight_vec24(u4,1) = a4{2};
    end
    
    dist4(u4,1) = a4{1};
    
end

VoltMat11(:,(VoltMat11(1,:) == 0)) = []; % Remove empty indices
VoltMat21(:,(VoltMat21(1,:) == 0)) = [];
weight_vec11(weight_vec11(:) == 0) = []; % Remove empty indices
weight_vec21(weight_vec21(:) == 0) = [];

VoltMat12(:,(VoltMat12(1,:) == 0)) = []; % Remove empty indices
VoltMat22(:,(VoltMat22(1,:) == 0)) = [];
weight_vec12(weight_vec12(:) == 0) = []; % Remove empty indices
weight_vec22(weight_vec22(:) == 0) = [];

VoltMat13(:,(VoltMat13(1,:) == 0)) = []; % Remove empty indices
VoltMat23(:,(VoltMat23(1,:) == 0)) = [];
weight_vec13(weight_vec13(:) == 0) = []; % Remove empty indices
weight_vec23(weight_vec23(:) == 0) = [];

VoltMat14(:,(VoltMat14(1,:) == 0)) = []; % Remove empty indices
VoltMat24(:,(VoltMat24(1,:) == 0)) = [];
weight_vec14(weight_vec14(:) == 0) = []; % Remove empty indices
weight_vec24(weight_vec24(:) == 0) = [];

figure(2)
subplot(2,1,1)
p1 = plot(tvec,VoltMat11(:,1),'k');
hold on
p2 = plot(tvec,VoltMat12(:,1),'b');
hold on
p3 = plot(tvec,VoltMat13(:,1),'r');
hold on
p4 = plot(tvec,VoltMat14(:,1),'g');
hold off
% xlabel('Time (ms)')
% ylabel('Voltage (mV)')
title(['Synapse at ',num2str(proxdist1),' \mum from Soma (Tree 2)'])
legend([p1(1),p2(1),p3(1),p4(1)],['S.2 synapse weight = ' num2str(weight_vec11(1))]...
    ,['SD synapse weight = ' num2str(weight_vec12(1))]...
    ,['SD50.1 synapse weight = ' num2str(weight_vec13(1))]...
    ,['SD50.2 synapse weight = ' num2str(weight_vec14(1))])
axis([0 max(tvec) -80 40])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-6;

subplot(2,1,2)
q1 = plot(tvec,VoltMat21(:,1),'k');
hold on
q2 = plot(tvec,VoltMat22(:,1),'b');
hold on
q3 = plot(tvec,VoltMat23(:,1),'r');
hold on
q4 = plot(tvec,VoltMat24(:,1),'g');
hold off
xlabel('Time (ms)')
y = ylabel('Voltage (mV)');
set(y,'Units','Normalized','Position',[-0.1,1.2,0])
title(['Synapse at ',num2str(proxdist2),' \mum from Soma (Tree 2B)'])
legend([q1(1),q2(1),q3(1),q4(1)],['S.2 synapse weight = ' num2str(weight_vec21(1))]...
    ,['SD synapse weight = ' num2str(weight_vec22(1))]...
    ,['SD50.1 synapse weight = ' num2str(weight_vec23(1))]...
    ,['SD50.2 synapse weight = ' num2str(weight_vec24(1))])
axis([0 max(tvec) -80 40])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-6;
%%

toc