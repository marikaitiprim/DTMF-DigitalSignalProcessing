function [hband] = bandpass(f,fs)
%band pass filter using blackman window
%creates a low pass and a high pass filter near frequency f

N = (0.5*fs + 0.1*fs)/20;  
w_tet = (blackman(N))'; %using blackman window

%low pass
wc = pi*(f+20)/(fs/2);
hlow = ideal_lp(wc,N);
h1 = hlow.*w_tet;          

%high pass
wc = pi*(f-20)/(fs/2);
hhigh = ideal_hp(wc,N);
h2 = hhigh.*w_tet;          

%both
hband = conv(h1,h2);

end

