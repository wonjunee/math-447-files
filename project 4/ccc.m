% Demo for movie
% mesh vs. increasing power
MakeQTMovie('start','fraadf.mov')
MakeQTMovie('framerate',5) %   controls frame rate
figure(1)
for i=1:.05:5
    [w,x,y]=poisson3(0,4,0,4,20,20,i,1.68);

    mesh(x,y,w')
    axis([0 4 0 4 0 200])
    view([180 0])
    
    drawnow;
    MakeQTMovie('addfigure')
end

MakeQTMovie('finish')
