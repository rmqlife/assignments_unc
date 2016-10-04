function [x,y] = Line2(L)
% L1
x = rand(L,1)*10;
y = x - 3;
noise = normrnd(0,0.1,L,1);
y = noise + y;
