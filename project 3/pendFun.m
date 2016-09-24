% Program 6.3 Animation program for pendulum
% Inputs: time interval inter,
%  initial values ic = [y(1,1) y(1,2)], number of steps n
% Calls a one-step method such as trapstep.m
% Example usage: pend([0 10],[pi/2 0],200)
function pendFun(inter,ic,n)
h=(inter(2)-inter(1))/n;  % plot n points in total
y(1,:)=ic;                % enter initial conds in y
t(1)=inter(1);
set(gca,'xlim',[-2.4 2.4],'ylim',[-2.4 2.4], ...
  'XTick',[-1 0 1],'YTick',[-1 0 1], ...
  'Drawmode','fast','Visible','on','NextPlot','add');
cla;         
axis square               % make aspect ratio 1 - 1
bob1 = line('color','r','Marker','.','markersize',40,...
    'erase','xor','xdata',[],'ydata',[]);
rod1 = line('color','b','LineStyle','-','LineWidth',3,...
    'erase','xor','xdata',[],'ydata',[]);
bob2 = line('color','r','Marker','.','markersize',40,...
    'erase','xor','xdata',[],'ydata',[]);
rod2 = line('color','b','LineStyle','-','LineWidth',3,...
    'erase','xor','xdata',[],'ydata',[]);
for k=1:n
  t(k+1)=t(k)+h;
  y(k+1,:)=trapstep(t(k),y(k,:),h);
  xbob1 = sin(y(k+1,1)); ybob1 = -cos(y(k+1,1));
  xrod1 = [0 xbob1]; yrod1 = [0 ybob1];
  xbob2 = xbob1 + sin(y(k+1,3)); ybob2 = ybob1 + -cos(y(k+1,3));
  xrod2 = [xbob1 xbob2]; yrod2 = [ybob1 ybob2];
  
  subplot(1,2,1)
  
  set(rod1,'xdata',xrod1,'ydata',yrod1)
  set(bob1,'xdata',xbob1,'ydata',ybob1)
  set(rod2,'xdata',xrod2,'ydata',yrod2)
  set(bob2,'xdata',xbob2,'ydata',ybob2)
  
  subplot(1,2,2)
  
 xxx(k) = y(k+1,1);
 yyy(k) = y(k+1,2);
 plot(xxx,yyy,'g');
 
  drawnow; %pause(h)
end

function y = trapstep(t,x,h)
%one step of the Trapezoid Method
z1=ydot(t,x);
g=x+h*z1;
z2=ydot(t+h,g);
y=x+h*(z1+z2)/2;

function z=ydot(t,y)
g=9.81;length=1;A=3;
%z(1) = y(2);
%z(2) = -(g/length)*sin(y(1));
d = 1.2;
z(1) = y(2);
z(2) = (-3*g*sin(y(1)) - g*sin(y(1) - 2*y(3)) - 2*sin(y(1) - y(3))*(y(4)^2 - (y(2)^2)*cos(y(1) - y(3))))  /  (3 - cos(2*y(1) - 2*y(3)))  -  d*y(2)+A*sin(t);
z(3) = y(4);
z(4) = (2*sin(y(1) - y(3))*(2*y(2)^2 + 2*g*cos(y(1)) + (y(4)^2)*cos(y(1)-y(3)))) / (3 - cos(2*y(1) - 2*y(3)));