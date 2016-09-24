function out = functionone(theta,P2)
L1=3;L2=3*sqrt(2);L3=3;gamma=pi/4;p1=5;p2=P2;p3=3;
x1=5;x2=0;y2=6;
% L1=2;L2=sqrt(2);L3=sqrt(2);gamma=pi/2;p1=sqrt(5);p2=sqrt(5);p3=sqrt(5);
% x1=4;x2=0;y2=4;

A2=L3*cos(theta)-x1;
B2=L3*sin(theta);
A3=L2*(cos(theta)*cos(gamma) - sin(theta)*sin(gamma))-x2;
B3=L2*(cos(theta)*sin(gamma) + sin(theta)*cos(gamma))-y2;

N1 = B3.*(p2.^2 -p1.^2 -A2.^2 -B2.^2) - B2.*(p3.^2 - p1.^2 -A3.^2 - B3.^2);
N2 = -A3.*(p2.^2 - p1.^2 -A2.^2 - B2.^2) + A2.*(p3.^2 -p1.^2 -A3.^2 -B3.^2);
D = 2*(A2.*B3 - B2.*A3);

x = N1/D;y=N2/D;

u1 = x ;
v1 = y ;
u2 = x +L3*cos(theta);
v2 = y+L3*sin(theta);
u3 = x+L2*(cos(theta)*cos(gamma)-sin(theta)*sin(gamma));
v3 = y+L2*(sin(theta)*cos(gamma)+cos(theta)*sin(gamma));
plot([u1 u2 u3 u1], [v1 v2 v3 v1], 'r'); hold on
      plot([0 x1 x2], [0 0 y2],'bo')
      line([0 u1],[0 v1])
      line([x1 u2],[0 v2])
      line([x2 u3],[y2 v3])
      hold off
      str = sprintf('theta = %f',theta);
      title(str);
out = N1.^2 +N2.^2 -p1.^2*D.^2;