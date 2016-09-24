clear all

% x = (1:100) + 50*cos((1:100)*2*pi/40);

x=0:.01:10;
y=sin(x);
for i=1:1:1001
    y(i)=y(i)+rand();
end

X = dct(y);
[XX,ind] = sort(abs(X),'descend');
i = 1;
while norm(X(ind(1:i)))/norm(X)<0.95
   i = i + 1;
end
Needed = i;

X(ind(Needed+1:end)) = 0;
xx = idct(X);
plot(y)
hold on
plot(xx)
hold off
legend('Original',['Reconstructed, N = ' int2str(Needed)], ...
       'Location','SouthEast')