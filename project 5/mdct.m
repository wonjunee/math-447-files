function Y=mdct(X) 

[row,col]=size(X);

for i=1:n
    for j=1:2*n
        M(i,j)=sqrt(2/n)*cos((2*i+1)*((j-1)+(n+1)/2)*pi/(2*n));
    end
end
M=sqrt(2/n)*M;
Y=M*X';
