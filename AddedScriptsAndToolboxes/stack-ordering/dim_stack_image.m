function im=f(table,order)

% the order variable is the order in which to put the axes.  If there are,
% say, eight dimensions, then order is a permutation fo the numbers from 1
% to 8.  It is interpreted this way:
%
%  [ 4 5 3 8  1 7 2 6 ]
%    ^     ^  ^     ^---- high order x dimension 
%    |     |  ----------- low  order x dimension
%    |     |
%    |     -------------- high order y dimension
%    -------------------- low  order y dimension
%

n_dims=ndims(table);
n_steps=size(table);  
table_perm=permute(table,order);
n_steps_perm=n_steps(order);
last_y=ceil(n_dims/2);  % put extra dim, if any, on y
im=reshape(table_perm,[prod(n_steps_perm(1       :last_y)) ...
                       prod(n_steps_perm(last_y+1:n_dims))]);
