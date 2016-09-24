%Project 3 problem 6: finding the value of A where inverted pendulum becomes stable.
%Computes approximate solution of stablized inverted pendulum
%Input: inline function f; a,b such that f(a)*f(b)<0, 
%     and tolerance tol
%Output: Approximate solution xc
function xc = bisectpend(a,b,tol)
if sign(func(a))*sign(func(b)) >= 0
  error('f(a)f(b)<0 not satisfied!') %ceases execution
end
fa=func(a);
fb=func(b);
k = 0;
while (b-a)/2>tol
  c=(a+b)/2;
  fc=func(c);
  if fc == 0              %c is a solution, done
    break
  end
  if sign(fc)*sign(fa)<0  %a and c make the new interval
    b=c;fb=fc;
  else                    %c and b make the new interval
    a=c;fa=fc;
  end
end
xc=(a+b)/2;               %new midpoint is best estimate

function pn = func(theta)

A=oscillatingpivot([0 30],[3.1 0],2000,theta,0,1);

[~,~,time]=size(A);
pn=1;
for i=1:time
    if A(2,1,i)==1
        pn=-1;
        break
    end
end
 

