clear all
x=0:.01:10;
y=sin(x);
for i=1:1:1001
    y(i)=y(i)+rand();
end

z=mdct(y)

plot(x,y,'o')
