function im = bayer_pattern(im)
[h,w] = size(im);
% separate the different channel by masks
rmask = uint8(zeros(h,w));
bmask = rmask;
gmask = rmask;
rmask(1:2:end, 1:2:end) = 1;
bmask(2:2:end, 2:2:end) = 1;
gmask(1:2:end, 2:2:end) = 1;
gmask(2:2:end, 1:2:end) = 1;
rim = rmask.*im;
bim = bmask.*im;
gim = gmask.*im;

% debug part
% direct = cat(3, rim, gim, bim);
% imshow(direct);
% imwrite(direct,'crayons_direct.bmp');

% filter by each channel.
rfilter = [0.25,0.5,0.25; 0.5,1,0.5; 0.25,0.5,0.25];
bfilter = rfilter;
gfilter = [0,0.25,0; 0.25,1,0.25; 0, 0.25, 0];
rim = imfilter(rim, rfilter);
bim = imfilter(bim, bfilter);
gim = imfilter(gim, gfilter);
% add three channel
im = cat(3, rim, gim, bim);
