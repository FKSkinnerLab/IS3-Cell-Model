function order=descend_edginess_order(order0,class_ind,fixed_high_order)

n=length(order0);
order=order0;
edginess=edginess_order(order,class_ind)
ind_matrix=(repmat((1:n)',[1 n]))';
ind_matrix_trans=ind_matrix';
pairs_all=[(ind_matrix(:))';(ind_matrix_trans(:))'];
pairs_all_valid=(pairs_all(1,:)<pairs_all(2,:));

%{
  Fix the highest-order pair if specified - for use when generating
  pairwise conductance correlation stacks. Of course, this implicitly
  assumes that order0 is not random, and that the user wants a specific
  highest-order pair to be fixed.
%}
if exist('fixed_high_order', 'var')
  hi_y = n/2;
  hi_x = n;
  pairs_all_fixed_high = (pairs_all(1,:)~=hi_y & pairs_all(2,:)~=hi_y) & (pairs_all(1,:)~=hi_x & pairs_all(2,:)~=hi_x);
  pairs=pairs_all(:,pairs_all_valid & pairs_all_fixed_high);
else
  pairs=pairs_all(:,pairs_all_valid);
end

found_better=true;
while found_better
  found_better=false;
  i_pair=randperm(size(pairs,2));
  pairs_permed=pairs(:,i_pair);
  for i_pair_permed=1:size(pairs_permed,2)
    pair_this=pairs_permed(:,i_pair_permed);
    % make the candidate order, by flipping i1 and i2
    order_test=order;
    order_test(pair_this(1))=order(pair_this(2));
    order_test(pair_this(2))=order(pair_this(1));
    edginess_test=edginess_order(order_test,class_ind);
    if edginess_test<edginess
      order=order_test;
      edginess=edginess_test
      found_better=true;
      break;  % break out of innermost loop
    end
  end
end
