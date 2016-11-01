function [H,final_match_points] = ransac_homography(match_points)
% ransac_homography
% choose 4 pairs of matches
max_match_count = 0;
max_H = zeros(3,3);
sample_num = 4;
for repeat_times = 1:500
    % sample at least 4 points to compute the homography
    inds = randi(size(match_points,1),[sample_num,1]);
    samp_pts = match_points(inds,:);
    H = compute_homography(samp_pts);
    
    % validate the result with all the data
    match_count=0;
    for i = 1:size(match_points,1)
        pt1_project = (H*[match_points(i,1:2),1]')';
        pt1_project = [pt1_project(1)/pt1_project(3),pt1_project(2)/pt1_project(3)]';
        project_dist = pdist2(pt1_project',match_points(i,3:4));
        if project_dist<3
            match_count=match_count+1;
        end
    end
    % record the max match result 
    if match_count>max_match_count
        max_H = H;
        max_match_count = match_count;
    end;
end;

final_match_points = [];
% show the match result
for i = 1:size(match_points,1)
    pt1_project = (max_H*[match_points(i,1:2),1]')';
    pt1_project = [pt1_project(1)/pt1_project(3),pt1_project(2)/pt1_project(3)]';
    project_dist = pdist2(pt1_project',match_points(i,3:4));
    if project_dist<10
        final_match_points = [final_match_points;match_points(i,:)];
    end
end
H = max_H; % compute_homography(final_match_points);