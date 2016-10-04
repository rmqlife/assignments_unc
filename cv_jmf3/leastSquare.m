function [B,residual_error] = leastSquare(x,y)
X = [x,ones(size(x))];
B = (X'*X)^-1 * X' * y;
residual_error = sum(abs(X*B - y))/sqrt(B(1)^2 + 1);
