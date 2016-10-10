function HoughTransform_demo
% line1
[x,y] = Line1(100);
B_h = HoughTransform(x,y,40,0)
B_ls = leastSquare(x,y)
figure;
plot(x,y,'r.'); hold;
plot(x,[x,ones(size(x))]*B_h,'b');
plot(x,[x,ones(size(x))]*B_ls,'g');

% line2
[x2,y2] = Line2(100);
x = [x;x2];
y = [y;y2];
B_h = HoughTransform(x,y,40,1)
B_ls = leastSquare(x,y)
figure;
plot(x,y,'r.'); hold;
for i = 1:size(B_h,2)
    plot(x,[x,ones(size(x))]*B_h(:,i),'b');
end
plot(x,[x,ones(size(x))]*B_ls,'g');