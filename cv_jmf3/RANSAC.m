function [B, error, x_inline, y_inline, N] = RANSAC(x,y)
N = 100;
sample_count = 0;
s = 2; % sample number
dist_thresh = sqrt(3.84*0.1^2);
while N>sample_count
    sample_count = sample_count + 1;
    % randomly sampling
    i = randi(size(x,1),s,1);
    x_sample = x(i);
    y_sample = y(i);
    % fit
    [B, ~] = leastSquare(x_sample, y_sample);
    % find the inliners' percent
    X = [x,ones(size(x))];
    dist_to_line = abs(X*B - y)/sqrt(B(1)^2 + 1);
    inliners_num = sum(dist_to_line<dist_thresh);
    e = 1 - inliners_num/size(x,1)-0.01;
    N = log(1-0.99)/log(1-(1-e)^s);
end

% using least square to fit the inliners
% inliners
i = find(dist_to_line<dist_thresh);
x_inline = x(i);
y_inline = y(i);
[B,error] = leastSquare(x_inline, y_inline);