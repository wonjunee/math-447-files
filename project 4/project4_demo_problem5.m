%   Demo file for project 4 Math 447 Problem 5
%   Shows graph: K vs. maximum P
clear all

x=1:0.1:5;

cl=1;
for i=x
     thermalmax(cl)=project4bisect(0,20,.001,i); % project4bisect(a,b,tol,K) will provide the value of P where the maximum temp is 80.
     cl=cl+1;
end

plot(x,thermalmax);
title('K vs. maximum P where maximum temperature below 80 degrees')
xlabel('K')
ylabel('Maximum P where Max Temp < 80')