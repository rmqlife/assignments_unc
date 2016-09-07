clc;close all;clear;
im = imread('crayons_mosaic.bmp');
% bayer pattern recontruction
im = bayer_pattern(im);
imshow(im);

% error visualize
im_origin = imread('crayons.jpg');
[h,w,d] =  size(im_origin);
squared_diff = zeros(h,w);
max_diff = zeros(3,1);
mean_diff = zeros(3,1);
for i=1:3
    dim = im_origin(:,:,i)-im(:,:,i);
    max_diff(i) = max(abs(dim(:)));
    mean_diff(i) = mean(abs(dim(:)));
    dim = double(dim);
    dim = dim.*dim;
    squared_diff = squared_diff + dim;
end;
figure, imagesc(squared_diff);

% bayer pattern 
