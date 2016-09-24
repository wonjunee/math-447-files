% Problem 4

% without windowing

clear all;close all;
n=32;                                 % length of window
nb=127;                               % number of windows; must be > 1
b=	16
L=5;                             % quantization information
q=2*L/(2^b-1);                        % b bits on interval [-L, L]
for i=1:n                             % form the MDCT matrix
  for j=1:2*n
    M(i,j)= cos((i-1+1/2)*(j-1+1/2+n/2)*pi/n);
  end
end
M=sqrt(2/n)*M;
N=M';     


[testsong,fs0]=wavread('testsong10sec.wav'); %10 seconds of a song
x = testsong(fs0:5*fs0); %pare down to 5 seconds


out=[];
for k=1:5511                            % loop over windows
  x0=x(1+(k-1)*n:2*n+(k-1)*n)';
  y0=M*x0;
  y1=round(y0/q);                     % transform components quantized
  y2=y1*q;                            %                and dequantized
  w(:,k)=N*y2;                        % invert the MDCT
  if(k>1)
      w2=w(n+1:2*n,k-1);w3=w(1:n,k);
      out=[out;(w2+w3)/2];            % collect the reconstructed signal
  end
end
out1=out
figure(1)
% subplot(5,1,5);
plot(x(n+1:176401-n));hold on;plot(out,'r');
title('Without a windowing function','fontsize',17)
ylabel('b=3','fontsize',17);
legend('original','reconstructed'); %axis([0 500 -.1 .1])
% sound(out,fs0)                         % play the reconstruct

% wavwrite(out,fs0,32,'without_b3.wav');

[sizeout,~]=size(out);
rmse_without=sqrt(sum((x(n+1:n+sizeout)-out').^2)/sizeout)




%with windowing

    
% sound(x,fs0)                           % Matlab's sound command

out=[];
for k=1:5511                            % loop over windows
  x0=x(1+(k-1)*n:2*n+(k-1)*n)';
  h=sqrt(2)*sin((1:2*n)*pi/(2*n));
  x0=x0.*h';
  y0=M*x0;
  y1=round(y0/q);                     % transform components quantized
  y2=y1*q;                            %                and dequantized
  w(:,k)=N*y2;                        % invert the MDCT
  if(k>1)
      w2=w(n+1:2*n,k-1).*(h(n+1:2*n))';w3=w(1:n,k).*(h(1:n))';
      out=[out;(w2+w3)/2];            % collect the reconstructed signal
  end
end

figure(2)
% subplot(5,1,5);
plot(x(n+1:176401-n));hold on;plot(out,'r');
title('With a windowing function','fontsize',17)
ylabel('b=3','fontsize',17);
legend('original','reconstructed'); %axis([0 500 -.02 .02])
% sound(out,fs0)                         % play the reconstruct

% wavwrite(out,fs0,32,'with_b3.wav');

[sizeout,~]=size(out);
rmse_with=sqrt(sum((x(n+1: n+sizeout)-out').^2)/sizeout)