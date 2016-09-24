x = (1:100) + 50*cos((1:100)*2*pi/40);
X = dct(x);
[XX,ind] = sort(abs(X),'descend');
i = 1;
while norm(X(ind(1:i)))/norm(X)<0.99
   i = i + 1;
end
Needed = i;
Reconstruct the signal and compare to the original.

X(ind(Needed+1:end)) = 0;
xx = idct(X);
