function [x,y] = Line1(L)
% L1
x = rand(L,1)*10;
y = 3 - x;
noise = normrnd(0,0.1,L,1);
y = noise + y;
