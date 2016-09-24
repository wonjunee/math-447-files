% Project 3 problem 6
% Forced Dampled pendulum with oscillating pivot
function movie=oscillatingpivot(inter,ic,n,force,on_off,makemovie) %on_off 1=turn on movie 0=turn off

%--------------------------------------------------------------------------
%                            Make QT file
%--------------------------------------------------------------------------

% filename = 'errorgraph.gif';

%--------------------------------------------------------------------------
%                           Initial Condition
%--------------------------------------------------------------------------

A=force;
h=(inter(2)-inter(1))/n;  % plot n points in total
y(1,:)=ic;                % enter initial conds in y
t(1)=inter(1);
if on_off==1
    figure(1)
    subplot(1,2,1)
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
movie=zeros(4,4,n);
mov=zeros(4,4,n);
end

for k=1:n
  t(k+1)=t(k)+h;
  y(k+1,:)=trapstep(t(k),y(k,:),h,force);
  xbob = sin(y(k+1,1)); ybob = -cos(y(k+1,1));
  xrod = [0 xbob]; yrod = [0 ybob];
  
      
        if makemovie==1
    
            movie(floor(3+2*xbob),floor(3+2*ybob),k)=1;
            mov(floor(3+2*ybob),floor(3+2*xbob),k)=1;
%             subplot(1,2,2)
%             colormap(gray)
%             imagesc(flipud(mov(:,:,k)))
        end
        
    if on_off==1
        set(rod,'xdata',xrod,'ydata',yrod)
        set(bob,'xdata',xbob,'ydata',ybob)
        drawnow; % pause(h/100)
        
%         frame = getframe(1);
%         im = frame2im(frame);
%      [imind,cm] = rgb2ind(im,256);
%         if k == 1;
%             imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
%         else
%            imwrite(imind,cm,filename,'gif','WriteMode','append');
%       end
        
end


end


function y = trapstep(t,x,h,force)
%one step of the Trapezoid Method
z1=ydot(t,x,force);
g=x+h*z1;
z2=ydot(t+h,g,force);
y=x+h*(z1+z2)/2;

function z=ydot(t,y,A)
g=9.81;length=2.5;d=.1;  
z(1) = y(2);
z(2) = -(g/length+A*cos(2*pi*t))*sin(y(1))-d*y(2);


% 26.232441073827260 is an upper bound, 18.321388046911338 lower bound 
% when oscillatingpivot([0 30],[pi*.99 0],2000,19,0,1);

% 25.677509645001138 and 18.333816137413876
% when oscillatingpivot([0 30],[3.1 0],2000,theta,0,1)