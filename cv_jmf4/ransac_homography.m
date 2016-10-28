function [final_match_points,H] = ransac_homography(match_points)
% ransac_homography
% choose 4 pairs of matches
max_match_count = 0;
max_H = zeros(3,3);
for repeat_times = 1:200
    % sample at least 4 points to compute the homography
    inds = randi(size(match_points,1),[4,1]);
    samp_pts = match_points(inds,:);
    % compute the homography with the sample points pairs
    A = [];
    for i=1:4
        row = homography_mat(samp_pts(i,1),samp_pts(i,2),samp_pts(i,3),samp_pts(i,4));
        A = [A;row];
    end
    % V:eigen vectors and D:eigenvalues
    [V,D] = eig(A'*A);
    % homography transformation matrix
    H = reshape(V(:,1),[3,3])';
    
    % validate the result with all the data
    match_count=0;
    for i = 1:size(match_points,1)
        pt1_project = (H*[match_points(i,1:2),1]')';
        pt1_project = [pt1_project(1)/pt1_project(3),pt1_project(2)/pt1_project(3)]';
        project_dist = pdist2(pt1_project',match_points(i,3:4));
        if project_dist<10
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
H = max_H;
