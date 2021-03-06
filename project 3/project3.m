% Program 6.3 Animation program for pendulum
% Forced Dampled pendulum
function movie=project3(inter,ic,n,on_off,makemovie) %on_off 1=turn on movie 0=turn off

MakeQTMovie('start','pro6unstable.mov')
MakeQTMovie('framerate',60)

h=(inter(2)-inter(1))/n;  % plot n points in total
y(1,:)=ic;                % enter initial conds in y
t(1)=inter(1);
if on_off==1
    subplot(1,3,1)
    set(gca,'xlim',[-1.2 1.2],'ylim',[-1.2 1.2], ...
    'XTick',[-1 0 1],'YTick',[-1 0 1], ...
    'Drawmode','fast','Visible','on','NextPlot','add');
    cla;         
    axis square               % make aspect ratio 1 - 1
    bob = line('color','r','Marker','.','markersize',40,...
        'erase','xor','xdata',[],'ydata',[]);
    rod = line('color','b','LineStyle','-','LineWidth',3,...
        'erase','xor','xdata',[],'ydata',[]);
    
end

if makemovie==1
movie=zeros(200,200,n);
end

for k=1:n
  
  t(k+1)=t(k)+h;
  y(k+1,:)=trapstep(t(k),y(k,:),h);
  
  
  xbob = sin(y(k+1,1)); ybob = -cos(y(k+1,1));
  xrod = [0 xbob]; yrod = [0 ybob];

  xxx(k) = sin(y(k+1,1)) ; %add +2 or something to show in the same figure
  yyy(k) = -cos(y(k+1,1)) ;
  
  if on_off==1
%         if mod(k,5)==0

        
        set(rod,'xdata',xrod,'ydata',yrod)
        set(bob,'xdata',xbob,'ydata',ybob)
        drawnow; %pause(h/100)
        title('A=15 (Chaotic motion)')
        
        subplot(1,3,2:3)
        plot(xxx,'b');
        axis([0 1000 -1.2 1.2])
%         hold on
%         plot(yyy,'b');
%         hold off
        title(sprintf('theta: %f',ic(1)))
        legend('x')
        
%         end
  end
  
  if makemovie==1
  movie(floor(101+100*xbob),floor(101+100*ybob),k)=1;
  end
  
  MakeQTMovie('addfigure')
  
end

MakeQTMovie('finish')




function y = trapstep(t,x,h)
%one step of the Trapezoid Method
z1=ydot(t,x);
g=x+h*z1;
z2=ydot(t+h,g);
y=x+h*(z1+z2)/2;

function z=ydot(t,y)
g=9.81;length=1;d=1;A=15;
z(1) = y(2);
z(2) = -(g/length)*sin(y(1))-d*y(2)+A*sin(t);