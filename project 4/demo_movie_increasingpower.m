% Demo for movie
% mesh vs. increasing power
f=figure;
set(f,'Renderer','ZBuffer');
MakeQTMovie('start','project4444powersize.mov')
MakeQTMovie('framerate',10) %   controls frame rate
for i=1:.5:10
    [w,x,y]=poisson3(0,4,0,4,20,20,i,1.68);
    subplot(2,2,1)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([90 90])
    title('K=1.68')
    subplot(2,2,2)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([45 20])
    title(sprintf('P=%g',i))
    subplot(2,2,3)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([90 0])
    
    subplot(2,2,4)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([180 0])
    
    drawnow;
    MakeQTMovie('addfigure')
end

MakeQTMovie('finish')
