clear
close all
tic

directory = '~/Desktop/SkinnerLab/Usages/Electrotonic_Analysis/dendrogram/';
font_size = 15;
font_weight = 'normal';
font_angle = 'normal';

diam_vec = load('model_MorphologyDIAMETERS.dat');
dist_vec = load('model_MorphologyLENGTHS.dat');
t = 1;
l = 1;

% Tree 3
t3 = plot(dist_vec(1:3),diam_vec(1:3),'g');
hold on
plot(dist_vec([1:2 4]),diam_vec([1:2 4]),'g')

% Tree 1
t1 = plot(dist_vec([1 5:6]),diam_vec([1 5:6]),'k');
plot(dist_vec([1 5 7:8]),diam_vec([1 5 7:8]),'k')
plot(dist_vec([1 5 7 9:11]),diam_vec([1 5 7 9:11]),'k')
plot(dist_vec([1 5 7 9:10 12]),diam_vec([1 5 7 9:10 12]),'k')
plot(dist_vec([1 5 7 9 13:15]),diam_vec([1 5 7 9 13:15]),'k')
plot(dist_vec([1 5 7 9 13 14 16]),diam_vec([1 5 7 9 13 14 16]),'k')
plot(dist_vec([1 5 7 9 13 17 18]),diam_vec([1 5 7 9 13 17 18]),'k')
plot(dist_vec([1 5 7 9 13 17 19]),diam_vec([1 5 7 9 13 17 19]),'k')

% Tree 2B
t2b = plot(dist_vec([1 25:28]),diam_vec([1 25:28]),'r');
plot(dist_vec([1 25:27 29]),diam_vec([1 25:27 29]),'r')
plot(dist_vec([1 25 26 30:32]),diam_vec([1 25 26 30:32]),'r')
plot(dist_vec([1 25 26 30 31 33]),diam_vec([1 25 26 30 31 33]),'r')
plot(dist_vec([1 25 26 30 34 35]),diam_vec([1 25 26 30 34 35]),'r')
plot(dist_vec([1 25 26 30 34 36:38]),diam_vec([1 25 26 30 34 36:38]),'r')
plot(dist_vec([1 25 26 30 34 36 37 39]),diam_vec([1 25 26 30 34 36 37 39]),'r')
plot(dist_vec([1 25 26 30 34 36 40 41]),diam_vec([1 25 26 30 34 36 40 41]),'r')
plot(dist_vec([1 25 26 30 34 36 40 42]),diam_vec([1 25 26 30 34 36 40 42]),'r')

% Tree 2C
t2c = plot(dist_vec([1 25 43]),diam_vec([1 25 43]),'c');

% Tree 2A
t2a = plot(dist_vec([1 25 44:47]),diam_vec([1 25 44:47]),'b');
plot(dist_vec([1 25 44:46 48:49]),diam_vec([1 25 44:46 48:49]),'b')
plot(dist_vec([1 25 44 45 50:52]),diam_vec([1 25 44 45 50:52]),'b')
plot(dist_vec([1 25 44 45 50 51 53]),diam_vec([1 25 44 45 50 51 53]),'b')
plot(dist_vec([1 25 44 45 50 54 55]),diam_vec([1 25 44 45 50 54 55]),'b')
plot(dist_vec([1 25 44 45 50 54 56]),diam_vec([1 25 44 45 50 54 56]),'b')
plot(dist_vec([1 25 44 57 58]),diam_vec([1 25 44 57 58]),'b')
plot(dist_vec([1 25 44 57 59]),diam_vec([1 25 44 57 59]),'b')

% Axon
axon = plot(dist_vec([1 20 21]),diam_vec([1 20 21]),'m');
plot(dist_vec([1 20 22 23]),diam_vec([1 20 22 23]),'m')
plot(dist_vec([1 20 22 24]),diam_vec([1 20 22 24]),'m')
title('Diameter with distance from soma')
xlabel('Distance (\mum)')
ylabel('Diameter (\mum)')
legend([t1,t2a,t2b,t2c,t3,axon],'Tree 1','Tree 2A','Tree 2B','Tree 2C','Tree 3','Axon')
axis([0 max(dist_vec)+10 0 max(diam_vec)+0.5])
set(findall(gcf,'type','text'),'FontSize',font_size,'FontWeight',font_weight,'FontAngle',font_angle)





