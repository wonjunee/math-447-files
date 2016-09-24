MakeQTMovie('start','filename.mov')
MakeQTMovie('framerate',60) %   controls frame rate

x=1:.01:100;

for i=1:100
    
    plot(x,sin(x+i/pi)) 
    drawnow;
    
MakeQTMovie('addfigure')
  
end

MakeQTMovie('finish')
