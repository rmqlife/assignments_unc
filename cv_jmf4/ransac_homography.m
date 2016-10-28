%ransac_homography
% choose 4 pairs of matches

max_match_count = 0;
max_H = zeros(3,3);
for repeat_times = 1:200
    inds = randi(size(match_set,1),[4,1]);
    inds1 = match_set(inds,1);
    inds2 = match_set(inds,2);
    samp_pt1 = pt1(inds1,:);
    samp_pt2 = pt2(inds2,:);

    A = [];
    for i=1:4
        row = homography_mat(samp_pt1(i,1),samp_pt1(i,2),samp_pt2(i,1),samp_pt2(i,2));
        A = [A;row];
    end
    % V:eigen vectors and D:eigenvalues
    [V,D] = eig(A'*A);
    % smallest
    H = reshape(V(:,1),[3,3])';

    match_count=0;
    for i = 1:size(match_set,1)
        i1 = match_set(i,1);
        i2 = match_set(i,2);
        pt1_project = (H*[pt1(i1,:),1]')';
        pt1_project = [pt1_project(1)/pt1_project(3),pt1_project(2)/pt1_project(3)]';
        project_dist = pdist2(pt1_project',pt2(i2,:));
        if project_dist<10
            match_count=match_count+1;
        end
    end
    % project 
    if match_count>max_match_count
        max_H = H;
        max_match_count = match_count;
    end;
end;

% show the match result
