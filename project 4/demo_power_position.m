% Demo for movie
% mesh vs. increasing power
% moving input position


MakeQTMovie('start','filename.mov')

for i=0:20
    [w,x,y]=poisson4(0,4,0,4,40,40,8,1.68,i);
    
    subplot(2,2,1)
    mesh(x,y,w')
    axis([0 4 0 4 40 90])
    view([90 90])
    title('K=1.68 P=8')
    subplot(2,2,2)
    mesh(x,y,w')
    axis([0 4 0 4 40 90])
    view([45 20])
    title(sprintf('Input position =%g',i/10))
    subplot(2,2,3)
    mesh(x,y,w')
    axis([0 4 0 4 40 90])
    view([90 0])
    title(sprintf('Max Temp = %g',max(max(w))))
    subplot(2,2,4)
    mesh(x,y,w')
    axis([0 4 0 4 40 90])
    view([180 0])
    drawnow;
    
MakeQTMovie('addfigure')
  
end

MakeQTMovie('finish')
