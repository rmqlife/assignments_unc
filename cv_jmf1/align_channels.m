function [aligned_im2,align_vector] = align_channels(im1, im2, sd)
% im1 is the image stay still
% im2 is the image to be shifted and align to im1
% sd is the shift distance range
edge1 = edge(im1,'Canny');
edge2 = edge(im2,'Canny');

% edge1 is the edge image stay still
% edge2 is the edge image to be shifted
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

align_vector = [h,w];
aligned_im2 = circshift(im2, [h,w]);
return


