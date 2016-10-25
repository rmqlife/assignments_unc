clc; clear; close all;
im = imread('wall\im6.pgm');
I = double(im);
Ix = conv2(I,[1,0,-1],'same');
Iy = conv2(I,[1,0,-1]','same');

% naive method for corner detection
[x,y,feature] = naive_corner_nms(im);

% show corners
imshow(im); hold on;
plot(x,y,'ro');


