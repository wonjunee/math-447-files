%Program 11.1 Audio codec
%Problem 1

clear all; close all

n=32;                                 % length of window
nb=127;                               % number of windows; must be > 1
b=9; L=5;                             % quantization information
q=2*L/(2^b-1);                        % b bits on interval [-L, L]
for i=1:n                             % form the MDCT matrix
  for j=1:2*n
    M(i,j)= cos((i-1+1/2)*(j-1+1/2+n/2)*pi/n);
  end
end
M=sqrt(2/n)*M;
N=M';                                 % inverse MDCT

plotmax=1;
for i=1:plotmax   % hear the sound of the sample from f=1 to f=4
    
    
Fs=8192;f=i;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
sound(x,Fs)                           % Matlab's sound command
figure(1); subplot(plotmax,1,i); plot(x)
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
plot(out,'r'); pause(1); legend('original','reconstructed'); axis([0 500 -2 2])
sound(out,Fs)                         % play the reconstruct
pause(1)
end

%--------------------------------------------------------------------------

for i=1:10   % plot RMSE
    
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
rmse(i)=sqrt(sum((x(1:sizeout)-out').^2)/sizeout);

end

figure(2)
plot(rmse)
hold on
plot(rmse,'ro')
hold off

%--------------------------------------------------------------------------

% problem 2 windowing

maxi=1;

for i=1:maxi   % hear the sound of the sample from f=1 to f=4
    
    
Fs=8192;f=i;                          % Fs=sampling rate, f is multiple of base freq.
x=cos((1:4096)*pi*64*f/4096);         % test signal
sound(x,Fs)                           % Matlab's sound command
figure(3)
subplot(maxi,1,i)
plot(x)
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

hold on
plot(out,'r');pause(1);legend('original','reconstructed'); axis([0 500 -2 2])
sound(out,Fs)                         % play the reconstruct
pause(1)
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
rmse(i)=sqrt(sum((x(1:sizeout)-out').^2)/sizeout);

end

figure(4)
plot(rmse)
hold on
plot(rmse,'ro')
hold off

%--------------------------------------------------------------------------

% Problem 4


% without windowing

[testsong,fs0]=wavread('testsong10sec.wav'); %10 seconds of a song
x = testsong(fs0:5*fs0); %pare down to 5 seconds

maxi = 1;
for i=1:maxi   % hear the sound of the sample from f=1 to f=4
    
sound(x,fs0)                           % Matlab's sound command
figure(5)
subplot(maxi,1,i)
plot(x)
out=[];
for k=1:5511                            % loop over windows
  x0=x(1+(k-1)*n:2*n+(k-1)*n)';
  x0=x0.*h';
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
plot(out,'r');legend('original','reconstructed'); axis([0 500 -.1 .1])
pause(4)
sound(out,fs0)                         % play the reconstruct
pause(4)
end

%with windowing

    
sound(x,fs0)                           % Matlab's sound command
figure(7)
subplot(maxi,1,i)
plot(x)
out=[];
for k=1:5511                            % loop over windows
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

hold on
plot(out,'r');legend('original','reconstructed'); axis([0 500 -.1 .1])
pause(4)
sound(out,fs0)                         % play the reconstruct


% RMSE without window function

out=[];
for k=1:5511                           % loop over windows
  x0=x(1+(k-1)*n:2*n+(k-1)*n)';
  x0=x0.*h';
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
rmse_without=sqrt(sum((x(1:sizeout)-out').^2)/sizeout);



% RMSE with window function

out=[];
for k=1:5511                           % loop over windows
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

[sizeout,~]=size(out);
rmse_with=sqrt(sum((x(1:sizeout)-out').^2)/sizeout);