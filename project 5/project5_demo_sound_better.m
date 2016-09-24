clear all; close all;

Fs=8192;f=1;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
subplot(4,1,1)
plot(x)
hold on
y=simplecodec(x);
plot(y,'r')
ylabel('f=1','fontsize',13)
hold off

% RMSE plot
[len,~]=size(y);
rmse=sqrt(sum((x(1:len)'-y).^2))


Fs=8192;f=2;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
subplot(4,1,2)
plot(x)
hold on
y=simplecodec(x);
plot(y,'r')
ylabel('f=2','fontsize',13)

% RMSE plot
[len,~]=size(y);
rmse=sqrt(sum((x(1:len)'-y).^2))

Fs=8192;f=3;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
subplot(4,1,3)
plot(x)
hold on
y=simplecodec(x);
plot(y,'r')
ylabel('f=3','fontsize',13)

Fs=8192;f=4;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
subplot(4,1,4)
plot(x)
hold on
y=simplecodec(x);
plot(y,'r')
ylabel('f=4','fontsize',13)