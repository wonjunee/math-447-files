%Program 11.1 Audio codec
%Problem 1 RMSE alone

% clear all; close all

n=32;                                 % length of window
nb=127;                               % number of windows; must be > 1
b=4; L=5;                             % quantization information
q=2*L/(2^b-1);                        % b bits on interval [-L, L]
for i=1:n                             % form the MDCT matrix
  for j=1:2*n
    M(i,j)= cos((i-1+1/2)*(j-1+1/2+n/2)*pi/n);
  end
end
M=sqrt(2/n)*M;
N=M';                                 % inverse MDCT

% problem 2 windowing

maxi=5;

for i=3/2   % hear the sound of the sample from f=1 to f=4
    
    
Fs=8192;f=i;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
% sound(x,Fs)                           % Matlab's sound command
figure(3)
subplot(maxi,1,i)
plot(x(n+1:4096-n))
out=[];
for k=1:nb                            % loop over windows
  x0=x(1+(k-1)*n:2*n+(k-1)*n)';
%   h=sqrt(2)*sin((1+(k-1)*n:2*n+(k-1)*n)*pi/(2*n));
  h=sqrt(2)*sin((1:2*n)*pi/(2*n));
  size(h)
  size(x0)
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

hold on
plot(out,'r');pause(1);legend('original','reconstructed'); axis([0 500 -1.7 1.7])
ylabel(sprintf('f=%d',i),'fontsize',17)
% sound(out,Fs)                         % play the reconstruct
% pause(1)
end

for i=1:20   % Plot RMSE with window function
    
    
Fs=8192;f=i;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
out=[];
for k=1:nb                            % loop over windows
  x0=x(1+(k-1)*n:2*n+(k-1)*n)';
%   h=sqrt(2)*sin((1+(k-1)*n:2*n+(k-1)*n)*pi/(2*n));
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

[sizeout,~]=size(out);
rmse(i)=sqrt(sum((x(n+1:4096-n)-out').^2)/sizeout);

end

figure(4)
plot(rmse)
hold on
plot(rmse,'ro')
hold off
xlabel('f','fontsize',13)
ylabel('RMSE','fontsize',13)
title('f vs. RMSE','fontsize',17)
