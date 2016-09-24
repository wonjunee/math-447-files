x=-pi:0.01:pi;
filename = 'rootspigraph.gif';
for i=1:15;
    y=functionone(x,i);
    plot(x,y)
    axis([-4 4 -.5*10^5 5*10^5])
    hold on
    grid
    hold off
    str = sprintf('The number of roots = %f, p2 = %f',roots(y),i);
    title(str);
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end