x=rand(1,80);
for i=1:80
    if x(i)<.458597
        y(i)=-1;
    
    elseif and(x(i)>=.458597,x(i)<.446247+.458597)
        y(i)=1;
    
    else (x(i)>=446247+.458597)
        y(i)=0;
    end
end
plot(y,'o')
