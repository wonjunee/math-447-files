% project 5 image compression demo (penguin image)

x=imread('download.jpg');
xd=double(x);
r=x(:,:,1);g=x(:,:,2);b=x(:,:,3);
xgray=.2126*r+.7152*g+.0722*b;
y=double(xgray);
y=y(1:194,1:194);
xx=dct(y);

subplot(1,2,1)
imagesc(uint8(xgray));colormap(gray);
subplot(1,2,2)
imagesc(uint8(xx));colormap(gray);