figure(1)
filename = 'triproject1.gif';
for i = [-0.673164367675781,-0.354743957519531, 0.037766762077808, 0.458878181874752, 0.977672895044088, 2.513852797448635]
i
    [u1,u2,u3,v1,v2,v3,x1,x2,y2] = function2(i,7);
      plot([u1 u2 u3 u1], [v1 v2 v3 v1], 'r'); hold on
      plot([0 x1 x2], [0 0 y2],'bo')
      line([0 u1],[0 v1])
      line([x1 u2],[0 v2])
      line([x2 u3],[y2 v3])
      hold off
      axis([-5 5 0 9])
      str = sprintf('theta = %f',i);
      title(str);
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if i == -0.673164367675781;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end

