Z = peaks;
figure('Renderer','zbuffer');
surf(Z);
axis tight manual;
set(gca,'NextPlot','replaceChildren');
for j = 1:1
    surf(sin(2*pi*j/20)*Z,Z)
    F(j) = getframe;
end
movie(F,20) % Play the movie twenty times