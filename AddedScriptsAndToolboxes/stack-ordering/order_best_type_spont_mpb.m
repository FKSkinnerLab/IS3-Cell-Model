% load the data
load 'type_spont_mpb.mat';
n_models=numel(type_spont_mpb);

% % code for type_spont_mpb
% silent=0;
% tonic=-1;
% irregular=-2;
% burster_irregular=-3;
% % anything >=1 is the number of maxima per burst

% want >=4 to be same
type_spont_mpb=min(type_spont_mpb,4);

% make the colormap
cmap=[ 0   0   0   ; ...
       0   1   1   ; ...
       0   0   1   ; ...
       0.9 0.9 0.9 ; ...
       1   0   0   ; ...
       0   1   0   ; ...
       1   0   1   ; ...
       1   1   0   ];

% % choose an order
% order_manual=[7 2 3 1  8 4 5 6];
% order_manual=[8 4 6 1  7 3 2 5];  % a nice order found w/ optim
% edginess_manual=edginess_order(order_manual,type_spont_mpb)
% figure_dim_stack(type_spont_mpb,order_manual,[],cmap);            
% title('Manual');              

% pick random order
%order0=[1 2 3 4 5 6 7 8];
order0=randperm(8);

% show it
figure_dim_stack(type_spont_mpb,order0,[],cmap);
drawnow;

% optimize edginess
tic
order=...
  descend_edginess_order(order0,type_spont_mpb)
toc

% show best
figure_dim_stack(type_spont_mpb,order,[],cmap);
drawnow;

% % show sequence
% for i=1:size(order_seq,1)
%   order_this=order_seq(i,:);
%   figure_dim_stack(type_spont_mpb,order_this,[],cmap);
% end

% % write the images
% for i=1:size(order_seq,1)
%   order_this=order_seq(i,:);
%   im=dim_stack_image(type_spont_mpb,order_this);
%   imwrite(ind2rgb(im,cmap),sprintf('type_spont_mpb_%d.tif',i-1),'tiff');
% end
