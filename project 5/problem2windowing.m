% Problem 2

clear all; close all;

Fs=8192;f=1;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
h=sqrt(2)*sin(((1:64)-1/2)*pi/(2*32));
size(h)
size(x)
newx=x.*h;
subplot(4,1,1)
plot(newx)
hold on
y=simplecodecwindowing(newx,h);
plot(y,'r')
ylabel('f=1','fontsize',13)
hold off

% RMSE plot
[len,~]=size(y);
rmse=sqrt(sum((newx(1:len)'-y).^2))


Fs=8192;f=2;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
h=sqrt(2)*sin(((1:4096)-1/2)*pi/(2*f));
newx=x.*h;
subplot(4,1,2)
plot(newx)
hold on
y=simplecodecwindowing(newx,h);
plot(y,'r')
ylabel('f=2','fontsize',13)

% RMSE plot
[len,~]=size(y);
rmse=sqrt(sum((newx(1:len)'-y).^2))

