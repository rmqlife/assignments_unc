function shift_add_images(im1,im2,shift_vector)
sv = shift_vector;
% 0 0 + sv
if sv(1)>0
    % move im1 downward
    im1 = shift_with_margin(im1,[sv(1),0]);
else
    im2 = shift_with_margin(im2,[-sv(1),0]);
end
if sv(2)>0
    im1 = shift_with_margin(im1,[0,sv(2)]);
else
    im2 = shift_with_margin(im2,[0,-sv(2)]);
end

% match each other's size, add with zeros

margin_vector = size(im2)-size(im1);
mv = margin_vector;
if mv(1)>0
    im1 = add_with_margin(im1,[mv(1),0]);
else
    im2 = add_with_margin(im2,[-mv(1),0]);
end
if mv(2)>0
    im1 = add_with_margin(im1,[0,mv(2)]);
else
    im2 = add_with_margin(im2,[0,-mv(2)]);
end

im1 = im1.*uint8((im2==0));
figure, imshow(im1+im2);
    