function [y] = filter_number(x)
%Creates a filter for the given signal, excluding frequencies for digits
%1,2 and 3
fs = 8000;
    
%high pass filter
N = (0.5*fs + 0.1*fs)/10;    
wc = pi*720/(fs/2); %cut frequencies under 720hz
hd = ideal_hp(wc,N);
w_tet = (hanning(N))'; %use hanning window 
h = hd.*w_tet;          
y = filter(h,1,x);      %filter final signal

figure(1)
plot(y);
title('Filtered signal without digits 1,2,3')

figure(2);
freq = 0:0.01:pi;
Y = freqz(y,1,freq);                    %frequency response of the final signal
plot(freq,abs(Y));                              
title('Magnitude response')

sound(y,fs);        %listen to filtered signal

end

