% Problem 4

% without windowing

clear all;close all;

num=1;

for b=1:15
    
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
N=M';     


[testsong,fs0]=wavread('testsong10sec.wav'); %10 seconds of a song
x = testsong(fs0:5*fs0); %pare down to 5 seconds


% RMSE without window function

out=[];
for k=1:5511                           % loop over windows
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
rmse_without(num)=sqrt(sum(sum((x(n+1:n+sizeout)-out').^2))/sizeout);



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
rmse_with(num)=sqrt(sum(sum((x(n+1: n+sizeout)-out').^2))/sizeout);

num=num+1;

end

figure(1)
plot(rmse_without)
hold on
plot(rmse_with,'r')
hold off
legend('without','with')