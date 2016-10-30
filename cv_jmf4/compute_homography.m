function H = compute_homography(match_points)
% assume the match_points are correct
% compute the homography with the sample points pairs
A = [];
for i=1:size(match_points,1)
    row = homography_mat(match_points(i,1),match_points(i,2),match_points(i,3),match_points(i,4));
    A = [A;row];
end
% V:eigen vectors and D:eigenvalues
[V,D] = eig(A'*A);
% homography transformation matrix
H = reshape(V(:,1),[3,3])';