% Demo for movie
% mesh vs. increasing K

for i=1:.02:5
    [w,x,y]=poisson3(0,4,0,4,20,20,5,i);
    
    subplot(2,2,1)
    mesh(x,y,w')
    axis([0 4 0 4 0 80])
    view([90 90])
    title('P = 5 W')
    subplot(2,2,2)
    mesh(x,y,w')
    axis([0 4 0 4 0 80])
    view([45 20])
    title(sprintf('K =%0.5g',i))
    subplot(2,2,3)
    mesh(x,y,w')
    axis([0 4 0 4 0 80])
    view([90 0])
        title(sprintf('Max Temp = %g',max(max(w))))
    subplot(2,2,4)
    mesh(x,y,w')
    axis([0 4 0 4 0 80])
    view([180 0])
    drawnow;
end
