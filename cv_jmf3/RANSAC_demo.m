function RANSAC_demo
% data generation
[x,y] = Line1(100);
[noisex,noisey] = NoisePoints(30);
x = [x;noisex];
y = [y;noisey];
figure;
plot(x,y,'r.');hold;

[B,error, x_inline, y_inline, N]=RANSAC(x,y);
plot(x_inline, y_inline, 'b.');
plot(x_inline, [x_inline,ones(size(x_inline))]*B, 'g');

error
B
N

repeat_times = 100;
result_mat = zeros(repeat_times,2+1+1);
for i = 1:repeat_times
    [B,error, ~, ~, N]=RANSAC(x,y);
    result_mat(i,:) = [B', error, N];
end

mean(result_mat)
var(result_mat)