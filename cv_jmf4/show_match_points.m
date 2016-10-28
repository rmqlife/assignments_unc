function show_match_points(im1,im2,match_points)
% show corners
imshow([im1,im2]); hold on;
for i=1:size(match_points,1)
   plot(match_points(i,2),match_points(i,1),'ro');
   plot(match_points(i,4)+size(im1,2),match_points(i,3),'bo');
   plot([match_points(i,2),match_points(i,4)+size(im1,2)],[match_points(i,1),match_points(i,3)],'g-');
end