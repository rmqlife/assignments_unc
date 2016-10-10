function B_mat = houghTransform(x,y,thresh,show_fag)
canvas = zeros(500,180);
phis = [];
vis_mat = [10;200];
for i = 1:size(x,1)
    for theta = 1:180
        phi = x(i)*cos(pi*theta/180) + y(i)* sin(pi*theta/180);
        phi = round([phi,1]*vis_mat); 
        phis = [phis;phi];
        canvas(phi,theta) = canvas(phi,theta) +1 ;
    end
end
if show_fag
    figure;
    imagesc(canvas);
end

B_mat = [];
while 1
    % find the max
    [val,ind] = max(canvas(:));
    if val<thresh
        break;
    end
    [phi,theta] = ind2sub(size(canvas),ind);
    for i = phi-5:phi+5
        for j = theta-5:theta+5
            canvas(i,j) = 0;
        end
    end
    % transfer back
    phi = (phi - vis_mat(2))./vis_mat(1);
    % the line is phi = x * cos(theta) + y * sin(theta);
    % m = -cos(theta)/sin(theta) 
    % b = phi/sin(theta)
    B = [-cot(theta*pi/180);phi./sin(theta*pi/180)];
    B_mat = [B_mat,B];
end

