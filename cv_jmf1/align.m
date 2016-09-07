clc; clear; close all;
%im = imread('data/01112v.jpg');
im = imread('data_hires/01861a.tif');
[h,w] = size(im);
% cut the image vertically
h = uint32(floor(h/3));
bim = im(1:h,:);
gim = im(h+1:2*h,:);
rim = im(2*h+1:3*h,:);
if w<500
    % aligned each channel
    align_vector_g = align_image(rim, gim);
    align_vector_b = align_image(rim, bim);
else
    % for high resolution, find an patch contains most edgelets to compute the
    % align vector
    edge_rim = edge(rim,'Canny');
    max_patch_sum = 0;
    patch_location = [0,0];
    patch_size = uint32( min(size(rim))/5);
    for i = 1:patch_size:size(edge_rim,1)-patch_size
        for j = 1:patch_size:size(edge_rim,2)-patch_size
            submat = edge_rim(i:i+patch_size, j:j+patch_size);
            if sum(sum(submat))>max_patch_sum
                patch_location=[i,j];
            end
        end
    end
    i = patch_location(1);
    j = patch_location(2);
    rim_patch = rim(i:i+patch_size, j:j+patch_size);
    gim_patch = gim(i:i+patch_size, j:j+patch_size);
    bim_patch = bim(i:i+patch_size, j:j+patch_size);
    imshow(cat(2,rim_patch,gim_patch,bim_patch));
    
    align_vector_g = align_image(rim_patch, gim_patch);
    align_vector_b = align_image(rim_patch, bim_patch);
    
    bim_patch = circshift(bim_patch,align_vector_b);
    gim_patch = circshift(gim_patch,align_vector_g);
    figure,imshow(cat(2,bim_patch,gim_patch))
end
% aligned_bim = circshift(bim,align_vector_b);
% aligned_gim = circshift(gim,align_vector_g);
% aligned_im = cat(3,rim,aligned_gim,aligned_bim);
% simple_aligned_im = cat(3,rim,gim,bim);
% figure,imshow(cat(2,simple_aligned_im,aligned_im));
