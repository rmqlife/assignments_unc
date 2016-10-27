function feature = feature_descriptor(im,pt)
w = 20;
w_small = 4;
feature = zeros(size(pt,1),w_small^2);
% add border of im
ext_im = uint8(zeros(size(im)+[w*2,w*2]));
ext_im(w+1:size(im,1)+w,w+1:size(im,2)+w) = im(:,:);
for i=1:size(pt,1)
    ptx = pt(i,1);
    pty = pt(i,2);
    window = ext_im(ptx:ptx+2*w,pty:pty+2*w);
    window = imresize(window,[w_small,w_small]);
    feature(i,:) = window(:);
end
