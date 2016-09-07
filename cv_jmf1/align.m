clc; clear; close all;
SIZE_THRESH = 400;

% im = imread('data/01112v.jpg');
im = imread('data_hires/01047u.tif');
[h,w] = size(im);
% cut the image vertically
h = uint32(floor(h/3));
bim = im(1:h,:);
gim = im(h+1:2*h,:);
rim = im(2*h+1:3*h,:);

if w< SIZE_THRESH
    % aligned each channel
    [aligned_gim, align_vector_g] = align_channels(rim, gim, 10);
    [aligned_bim, align_vector_b] = align_channels(rim, bim, 10);
    aligned_im = cat(3,rim,aligned_gim,aligned_bim);
    imshow(aligned_im);
else
    % for high resolution, find an patch contains most edgelets to compute the
    % align vector
    % down sampling first
    im_pyramid = {};
    [h,w] = size(rim);
    while size(rim,1)>SIZE_THRESH
        im_pyramid = [{rim,gim,bim};im_pyramid];
        rim = imresize(rim,1/2,'nearest');
        bim = imresize(bim,1/2,'nearest');
        gim = imresize(gim,1/2,'nearest');
    end
   
    [aligned_gim, align_vector_g] = align_channels(rim, gim, 10);
    [aligned_bim, align_vector_b] = align_channels(rim, bim, 10);
    
    for i = 1:size(im_pyramid,1)
        align_vector_g = 2*align_vector_g;
        align_vector_b = 2*align_vector_b;
        
        [rim,gim,bim] = im_pyramid{i,:};
        gim = circshift(gim, align_vector_g);
        bim = circshift(bim, align_vector_b);
        
        [aligned_gim, align_vector_g_new] = align_channels(rim, gim, 5);
        [aligned_bim, align_vector_b_new] = align_channels(rim, bim, 5);
        
        align_vector_g = align_vector_g_new + align_vector_g;
        align_vectro_b = align_vector_b_new + align_vector_b;
        
        aligned_im = cat(3,rim,aligned_gim,aligned_bim);
        figure,imshow(aligned_im);
    end
end