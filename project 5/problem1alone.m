%Program 11.1 Audio codec
%Problem 1

clear all; close all

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

plotmax=5;
for i=1:plotmax   % hear the sound of the sample from f=1 to f=4
    
    
Fs=8192;f=i;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
sound(x,Fs)                           % Matlab's sound command
figure(1); subplot(plotmax,1,i); plot(x(n+1:4096-n))
out=[];
for k=1:nb                            % loop over windows
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
hold on
plot(out,'r'); pause(1); legend('original','reconstructed'); axis([0 500 -1.8 1.8])
ylabel(sprintf('f=%d',i),'fontsize',17)
sound(out,Fs)                         % play the reconstruct
pause(1)
end

%--------------------------------------------------------------------------

for i=1:20   % plot RMSE
    
Fs=8192;f=i;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
out=[];

for k=1:nb                            % loop over windows
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

[sizeout,~]=size(out);
rmse(i)=sqrt(sum((x(n+1:4096-n)-out').^2)/sizeout);

end

figure(2)
plot(rmse)
hold on
plot(rmse,'ro')
axis([1 20 0 .2])
xlabel('f','fontsize',13)
ylabel('RMSE','fontsize',13)
title('f vs. RMSE','fontsize',17)
