% Demo for movie
% mesh vs. increasing power
% increasing input length

for i=0:38
    [w,x,y]=poisson5(0,4,0,4,40,40,5,1.68,i);
    
    subplot(2,2,1)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([90 90])
    title('K=1.68 P=5')
    subplot(2,2,2)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([45 20])
    title(sprintf('Input Length =%0.5g cm',i/38*4))
    subplot(2,2,3)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([90 0])
        title(sprintf('Max Temp = %g',max(max(w))))
    subplot(2,2,4)
    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([180 0])
    drawnow;
end
