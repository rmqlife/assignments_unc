im = imread('wall/im1.pgm');
pt = naive_corner(im);
imshow(im);
hold on;
plot(pt(:,2),pt(:,1),'ro');
