%Program 11.1 Audio codec
%input: vector x of input signal
%output: vector out of output signal
%Example usage: out=simplecodec(cos((1:2^(12))*2*pi*256/2^(13)));
%               example signal is 1/2 sec. pure tone of frequency f = 256
function out=simplecodecnoaudiowindowing(x)
len=length(x);
n=2^5;                                % length of window
nw=floor(len/n);                      % number of length n windows in x
x=x(1:n*nw);                          % cut x to integer number of n windows
Fs=2^(13);                            % Fs=sampling rate
b=2; L=0.3;                           % b = quantization bits, [-L,L] amplitude range
q=2*L/(2^b-1);                        % q used for b bits on interval [-L, L]
for i=1:n                             % form the MDCT matrix
  for j=1:2*n
    M(i,j)= cos((i-1+1/2)*(j-1+1/2+n/2)*pi/n);
  end
end
M=sqrt(2/n)*M;
N=M';                                 % inverse MDCT
%x=cos((1:T*Fs)*2*pi*64*f/Fs);         % test signal
%x=x+cos((1:4096)*2*pi*64*5/Fs); 
%x=x+cos((1:4096)*2*pi*64*6/Fs);
x=0.3*x/max(abs(x));                  % normalize signal to max amplitude = 0.3
out=[];
for k=1:nw-1                          % loop over l ength 2n windows
  x0=x(1+(k-1)*n:2*n+(k-1)*n)';
  y0=M*x0;
  y1=round(y0/q);                     % transform components quantized
% Storage/transmission of file occurs here  
  y2=y1*q;                            % transform components dequantized
  w(:,k)=N*y2;                        % invert the MDCT
  h=sqrt(2)*sin(((1:4096)-1/2)*pi/(2*n));
  if(k>1)
      w2=w(n+1:2*n,k-1).*h(n+1:2*n);w3=w(1:n,k).*h(1:n);
      out=[out;(w2+w3)/2];          % collect the reconstructed signal
  end                                 % (of length 2n less than length of x)
end

