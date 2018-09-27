function f(axes_h,db,order,dim_labels)

% the order variable is the order in which to put the axes.  If there are,
% say, nine dimensions, then order is a permutation fo the numbers from 1
% to 9.  It is interpreted this way:
%
%  [ 4 5 3 9 8  1 7 2 6 ]
%    ^       ^  ^     ^---- high order x dimension 
%    |       |  ----------- low  order x dimension
%    |       |
%    |       -------------- high order y dimension
%    ---------------------- low  order y dimension

% units stuff (a "dit" is a "data unit")
dits_per_pt=axes_dits_per_pt(axes_h);  
bar_spacing_pts=16;%8;  % points
bar_spacing_dits=dits_per_pt*bar_spacing_pts;
text_offset_pts=3;  % points
text_offset_dits=dits_per_pt*text_offset_pts;

% DB shape stuff
db_shape=size(db);
db_shape_perm=db_shape(order);
n_dims=length(db_shape);
n_y_dims=ceil(n_dims/2);
n_x_dims=n_dims-n_y_dims;

%
% x axis bars
%

for i_x=n_x_dims:-1:1  % go from coarse to fine
  i=n_y_dims+i_x;  % order(i) gives us the dim we're making a bar for
  line([0.5 max(xlim(axes_h))/prod(db_shape_perm(i:n_dims))],...
       [-i_x*bar_spacing_dits(2)+0.5 -i_x*bar_spacing_dits(2)+0.5],...
       'LineWidth',2,...
       'Clipping','off',...
       'color',[0 0 0]);
  text(max(xlim(axes_h))/prod(db_shape_perm(i:n_dims))+...
         text_offset_dits(1)+0.5,...
       -i_x*bar_spacing_dits(2)+0.5,...
       dim_labels{order(i)},...
       'fontsize',18+(i_x-n_x_dims+0.5));
end

%
% y axis bars
%

for i_y=n_y_dims:-1:1  % go from coarse to fine
  i=i_y;  % order(i) gives us the dim we're making a bar for
  line([-i_y*bar_spacing_dits(1) -i_y*bar_spacing_dits(1)],...
       [0.5 max(ylim(axes_h))/prod(db_shape_perm(i_y:n_y_dims))],...
       'LineWidth',2,...
       'Clipping','off',...
       'color',[0 0 0]);
  text(-i_y*bar_spacing_dits(1),...
       max(ylim(axes_h))/prod(db_shape_perm(i_y:n_y_dims))+...
         text_offset_dits(2)+0.5,...
       dim_labels{order(i)},...
       'fontsize',18+(i_y-n_y_dims),'rotation',+90);
end

