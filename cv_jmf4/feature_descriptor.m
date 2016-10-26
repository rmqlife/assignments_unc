function feature = feature_descriptor(im,pt)
pt = [x2,y2];
w = 10;
feature = zeros(size(pt,1),(w*2+1)*(w*2+1));

for i=1:size(pt,1)
    ptx = pt(i,1);
    pty = pt(i,2);
    window = im(ptx-w:ptx+w,pty-w:pty+w);
    feature(i,:) = window(:);
end