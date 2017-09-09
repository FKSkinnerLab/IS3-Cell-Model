function f_changes=f(im_ind)

% im_ind is a 2D array w/ class indices for pels
% this function calculates how many of the pixel-edges have a different
% class on either side of the edge

% sizing
n_rows=size(im_ind,1);
n_cols=size(im_ind,2);
n_pels=n_rows*n_cols;

% do it
col_diff=(im_ind(2:end,:)~=im_ind(1:end-1,:)) ;
row_diff=(im_ind(:,2:end)~=im_ind(:,1:end-1));
%col_diff=(diff(im_ind )~=0);  % this doesn't work for uint8 arrays
%row_diff=(diff(im_ind')~=0);
f_changes_col=mean(mean(col_diff));
f_changes_row=mean(mean(row_diff));
n_c=numel(col_diff);
n_r=numel(row_diff);
f_changes=(n_c*f_changes_col+n_r*f_changes_row)/(n_c+n_r);
