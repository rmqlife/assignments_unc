imset = {'im1.pgm','im2.pgm','im3.pgm','im4.pgm','im5.pgm','im6.pgm'};

for i = 1:length(imset)
    imset{i}
    im = imread(['wall/',imset{i}]);
    %pt = naive_corner(im);
    pt = naive_corner_nms(im);
    figure,imshow(im);
    hold on;
    plot(pt(:,2),pt(:,1),'ro');
    hold off;
end