% Demo for audio f vs. rmse plot

clear all; close all;

Fs=8192;
for i=1:20
    f=i;                          % Fs=sampling rate, f is multiple of base freq.
    x=cos((1:4096)*pi*64*f/4096);         % test signal
    y=simplecodecnoaudio(x);

    % RMSE plot
    [len,~]=size(y);
    rmse(i)=sqrt(sum((x(1:len)'-y).^2));
end
plot(rmse)
hold on
plot(rmse,'ro')
xlabel('f','fontsize',13)
ylabel('RMSE','fontsize',13)
title('f vs. RMSE','fontsize',20)