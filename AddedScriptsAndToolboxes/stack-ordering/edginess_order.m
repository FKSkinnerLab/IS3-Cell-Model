function f_changes=f(order,class_ind)

im_class_ind=dim_stack_image(class_ind,order);
f_changes=edginess_class_image(im_class_ind);
