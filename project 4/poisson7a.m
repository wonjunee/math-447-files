% Project 4: Problem 7 correct solution
%   with Dirichlet boundary conditions on a rectangle 
% Input: rectangle domain [xl,xr]x[yb,yt] with MxN space steps 
% Output: matrix w holding solution values 
function [w, x, y]=poisson7a(xl,xr,yb,yt,M,N,P,K,u,c)
f=@(x,y) 0; % define input function data 

H=.005; delta=.01; 

L=2;    %Initial Conditions Problem 1,2,3  poisson2(0,4,0,4,10,10,5,1.68) 

m=M+1;n=N+1; mn=m*n; 

h=(xr-xl)/M;h2=h^2;k=(yt-yb)/N;k2=k^2; 

x=xl+(0:M)*h; % set mesh values 
y=yb+(0:N)*k; 

A=zeros(mn,mn);b=zeros(mn,1); 

for i=2:m-1 % interior points 
  for j=2:n-1 
    A(i+(j-1)*m,i-1+(j-1)*m)=1/h2;A(i+(j-1)*m,i+1+(j-1)*m)=1/h2; 
    A(i+(j-1)*m,i+(j-1)*m)=-2/h2-2/k2-2*H/(K*delta); 
    A(i+(j-1)*m,i+(j-2)*m)=1/k2;A(i+(j-1)*m,i+j*m)=1/k2; 
    b(i+(j-1)*m)=f(x(i),y(j)); 
  end 
end 

for i=1:m % bottom and top boundary points 
  j=1;  % Bottom
  A(i+(j-1)*m,i+(j-1)*m)=-3/(2*k)+H/K;
  A(i+(j-1)*m,i+(j)*m)=2/k;
  A(i+(j-1)*m,i+(j+1)*m)=-1/(2*k);
  b(i+(j-1)*m)=0;
  
  j=n;  % Top
  A(i+(j-1)*m,i+(j-1)*m)=-3/(2*k)+H/K;
  A(i+(j-1)*m,i+(j-2)*m)=2/k;
  A(i+(j-1)*m,i+(j-3)*m)=-1/(2*k);
  b(i+(j-1)*m)=0; 
end
for j=2:n-1 % left and right boundary points 
   i=1;
   A(i+(j-1)*m,i+(j-1)*m)=-3/(2*h)+H/K;
   A(i+(j-1)*m,i+1+(j-1)*m)=2/h;
   A(i+(j-1)*m,i+2+(j-1)*m)=-1/(2*h);
   b(i+(j-1)*m)=0; 

  i=m;  % Right
  A(i+(j-1)*m,i+(j-1)*m)=-3/(2*h)+H/K;
  A(i+(j-1)*m,i-1+(j-1)*m)=2/h;
  A(i+(j-1)*m,i-2+(j-1)*m)=-1/(2*h);
  b(i+(j-1)*m)=0; 
  
end 

 %for j=2:n-1-2*floor(n/4)% power input location
for j=2+floor(n/4):n-1-floor(n/4)
  b(1+(j-1)*m)=-P/(L*delta*K); 

end 
%notch placement
for j=2+floor(c*n/26):m - floor((20-c)*n/26)
    for i=(floor(m*(u)/26)+1):(m - (floor(m*(20-u)/26)))
  
  A(i+(j-1)*m,i+1+(j-1)*m)=0;
  b(i+(j-1)*m)=0;
  
    end
end

v=A\b; % solve for solution in v labeling 
w=reshape(v(1:mn),m,n); %translate from v to w 

 mesh(x,y,w') 