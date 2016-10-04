function RANSAC
% data generation
[x,y] = Line1(100);
[noisex,noisey] = NoisePoints(30);
x = [x;noisex];
y = [y;noisey];
figure;
plot(x,y,'r.');hold;

sample_num = 5; 
dist_thresh = 0.3; 
percent_thresh = 0.7;
run_times = 100;
show_fag = 0;
for r = 1:run_times
    % randomly sampling
    i = randi(size(x,1),sample_num,1);
    x_sample = x(i);
    y_sample = y(i);
    % fit
    [B, error] = leastSquare(x_sample, y_sample);
    % find the inliners' percent
    X = [x,ones(size(x))];
    dist_to_line = abs(X*B - y)/sqrt(B(1)^2 + 1);
    inliners_num = sum(dist_to_line<dist_thresh);
    percent = inliners_num/size(x,1);
    if percent > percent_thresh
        % show the fit
        % plot(x_sample, y_sample, 'b.');
        % plot(x, [x,ones(size(x))]*B, 'g');
        break;
    end
end

% using least square to fit the inliners
% inliners
i = find(dist_to_line<dist_thresh);
x_inline = x(i);
y_inline = y(i);
[B,~] = leastSquare(x_inline, y_inline);
plot(x_inline, y_inline, 'b.');
plot(x_inline, [x_inline,ones(size(x_inline))]*B, 'g');