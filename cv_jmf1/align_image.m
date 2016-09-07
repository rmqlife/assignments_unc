function im2 = align_image(im1, im2)
% im1 is the image stay still
% im2 is the image to be shifted and align to im1
edge1 = edge(im1, 'Canny');
edge2 = edge(im2, 'Canny');

% Add dilate image processing for the weak edge extraction
%SE = strel('square',2);
%edge1 = imdilate(edge1,SE);
%edge2 = imdilate(edge2,SE);

% edge1 is the edge image stay still
% edge2 is the edge image to be shifted
sd = 10;
sd_mat = zeros(sd*2+1);

for i = -sd:sd
    for j = -sd:sd
        edge_shift = circshift(edge2,[i,j]);
        add_edge = edge_shift & edge1;
        sd_mat(i+sd+1,j+sd+1) = sum(sum(add_edge));
    end
end

max_add = max(max(sd_mat));
[h,w] = find(sd_mat==max_add);
h = h(1)-sd-1;
w = w(1)-sd-1;

im2 = circshift(im2,[h,w]);
% for debug
%edge_shift = circshift(g_edge, [h,w]);
%imshow(edge_shift & r_edge);
return


