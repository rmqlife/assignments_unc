clc; clear; close all;
im1 = imread('wall\im1.pgm');
im2 = imread('wall\im3.pgm');

match_points = detect_and_match(im1,im2);
[H,final_match_points] = ransac_homography(match_points);
show_match_points(im1,im2,final_match_points);

% RANSAC to filter the match set
% find the homography and tranformation
% using affine2d and imwarp to transform im2 to the perspective of im1
