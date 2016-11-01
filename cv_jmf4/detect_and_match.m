function match_points = detect_and_match(im1,im2)
% naive method for corner detection
pt1 = naive_corner_nms(im1);
pt2 = naive_corner_nms(im2);
%feature descriptor
feat1 = feature_descriptor(im1,pt1,15,5);
feat2 = feature_descriptor(im2,pt2,15,5);

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
match_points = zeros(size(pt1,1),4);
for i = 1:size(feat1,1)
   [val,ind] = min(pdist2(feat1(i,:),feat2));
   match_points(i,:)=[pt1(i,:),pt2(ind,:)];
end
