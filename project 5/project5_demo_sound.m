[testsong,fs0]=wavread('testsong10sec.wav'); %10 seconds of a song
% sound(testsong,fs0);
tshort = testsong(fs0:5*fs0); %pare down to 5 seconds
% sound(tshort,fs0);
% sound(tshort,1.2*fs0);

tshort=tshort(1:1000);
w=zeros(200,19);
wsum=0;
for i=1:19
    wsum=wsum+mdct(tshort((i-1)*50+1:(i-1)*50+100));
end
% wsum=0;
% for i=1:19
%     wsum=wsum+w(i);
% end

wmean=wsum/19;
sound(wmean,fs0)