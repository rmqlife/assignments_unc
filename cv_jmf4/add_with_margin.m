function ret = add_with_margin(im,vector)
ret = uint8(zeros(size(im)+vector));
ret(1:size(im,1),1:size(im,2)) = im;
