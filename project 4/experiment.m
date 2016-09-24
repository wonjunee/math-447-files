for time=0:20

[w,x,y]=poisson7a(0,4,0,4,40,40,5,3.85,20,time);
mesh(x,y,w')
view([45 20])
axis([0 4 0 4 0 150])
title(mean(mean(w)));
drawnow

end