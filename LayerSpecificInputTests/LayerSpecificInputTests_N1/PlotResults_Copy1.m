clear
close all
tic

Case = 'Case 9*';
directory = '~/Desktop/SkinnerLab/Usages/LayerSpecificInputTests/Case9StarOutput/';
font_size = 20;
font_weight = 'normal';
font_angle = 'normal';

%%
dist_vec = load([directory '/model_distvec.dat']);
weight_vec = load([directory 'model_weightvec.dat']);
dist_vec((dist_vec(:,1) == 0),:) = [];
weight_vec((weight_vec(:,1) == 0),:) = [];
l = 1;
cmap = horzcat(((0:149)/149)',vertcat(zeros(50,1),((0:99)/99)'),vertcat(zeros(100,1),((0:49)/49)'));
border = 300; % Border along dendrites at which synapse parameters change (um)
t = 1;

figure(1)
for i = 1:length(dist_vec)-1
    
    if dist_vec(i+1) < dist_vec(i) % If next index is a return to an earlier branching point
        temp_color = cmap(l,:); % Use increasingly lighter color for each branch that is plotted
        
%         plot([dist_vec(t(1)); dist_vec(l:i)],[weight_vec(t(1)); weight_vec(l:i)],'Color',temp_color)
        plot([dist_vec(t(1)); dist_vec(l:i)],[weight_vec(t(1)); weight_vec(l:i)],'Color','k')

        hold on
        
        t = find(dist_vec == dist_vec(i+1)); % Find index of previous branching point
        l = i+1; % Adjust starting index of branch to new branching point
    end

end

plot([border,border],[0,max(weight_vec)],'--b','LineWidth',2)
if max(weight_vec)>0.5
    plot([0,max(dist_vec)],[0.5,0.5],'--r','LineWidth',2)
else
    set(gca, 'YTickLabel', num2str(get(gca, 'YTick')', '%.4f')); % Only for Case 8
end
xlabel('Synapse Distance from Soma (\mum)')
ylabel('Synaptic Weight to Evoke Somatic Spike (\muS)')
% title([Case ' Layer-Specific Synaptic Weight Thresholds'])
axis([0 max(dist_vec) 0 max(weight_vec)])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

hold off
%% Load and Plot Voltage Traces
files = dir([directory 'modelV*_DendriteNumber.dat']);
VoltMat1 = zeros(1001,length(files));
VoltMat2 = zeros(1001,length(files));
dist = zeros(length(files),1);
peakamp = zeros(length(files),1);
tvec = 0.1:0.1:100.1;

for u=1:length(files)
    temp = load([directory files(u).name]); % load individual trace from file
    
    a = textscan(files(u).name,'%*s %d %*s %d %*s %d %*s','delimiter','_');
    if a{1} < 300
        VoltMat1(:,u) = temp; % Store trace vector in matrix
    elseif a{1} >= 300
        VoltMat2(:,u) = temp;
    end
    
    dist(u,1) = a{1};
    peakamp(u,1) = max(temp);
    
end

dist_peakamp_mat1 = horzcat(dist,peakamp);
dist_peakamp_mat = sortrows(dist_peakamp_mat1);

figure(2) % Distance VS Spike Amplitude Plot
plot(dist_peakamp_mat(:,1),dist_peakamp_mat(:,2))
% title(Case)
xlabel('Synapse Distance from Soma (\mum)')
ylabel('Somatic Peak Spike Amplitude (mV)')
axis([0 max(dist_peakamp_mat(:,1)) -80 40])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

VoltMat1(:,(VoltMat1(1,:) == 0)) = []; % Remove empty indices
VoltMat2(:,(VoltMat2(1,:) == 0)) = [];

figure(3)
p1 = plot(tvec,VoltMat1,'k');
hold on
p2 = plot(tvec,VoltMat2,'r');
hold off
xlabel('Time (ms)')
ylabel('Voltage (mV)')
% title(Case)
legend([p1(1),p2(2)],'Synapse <= 300 \mum from soma','Synapse > 300 \mum from soma')
axis([0 max(tvec) min(min(VoltMat1))-10 max(max(VoltMat1))+10])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;

%%

toc