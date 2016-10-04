function LeastSquare2
% data generation
[x,y] = Line1(100);
[noisex,noisey] = NoisePoints(30);
x = [x;noisex];
y = [y;noisey];
figure;
plot(x,y,'r.');hold;
[B, residual_error] = leastSquare(x,y); 
residual_error
% plot the fitted line
plot(x,[x,ones(size(x))]*B,'b');
% residual error : the sum of the squared distances of the points to the line.
