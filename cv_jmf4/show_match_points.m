function show_match_points(im1,im2,match_points)
% show corners
if size(im1,1) > size(im2,1)
    bg = zeros(size(im1,1),size(im2,2));
    bg(1:size(im2,1),1:size(im2,2)) = im2(:,:);
    im2 = bg;
elseif size(im1,1) < size(im2,1)
    bg = zeros(size(im2,1),size(im1,2));
    bg(1:size(im1,1),1:size(im1,2)) = im1(:,:);
    im1 = bg;
end
imshow([im1,im2]); hold on;
for i=1:size(match_points,1)
   plot(match_points(i,2),match_points(i,1),'ro');
   plot(match_points(i,4)+size(im1,2),match_points(i,3),'bo');
   plot([match_points(i,2),match_points(i,4)+size(im1,2)],[match_points(i,1),match_points(i,3)],'g-');
end