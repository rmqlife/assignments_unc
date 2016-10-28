clc; clear; close all;
im1 = imread('wall\im1.pgm');
im2 = imread('wall\im2.pgm');
% naive method for corner detection
pt1 = naive_corner_nms(im1);
pt2 = naive_corner_nms(im2);
% show corners
imshow([im1,im2]); hold on;
%plot(pt1(:,2),pt1(:,1),'ro');
%plot(size(im1,2)+pt2(:,2),pt2(:,1),'bo');

%feature descriptor
feat1 = feature_descriptor(im1,pt1,20,5);
feat2 = feature_descriptor(im2,pt2,20,5);

feature_distance_map = zeros(size(feat1,1),size(feat2,1));

% match feature
% match map
if 0
    for i = 1:size(feat1,1)
        for j =1:size(feat2,1)
            feature_distance_map(i,j) = pdist2(feat1(i,:),feat2(j,:));
        end
    end
    figure,imagesc(feature_distance_map);
end

% brute match
match_set = zeros(size(pt1,1),2);
for i = 1:size(feat1,1)
   [val,ind] = min(pdist2(feat1(i,:),feat2));
   %pt1(i,:),pt2(ind,:)
   plot(pt1(i,2),pt1(i,1),'ro');
   plot(pt2(ind,2)+size(im1,2),pt2(ind,1),'bo');
   plot([pt1(i,2),pt2(ind,2)+size(im1,2)],[pt1(i,1),pt2(ind,1)],'g-');
   match_set(i,:) = [i,ind];
end

% RANSAC to filter the match set
% find the homography and tranformation


