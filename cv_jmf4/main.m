clc; clear; close all;
im1 = imread('wall\im2.pgm');
im2 = imread('wall\im1.pgm');

match_points = detect_and_match(im1,im2);
% RANSAC to filter the match set
% find the homography and tranformation
[H,final_match_points] = ransac_homography(match_points);
show_match_points(im1,im2,final_match_points);

% using affine2d and imwarp to transform im2 to the perspective of im1

% warp the image
[tform,inlierpoints1,inlierpoints2]  = estimateGeometricTransform([final_match_points(:,2),final_match_points(:,1)],[final_match_points(:,4),final_match_points(:,3)],'projective');
warp1 = imwarp(im1,tform);


x0 = final_match_points(1,1);
y0 = final_match_points(1,2);

track_im = uint8(zeros(size(im1)));
track_im(x0,y0) = 255;
track_im = imwarp(track_im,tform);

[num, idx] = max(track_im(:));
[x1, y1] = ind2sub(size(track_im),idx);
shift_vector = (final_match_points(1,3:4) - [x1,y1]);


shift_add_images(warp1,im2,shift_vector);