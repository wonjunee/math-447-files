%Program 11.1 Audio codec
%Problem 3 with windowing

clear all; %close all

n=32;                                 % length of window
nb=127;                               % number of windows; must be > 1
b=5; L=5;                             % quantization information
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
outt=[];
x=0;
for i=[5/3,2/1,3/2]   % hear the sound of the sample from f=1 to f=4
    Fs=8192;f=i;                          % Fs=sampling rate, f is multiple of base freq.
    x1=cos((1:4096)*pi*64*f/4096);         % test signal
    x=x+x1;
end

sound(x,Fs);pause(1);

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

% plot(out,'r');pause(1);legend('original','reconstructed'); axis([0 500 -1.7 1.7])
% ylabel(sprintf('f=%d',i),'fontsize',17)
% sound(out,Fs)                         % play the reconstruct
% pause(1)

sound(out,Fs);
subplot(5,1,5)
plot(x(n+1:4096-n),'b')
hold on
plot(out,'r')
hold off
axis([0 700 -3 3])
ylabel('b=5','fontsize',17)
size(x(n+1:4096-n))
size(out)




for b=1:30   % Plot RMSE with window function
       
n=32;                                 % length of window
nb=127;                               % number of windows; must be > 1
L=5;                             % quantization information
q=2*L/(2^b-1);                        % b bits on interval [-L, L]
for i=1:n                             % form the MDCT matrix
  for j=1:2*n
    M(i,j)= cos((i-1+1/2)*(j-1+1/2+n/2)*pi/n);
  end
end
M=sqrt(2/n)*M;
N=M';                                 % inverse MDCT

outt=[];
x=0;
for i=[5/3,2/1,3/2]   % hear the sound of the sample from f=1 to f=4
    Fs=8192;f=i;                          % Fs=sampling rate, f is multiple of base freq.
    x1=cos((1:4096)*pi*64*f/4096);         % test signal
    x=x+x1;
end

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
rmse(b)=sqrt(sum((x(n+1:4096-n)-out').^2)/sizeout);

end

figure(2)
plot(rmse,'linewidth',3)
xlabel('b','fontsize',13)
ylabel('RMSE','fontsize',13)
title('b vs. RMSE','fontsize',17)
