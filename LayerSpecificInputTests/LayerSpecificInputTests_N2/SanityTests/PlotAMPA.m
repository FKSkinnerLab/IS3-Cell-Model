tic
clear all
close all

%%

font_size = 15;
font_weight = 'normal';
font_angle = 'normal';

t = 0.1:0.1:100; % ms
Vh = -70:20:30; % Holding Membrane Potential (mV)

G = zeros(length(Vh),length(t)); % Synaptic Conductance Vector
G_norm = zeros(length(Vh),length(t)); % Synaptic Conductance Vector
i = zeros(length(Vh),length(t)); % Synaptic Current vector
tau1 = 1.71; % Rise Time (ms)
tau2 = 5; % Decay Tiem (ms)
tp = (tau1*tau2)/(tau2 - tau1) * log(tau2/tau1); % For normalization so that peak is 1(?)
factor = 1/(-exp(-tp/tau1) + exp(-tp/tau2)); % For normalization so that peak is 1(?)
Er = 0; % Reversal Potential (mV)
weight = 0.0003; % nS
str = {['Rise Time = ' num2str(tau1) ' ms'],['Decay Time = ' num2str(tau2) ' ms'],...
    ['Reversal Potential = ' num2str(Er) ' mV'],['Weight = ' num2str(weight) ' nS']}';

for k = 1:length(t)
    
    for l = 1:length(Vh)
        
        G_norm(l,k) = weight*factor*(exp(-t(k)/tau2)-exp(-t(k)/tau1)); % With factor
        G(l,k) = weight*(exp(-t(k)/tau2)-exp(-t(k)/tau1)); % Without factor
        i(l,k) = G_norm(l,k)*(Vh(l)-Er);
        
    end
    
end

figure(1)
s1 = subplot(2,1,1);
plot(t,i)
xlabel('Time (ms)')
ylabel('Synaptic Current (nA)')
legend(['Vh = ' num2str(Vh(1))],['Vh = ' num2str(Vh(2))],['Vh = ' num2str(Vh(3))],...
    ['Vh = ' num2str(Vh(4))],['Vh = ' num2str(Vh(5))],['Vh = ' num2str(Vh(6))])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca;
ax.FontSize = font_size-2;
set(s1,'yticklabel',num2str(get(s1,'ytick')','%.4f'))

s2 = subplot(2,1,2);
plot(t,G_norm(end,:),t,G(end,:));
xlabel('Time (ms)')
ylabel('Synaptic Conductance (nS)')
hold on
text(60,max(max(G_norm))/2.1,str)
legend('With normalization','Without normalization')

set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca;
ax.FontSize = font_size-2;
set(s2,'yticklabel',num2str(get(s2,'ytick')','%.5f'))

%%

toc