function HoughTransform_demo
% line1
[x,y] = Line1(100);
B_h = houghTransform(x,y,0)
B_ls = leastSquare(x,y)
figure;
plot(x,y,'r.'); hold;
plot(x,[x,ones(size(x))]*B_h,'b');
plot(x,[x,ones(size(x))]*B_ls,'g');

% line2
[x,y] = Line2(100);
B_h = houghTransform(x,y,0)
B_ls = leastSquare(x,y)
figure;
plot(x,y,'r.'); hold;
plot(x,[x,ones(size(x))]*B_h,'b');
plot(x,[x,ones(size(x))]*B_ls,'g');