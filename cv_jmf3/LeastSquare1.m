function LeastSquare1
figure;
% data generation
[x,y] = Line1(100);
plot(x,y,'r.');hold;
repeat = 100;
B_mat = zeros(repeat,2);
for i=1:100
    [x,y] = Line1(100);
    [B, residual_error] = leastSquare(x,y);
    B_mat(i,:) = B;
end

mean(B_mat)
var(B_mat)
% plot the fitted line
plot(x,[x,ones(size(x))]*B,'b');
% residual error : the sum of the squared distances of the points to the line.
residual_error
