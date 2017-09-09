function im_ret=figure_dim_stack(db,order,db_range,cmap, ...
                                 legend_strings,axis_labels)

% Function to create a figure showing the data in db, laid out so you can
% see it in 2D.  db contains an n-dimensional database of some sort.
% Usually each dimension corresponds to a parameter of some sort.  order
% specifies the order to 'stack' the dimensions of db, and is of length n.
% Assuming n is even, the first n/2 elements specify the stack ordering for
% the y axis, the second n/2 those for the y axis, with the first element,
% for instance, containing the "least significant" dimension to be placed
% on the y axis.  db_range is a 2-element vector indicating the range of
% values to be found in db.  cmap specifies a colormap to be used for the
% visualization, each row a color, with the first row giving the color for
% db_range(1), the last row giving the color for db_range(2).
% legend_strings is a cell array of strings, giving the "name" of each
% dimension in db.  legend_strings is a cell array of strings, each giving
% a label for each possible value in db.  axis_labels is an n-element cell
% array giving the "name" of each dimension in db.
%
% The returned value is an RGB image of the plotted image.

% get min and max
db_min=min(db(:));
db_max=max(db(:));

% deal w/ args
if nargin<3 || isempty(db_range)
  db_range=[db_min db_max];
end
n_classes=db_range(2)-db_range(1)+1;
if nargin<6 || isempty(axis_labels)
  axis_labels={'Na' 'CaT' 'CaS' 'A' 'KCa' 'Kd' 'h' 'leak'}';
end

% any NaN's in db?
if any(~isfinite(db(:)))
  warning('there are Inf''s or NaN''s in db!');
end

if nargin<4 || isempty(cmap)
  if n_classes==2
    cmap=[ 0 0 0 ; 1 1 1 ];
  else
    cmap=distinct_hues_simple(n_classes);
  end
elseif isa(cmap,'function_handle')
  cmap_fun=cmap;
  cmap=feval(cmap_fun,n_classes);
end

if nargin<5 || isempty(legend_strings)
  if islogical(db)
    legend_strings={'false' 'true'}';
  else
    legend_numbers=(db_range(1):db_range(2))';
    legend_strings=cell(n_classes,1);
    for i=1:n_classes
      legend_strings{i}=num2str(legend_numbers(i));
    end
  end
end

% % convert a boolean db to an int type
% if islogical(db)
%   db=uint8(db);
% end

% make the indices start at 0 or 1, depending on the type
% this makes sure things work with ind2rgb()
if isa(db,'integer')
  db=db-db_range(1);
elseif isa(db,'float')
  db=db-db_range(1)+1;
end

% make the dim stack image
im=dim_stack_image(db,order);

% make an RGB image
im_rgb=ind2rgb(im,cmap);

% this is the one that gets returned
im_ret=flipdim(im_rgb,1);

% make the figure
figure('color','w');
set_figure_size([8 6]);
image(im_rgb);
colormap(cmap);
axis square;
% axis equal;
% axis tight;
set(gca,'xtick',[]);
set(gca,'ytick',[]);
set(gca,'YDir','normal');  % want Cartesian coords

% create the axes labels
draw_dim_stack_axis_bars(gca,db,order,axis_labels);

% add a legend
n_max_labels=11;
n_labels=n_classes;
hs=zeros(n_labels,1);
hold on;
for i=1:n_labels
disp(sprintf('at label %i\n where n_classes is %d',i,n_classes));
  if all(cmap(i,:)==1)
    % if the color is white
    hs(i)=patch([0 1 1 0 0],[0 0 1 1 0],cmap(i,:),...
                'EdgeColor','k','Visible','on');
  else
    % any not-white color
    hs(i)=patch([0 1 1 0 0],[0 0 1 1 0],cmap(i,:),...
                'EdgeColor','none','Visible','off');
  end
end
hold off;
legend(hs,legend_strings,'Location','EastOutside');
legend('boxoff');
