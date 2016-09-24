% Demo for movie
% mesh vs. increasing power

for i=.1:.1:5
    [w,x,y]=poisson7(0,4,0,4,20,20,i,1.68);
    subplot(2,2,1)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([90 90])
    
    subplot(2,2,2)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    
    subplot(2,2,3)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([90 0])
    
    subplot(2,2,4)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([180 0])
    drawnow;
end
