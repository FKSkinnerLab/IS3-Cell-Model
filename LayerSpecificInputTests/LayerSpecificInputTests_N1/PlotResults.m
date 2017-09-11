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

weight_vec1(dist_vec1<300) = []; % Remove distance coordinates less than 300
dist_vec1(dist_vec1<300) = [];

dist_vec2 = load([directory2 '/model_distvec.dat']);
weight_vec2 = load([directory2 'model_weightvec.dat']);
dist_vec2((dist_vec2(:,1) == 0),:) = [];
weight_vec2((weight_vec2(:,1) == 0),:) = [];

weight_vec2(dist_vec2<300) = []; % Remove distance coordinates less than 300
dist_vec2(dist_vec2<300) = [];

dist_vec3 = load([directory3 '/model_distvec.dat']);
weight_vec3 = load([directory3 'model_weightvec.dat']);
dist_vec3((dist_vec3(:,1) == 0),:) = [];
weight_vec3((weight_vec3(:,1) == 0),:) = [];

weight_vec3(dist_vec3<300) = []; % Remove distance coordinates less than 300
dist_vec3(dist_vec3<300) = [];

dist_vec4 = load([directory4 '/model_distvec.dat']);
weight_vec4 = load([directory4 'model_weightvec.dat']);
dist_vec4((dist_vec4(:,1) == 0),:) = [];
weight_vec4((weight_vec4(:,1) == 0),:) = [];

weight_vec4(dist_vec4<300) = []; % Remove distance coordinates less than 300
dist_vec4(dist_vec4<300) = [];

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
% title([Case ' Layer-Specific Synaptic Weight Thresholds'])
axis([300 max(dist_vec1)+5 -0.1 max(weight_vec1)+2.2])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;
h = legend('S.2','SD','SD50.1','SD50.2');
set(h,'FontSize',font_size-2)
hold on

plot([400,430],[0.1,1.2],'--k'); % zoom in lines
hold on
plot([482,482],[0.1,1.2],'--k'); % zoom in lines

hold on
% create smaller axes in top right, and plot on it
axes('Position',[.69 .4 .2 .2])
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
axis([400 max(dist_vec1)+5 0 0.06])
title('Distal Tree 1')
ax = gca; % current axes
ax.FontSize = font_size-9;
hold off

% % Load and Plot Voltage Traces
% files = dir([directory 'modelV*_DendriteNumber.dat']);
% VoltMat1 = zeros(1001,length(files));
% VoltMat2 = zeros(1001,length(files));
% dist = zeros(length(files),1);
% peakamp = zeros(length(files),1);
% tvec = 0.1:0.1:100.1;
% 
% for u=1:length(files)
%     temp = load([directory files(u).name]); % load individual trace from file
%     
%     a = textscan(files(u).name,'%*s %d %*s %d %*s %d %*s','delimiter','_');
%     if a{1} < 300
%         VoltMat1(:,u) = temp; % Store trace vector in matrix
%     elseif a{1} >= 300
%         VoltMat2(:,u) = temp;
%     end
%     
%     dist(u,1) = a{1};
%     peakamp(u,1) = max(temp);
%     
% end
% 
% dist_peakamp_mat1 = horzcat(dist,peakamp);
% dist_peakamp_mat = sortrows(dist_peakamp_mat1);
% 
% figure(2) % Distance VS Spike Amplitude Plot
% plot(dist_peakamp_mat(:,1),dist_peakamp_mat(:,2))
% title(Case)
% xlabel('Synapse Distance from Soma (\mum)')
% ylabel('Somatic Peak Spike Amplitude (mV)')
% axis([0 max(dist_peakamp_mat(:,1)) -80 40])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
% ax = gca; % current axes
% ax.FontSize = font_size-2;
% 
% VoltMat1(:,(VoltMat1(1,:) == 0)) = []; % Remove empty indices
% VoltMat2(:,(VoltMat2(1,:) == 0)) = [];
% 
% figure(3)
% p1 = plot(tvec,VoltMat1,'k');
% hold on
% p2 = plot(tvec,VoltMat2,'r');
% hold off
% xlabel('Time (ms)')
% ylabel('Voltage (mV)')
% title(Case)
% legend([p1(1),p2(2)],'Synapse <= 300 \mum from soma','Synapse > 300 \mum from soma')
% axis([0 max(tvec) min(min(VoltMat1))-10 max(max(VoltMat1))+10])
% set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
% ax = gca; % current axes
% ax.FontSize = font_size-2;

%%

toc