%Project 3 problem 6: finding the value of A where inverted pendulum becomes stable.
%Computes approximate solution of stablized inverted pendulum
%Input: inline function f; a,b such that f(a)*f(b)<0, 
%     and tolerance tol
%Output: Approximate solution xc
function xc = project4bisect(a,b,tol,K)
if sign(func(a,K))*sign(func(b,K)) >= 0
  error('f(a)f(b)<0 not satisfied!') %ceases execution
end
fa=func(a,K);
fb=func(b,K);
k = 0;
while (b-a)/2>tol
  c=(a+b)/2;
  fc=func(c,K);
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

function pn = func(power,K)

% [w,~,~]=poisson3(0,4,0,4,10,10,power,3.85); % Problem 4
[w,~,~]=poisson3(0,4,0,4,30,30,power,K); % Problem 5


maxi=max(max(w));

if maxi>60
    pn=-1;
else
    pn=1;
end
 
%   Note

% poisson2(0,4,0,4,10,10,power, 3.85); H=.005; K=3.85; delta=.01; L=2; Answer: 1.194624410926402
