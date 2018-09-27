clear all
close all
%%
%%% Plot Boltzmann Function %%%
font_size = 15;
font_weight = 'normal';
font_angle = 'normal';

p = 0.1:0.1:100;
G0 = 1;
k = 10;
d = 55;
DATA = zeros(length(p),1);

for i = 1:length(p)
    
    G = G0 - G0/(1+(k*exp(d-p(i))));
    DATA(i,1) = G;
end

plot(p,DATA)
xlabel('Distance From Soma (\mum)')
ylabel('Conductance Value (S/cm^2)')
title('Conductance Value Along Dendrites')
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)
ax = gca; % current axes
ax.FontSize = font_size-2;