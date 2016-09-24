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
rmse(i)=sqrt(sum((x(1:sizeout)-out').^2)/sizeout);

end

figure(2)
plot(rmse)
hold on
plot(rmse,'ro')
axis([1 20 0 1.5])
xlabel('f','fontsize',13)
ylabel('RMSE','fontsize',13)
title('f vs. RMSE','fontsize',17)