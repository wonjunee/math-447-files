clear all

movie1=project3([0 10],[pi/2 0],2000,0);
movie2=project3([0 20],[pi/2 0],2000,0);

'movie 1,2 are done'

ballsize=3;
discrete=5;
da=1;
[row, col, time]=size(movie1)

newmovie1=zeros(floor(row/discrete-1)+(ballsize-1),floor(col/discrete-1)+(ballsize-1),time);    
newmovie2=zeros(floor(row/discrete-1)+(ballsize-1),floor(col/discrete-1)+(ballsize-1),time);    

'blank'

for i=1:time;
    num=1;
    for roww=1:row
        for coll=1:col
            if movie1(roww,coll,i)==1
                for ballj=0:ballsize-1
                    for ballk=0:ballsize-1
                        newmovie1(floor(roww/discrete)+1+ballj,floor(coll/discrete)+1+ballk,i)=da;
                    end
                end
                num=num+1;
            end
        end
    end
end

for i=1:time;
    num=1;
    for roww=1:row
        for coll=1:col
            if movie2(roww,coll,i)==1
                for ballj=0:ballsize-1
                    for ballk=0:ballsize-1
                        newmovie2(floor(roww/discrete)+1+ballj,floor(coll/discrete)+1+ballk,i)=da;
                    end
                end
                num=num+1;
            end
        end
    end
end


for i=1:time
    
        subplot(1,2,1)
        image(newmovie1(:,:,i)*100)
        subplot(1,2,2)
        image(newmovie2(:,:,i)*100)
        drawnow;pause(.005)
        colormap(gray)
end

