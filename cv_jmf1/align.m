clc; clear; close all;
im = imread('data/00398v.jpg');

[h,w] = size(im);
% cut the image vertically
h = uint32(floor(h/3));
bim = im(1:h,:);
gim = im(h+1:2*h,:);
rim = im(2*h+1:3*h,:);
% aligned each channel
aligned_gim = align_image(rim, gim);
aligned_bim = align_image(rim, bim);
aligned_im = cat(3,rim,aligned_gim,aligned_bim);
simple_aligned_im = cat(3,rim,gim,bim);
figure,imshow(cat(2,simple_aligned_im,aligned_im));

