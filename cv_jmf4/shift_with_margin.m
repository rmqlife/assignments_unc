function ret = shift_with_margin(im,vector)
ret = uint8(zeros(size(im)+vector));
ret(vector(1)+1:end,vector(2)+1:end) = im;
