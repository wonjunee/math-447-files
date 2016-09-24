function root=roots(y)

A=y>0;
cl=0;
for i=1:628;
    if A(i)+A(i+1)==1;
        cl=cl+1;
    end
end
root=cl;