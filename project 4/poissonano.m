% Program 8.5 Finite difference solver for 2D Poisson equation 
%   with Dirichlet boundary conditions on a rectangle 
% Input: rectangle domain [xl,xr]x[yb,yt] with MxN space steps 
% Output: matrix w holding solution values 
% Example usage: w=poisson2(0,1,1,2,4,4,5) 
function w=poissonano(xl,xr,yb,yt,M,N,Power) 
d = .1; %fin width in mm
H = .005; %W/cm^2 C, convective heat transfer coefficient
K = 1.68; %W/cm C, thermal conductivity
L = 2; %fin length in cm
P = Power; %power in watts
m=M+1;
n=N+1; 
mn=m*n; 
h=(xr-xl)/M;
h2=h^2;
k=(yt-yb)/N;
k2=k^2; 
x=xl+(0:M)*h; % set mesh values 
y=yb+(0:N)*k; 
A=zeros(mn,mn);b=zeros(mn,1); 
F = 2*H/(K*d);
 
%interior points
for i=2:m-1 
  for j=2:n-1
    A(i+(j-1)*m,i-1+(j-1)*m)=1/h2;
    A(i+(j-1)*m,i+1+(j-1)*m)=1/h2; 
    A(i+(j-1)*m,i+(j-1)*m)=(-2/h2-2/k2)-F; 
    A(i+(j-1)*m,i+(j-2)*m)=1/k2;
    A(i+(j-1)*m,i+j*m)=1/k2; 
    
    b(i+(j-1)*m)=0; 
  end 
end 
%end interior points

for i=1:m % bottom
   A(i,i) = -3 / (2*k) + (H/K);
   A(i,i+m) = 4 / (2*k);
   A(i,i+2*m) = -1 / (2*k);

   b(i+(n-1)*m) = 0;
end;

for i=1:m % top                     
   A(i+(n-1)*m,i+(n-1)*m) = -3 / (2*k) + (H/K);
   A(i+(n-1)*m,i+(n-2)*m) = 4 / (2*k);
   A(i+(n-1)*m,i+(n-3)*m) = -1 / (2*k);

   b(i+(n-1)*m) = 0;
end

for j=2:n-1   %left
    A(1+(j-1)*m,1+(j-1)*m) = -3 / (2*h);
    A(1+(j-1)*m,2+(j-1)*m) = 4 / (2*h);
    A(1+(j-1)*m,3+(j-1)*m) = -1 / (2*h);                                     
                
    b(1+(j-1)*m) = -P / (L * d * K);
end;

for j=2:n-1%right
    A(m+(j-1)*m,m+(j-1)*m) = -3 / (2*h) + (H/K);
    A(m+(j-1)*m,m-1+(j-1)*m) = 4 / (2*h);
    A(m+(j-1)*m,m-2+(j-1)*m) = -1 / (2*h);

    b(m+(j-1)*m) =  0;
end;

v=A\b; % solve for solution in v labeling 
w=reshape(v(1:mn),m,n); %translate from v to w 
subplot(1,2,1)
mesh(x,y,w')
view([45 20])

%notch
%a notch at 1/3rd of the way down to 1/3rd of the way up
p = floor((n-1)/3);
p2 = p*2;

for i=p2:m;
  for j=2+p:2+p2
    A(i+(j-1)*m,i+(j-1)*m)= 0;
    b(i+(j-1)*m) = 0;
  end 
end 

v=A\b; % solve for solution in v labeling 
w=reshape(v(1:mn),m,n); %translate from v to w 
subplot(1,2,2)
mesh(x,y,w') 
view([45 20])