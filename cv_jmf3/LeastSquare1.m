function LeastSquare1
figure;
% data generation
[x,y] = Line1(100);
plot(x,y,'r.');hold;
[B, residual_error] = leastSquare(x,y); 
% plot the fitted line
plot(x,[x,ones(size(x))]*B,'b');
% residual error : the sum of the squared distances of the points to the line.
residual_error