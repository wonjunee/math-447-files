
[~,~,time]=size(a);
pn=1;
for i=1:time
    if a(2,1,i)==1
        pn=-1;
        break
    end
end