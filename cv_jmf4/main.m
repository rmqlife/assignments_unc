clc; clear; close all;
im = imread('wall\im1.pgm');
im2 = imread('wall\im2.pgm');
% naive method for corner detection
[pt1,feat1] = naive_corner_nms(im);
[pt2,feat2] = naive_corner_nms(im2);
% show corners
imshow([im,im2]); hold on;
plot(pt1(:,2),pt1(:,1),'ro');
plot(size(im,2)+pt2(:,2),pt2(:,1),'bo');

%feature descriptor
show_ssd = 0;
if show_ssd
    k = zeros(size(x,1),size(x2,1));
    for i = 1:size(k,1)
        for j = 1:size(k,2)
            k(i,j) =sqrt((x(i)-x2(j))^2 + (y(i)-y2(j))^2);
        end
    end
    figure,imagesc(k);
end

%match feature
for i = 1:size(feat1,1)
    for j =1:size(feat2,1)
        
    end
end