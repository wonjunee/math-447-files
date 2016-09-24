% project 5 image compression demo (penguin image)

x=imread('download.jpg');

r=x(:,:,1);g=x(:,:,2);b=x(:,:,3);
xgray=.2126*r+.7152*g+.0722*b;

x=xgray(1:194,1:194);
x=double(x);
xd=double(x);
xc=xd-128;
z=dct(x);

for i=1:8
    for j=9-i:8
        z(i,j)=0;
    end
end

xdq=dct2(z);
xe=xdq+128;

y=double(xgray);
y=y(1:194,1:194);
xx=dct3(y);


subplot(1,3,1)
imagesc(uint8(xgray(1:194,1:194)));colormap(gray);
subplot(1,3,2)
imagesc(uint8(xx));colormap(gray);
subplot(1,3,3)
imagesc(uint8(xe));colormap(gray);