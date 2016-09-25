% Project 2 Part 1

%--------------------------------------------------------------------------
%                             Define values
%--------------------------------------------------------------------------

c=299792.458;

x = 0;
y = 0;
z = 6370;
d = 0;

A1=15600 ;B1=7540 ;C1=20140 ;t1=0.07074 ;
A2=18760 ;B2=2750 ;C2=18610 ;t2=0.07220 ;
A3=17610 ;B3=14630 ;C3=13480 ;t3=0.07690 ;
A4=19170 ;B4=610 ;C4=18390 ;t4=0.07242 ;




%--------------------------------------------------------------------------
%                      Multivariate Newton's Method
%--------------------------------------------------------------------------

num=2;     % the number of times Newton's method will be run

for i=1:num
 
F1 = ((x-A1)^2+(y-B1)^2+(z-C1)^2)-(c*(t1-d))^2;
F2 = ((x-A2)^2+(y-B2)^2+(z-C2)^2)-(c*(t2-d))^2;
F3 = ((x-A3)^2+(y-B3)^2+(z-C3)^2)-(c*(t3-d))^2;
F4 = ((x-A4)^2+(y-B4)^2+(z-C4)^2)-(c*(t4-d))^2;

Re = [2*(x-A1), 2*(y-B1), 2*(z-C1), 2*(c*(t1-d))*c, 1, 0, 0, 0;...
      2*(x-A2), 2*(y-B2), 2*(z-C2), 2*(c*(t2-d))*c, 0, 1, 0, 0;...
      2*(x-A3), 2*(y-B3), 2*(z-C3), 2*(c*(t3-d))*c, 0, 0, 1, 0;...
      2*(x-A4), 2*(y-B4), 2*(z-C4), 2*(c*(t4-d))*c, 0, 0, 0, 1];

%-----------------------Gaussian Elimination-------------------------------
  
for col=1:3;
    for row=1+col:4;
        Re(col,:)=Re(col,:)./Re(col,col);
        Re(row,:)=Re(row,:) - Re(row,col)*Re(col,:);
    end
end

Re(4,:)=Re(4,:)/Re(4,4);

for col=4:-1:2
    for row=col-1:-1:1
        Re(row,:)=Re(row,:)-Re(row,col)*Re(col,:);
    end
end

%--------------------------------------------------------------------------


Rinv=Re(:,5:8);

v = [x,y,z,d]' - Rinv*[F1,F2,F3,F4]';

% outputs from Newton's Method

x=v(1)
y=v(2)
z=v(3)
d=v(4)
   
end