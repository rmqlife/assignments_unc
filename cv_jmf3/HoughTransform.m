function HoughTransform
% data prepare
[x,y] = Line2(100);

canvas = zeros(500,180);
phis = [];
vis_mat = [20;200];
for i = 1:size(x,1)
    for theta = 1:180
        phi = x(i)*cos(pi*theta/180) + y(i)* sin(pi*theta/180);
        phi = round([phi,1]*vis_mat); 
        phis = [phis;phi];
        canvas(phi,theta) = canvas(phi,theta) +1 ;
    end
end
figure;
imagesc(canvas);
% find the max
[~, ind] = max(canvas(:));
[phi,theta] = ind2sub(size(canvas),ind);
% transfer back
phi = (phi - vis_mat(2))/vis_mat(1);
% the line is phi = x * cos(theta) + y * sin(theta);
% m = -cos(theta)/sin(theta) 
% b = phi/sin(theta)
B = [-cot(theta*pi/180);phi/sin(theta*pi/180)];

figure;
plot(x,y,'r.'); hold;
plot(x,[x,ones(size(x))]*B,'b');