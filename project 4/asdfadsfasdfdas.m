%   Demo file for project 4 Math 447 Problem 4
%   Shows graph: power vs. maximum
clear all
x=1:0.1:20;
cl=1;
for i=x
     [w,~,~]=poisson3(0,4,0,4,10,10,i,1.68); % poisson2(xl,xr,yb,yt,M,N,P,K) 
     thermalmax(cl)=max(max(w));
     cl=cl+1;
end
plot(x,thermalmax);
xlabel('Power')
ylabel('Maximum Temperature')
title('Power vs. Max Temp')
hold on
axis([1 20 0 250])
% x=linspace(1,20);



x=1:0.1:20;
cl=1;
for i=x
     [w,~,~]=poisson3(0,4,0,4,10,10,i,3.85); % poisson2(xl,xr,yb,yt,M,N,P,K) 
     thermalmax(cl)=max(max(w));
     cl=cl+1;
end
plot(x,thermalmax,'r');
plot(x,80,'--b')
axis([1 20 0 250])
legend('K = 1.68','K = 3.85')
hold off