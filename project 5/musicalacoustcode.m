%You can play with sound in Matlab

%%%%%%%%%%%%%%%%%%%%%%
%Sound analysis 
%%%%%%%%%%%%%%%%%%%%%%

% Record your voice for 3 seconds.
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 3);
disp('End of Recording.');

% Play back the recording.
play(recObj);

% Store data in double-precision array.
myRecording = getaudiodata(recObj);

% Plot the waveform.
plot(myRecording);

%Now input a wav file

[testsong,fs0]=wavread('testsong10sec.wav'); %10 seconds of a song
sound(testsong,fs0);
tshort = testsong(fs0:5*fs0); %pare down to 5 seconds
sound(tshort,fs0);
sound(tshort,1.2*fs0);

[basin,fs1]=wavread('basin10sec.wav'); %10 seconds of a song
%sound(basin,fs1);
bshort=basin(fs1:5*fs1);
sound(bshort,fs1);
sound(bshort,fs1/1.2);


%%%%%%%%%%%%%%%%%%%%%%
%Determining pitch 
%%%%%%%%%%%%%%%%%%%%%%

%Make the sound A-440Hz for 1 second. Note that Matlab has a default sample rate of 8192.  

x=linspace(0,1,8192);
y=cos(2*440*pi*x);
sound(y)

%%%%%%%%%%%%%%%%%%%%%%
%Banjo analysis
%%%%%%%%%%%%%%%%%%%%%%

%Make a figure of the plucked banjo string, the flute, and the clarinet.


[yorig,fs2]=wavread('banjoA.wav'); %This is an open A string on a banjo. 
sound(yorig,fs2);

y=yorig(13100:21100); %So we can compare, we use one second of this data.
x=linspace(0,1,fs2+1);

sound(y,fs2);
plot(x,y');
figure;
plot(dct(y)); %See all the harmonics that we predicted? Hint: they are integer multiples of 880.


nu=880;
v=[1 2 3 4 5 6 7 8];
hold on;
plot(nu*v,0*v,'g.','markersize', 26)
axis([0 8000 -.3 .3]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%Flute analysis
%%%%%%%%%%%%%%%%%%%%%%

[flute,fsflute]=wavread('lownoteflute.wav');
sound(flute,fsflute)
flutesec=flute(100:fsflute+100);
sound(flutesec,fsflute);
figure;
x=linspace(0,1,fsflute+1);
plot(x,flutesec);
figure;
plot(dct(flutesec));




nu=2*261.63;
v=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
hold on;
plot(nu*v,0*v,'g.','markersize', 26)
axis([0 8000 -.3 .3]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%Harmonics of the clarinet
%%%%%%%%%%%%%%%%%%%%%%

[clarinet,fsclarinet]=wavread('lownoteclarinet.wav');
%sound(clarinet,fsclarinet)

clarinetsec=clarinet(100:fsclarinet+100);
%sound(clarinetsec,fsclarinet);

x=linspace(0,1,fsclarinet+1);

figure
plot(x,clarinetsec);


figure
plot(dct(clarinetsec));



nu=2*147;
v=[1 3 5 7 9 11 13 15];
hold on;
plot(nu*v,0*v,'g.','markersize', 26)
axis([0 2000 -5 5]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A fun game to play with sound (also how a radio or television station works)  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Many of the high frequencies can be removed without changing the sound much. (aka Low pass filter)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dummy,n]=size(tshort);
nq=floor(n/4);

hat_tshort = dct(tshort);

newhat=[hat_tshort(1:nq) zeros(1,3*nq)]; %I just removed 3/4 of the frequencies!

sound(idct(newhat),fs0); %But the tune is still recognizable!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In fact we can borrow that empty space.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hat_bshort = dct(bshort);

hat_multi= [hat_tshort(1:nq) zeros(1,2*nq+1) hat_bshort(1:nq)];

multi=idct(hat_multi);
sound(multi,fs1)

hat_only = [zeros(1,3*nq) hat_bshort(1:nq)];
sound(idct(hat_only(3*nq+1:4*nq)),fs1/4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
