function [y,x,feature] = naive_corner_nms(im)

I = double(im);
Ix = conv2(I,[1,0,-1],'same');
Iy = conv2(I,[1,0,-1]','same');

Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;

k = fspecial('gaussian',[7,7],2);
Ix2 = filter2(k,Ix2);
Iy2 = filter2(k,Iy2);
Ixy = filter2(k,Ixy);

% corner response 
R = zeros(size(I));
alpha = 0.05; % from 0.04 to 0.06
feature = cell(size(I));
for i = 1:size(I,1)
    for j = 1:size(I,2)
        M = [Ix2(i,j), Ixy(i,j); Ixy(i,j), Iy2(i,j)];
        R(i,j) = det(M) - alpha*trace(M)^2;
        % M feature vector
        Mf = M(:);
        feature{i,j} = Mf;
    end
end

[val,ind] = sort(R(:),'descend'); 
ind = ind(1:1000);
val = R(ind);
[x,y] = ind2sub(size(R),ind);
result = [val,x,y];

radius = 10;
selected = result(1,:);
for i=2:size(val,1)
    % point distance is bigger than the radius
    if min(pdist2(result(i,2:3),selected(:,2:3)))>radius
        % add to selected
        selected = [selected;result(i,:)];
    end;
end

x = selected(:,2);
y = selected(:,3);
ind = sub2ind(size(R),x,y);
feature_selected = feature(ind);
feature = feature_selected;