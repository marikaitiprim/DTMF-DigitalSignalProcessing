function [counter] = count_aces(x)
% Counts the aces into the given signal

fs=8000;
h1 = bandpass(697,fs);      %create a bandpass for f=697
h2 = bandpass(1209,fs);     %create a bandpass for f=1209
h_band = conv(h1,h2);       %combine the 2 filters

y = filter(h_band,1,x);      %filter final signal

figure(1)
plot(y); 
title('Filter passing only aces frequencies')

figure(2);
freq = 0:0.01:pi;
Y = freqz(y,1,freq);                    %frequency response of the final signal
plot(freq,abs(Y));                              
title('Magnitude response')

counter = 0;
for i = 1:length(y)
    if y(i) >= 0.0000028        %enter section of ace 
        if y(i+1) < 0.000001    %leaving section of ace
            counter = counter + 1;  %increase counter as we found an ace
        end
    end
end

disp('Number of aces is');
end

