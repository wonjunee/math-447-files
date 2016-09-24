% Project 3: Pendulum

mul=20;

inter=[0 20];
ic=[pi/2 0];
n=1000;

inter2=[0 20];
ic2=[pi/2 0];
n2=1000*mul;


h=(inter(2)-inter(1))/n;  % plot n points in total
y(1,:)=ic;                % enter initial conds in y
t(1)=inter(1);

h2=(inter2(2)-inter2(1))/n2;  % plot n points in total
y2(1,:)=ic2;                % enter initial conds in y
t2(1)=inter2(1);
   
    set(gca,'xlim',[-1.2 1.2],'ylim',[-1.2 1.2], ...
    'XTick',[-1 0 1],'YTick',[-1 0 1], ...
    'Drawmode','fast','Visible','on','NextPlot','add');
    cla;         
    axis square               % make aspect ratio 1 - 1
    bob = line('color','r','Marker','.','markersize',40,...
        'erase','xor','xdata',[],'ydata',[]);
    rod = line('color','b','LineStyle','-','LineWidth',3,...
        'erase','xor','xdata',[],'ydata',[]);
  
    bob2 = line('color','g','Marker','.','markersize',40,...
        'erase','xor','xdata',[],'ydata',[]);
    rod2 = line('color','b','LineStyle','-','LineWidth',3,...
        'erase','xor','xdata',[],'ydata',[]);
    
for k=1:n
     
  t(k+1)=t(k)+h;
  y(k+1,:)=trapstep(t(k),y(k,:),h);
  xbob(k) = sin(y(k+1,1)); ybob(k) = -cos(y(k+1,1));

end

for k=1:n2

  t2(k+1)=t2(k)+h2;
  y2(k+1,:)=trapstep(t2(k),y2(k,:),h2);
  xbob2(k) = sin(y2(k+1,1)); ybob2(k) = -cos(y2(k+1,1));

end

for k=1:n

  xrod = [0 xbob(k)]; yrod = [0 ybob(k)];
  set(rod,'xdata',xrod,'ydata',yrod)
  set(bob,'xdata',xbob(k),'ydata',ybob(k))
  xrod2 = [0 xbob2(mul*k)]; yrod2 = [0 ybob2(mul*k)];
  set(rod2,'xdata',xrod2,'ydata',yrod2)
  set(bob2,'xdata',xbob2(mul*k),'ydata',ybob2(mul*k))
  title('Red ball h=.02 Green ball h=.001')
  drawnow;pause(.01)

end