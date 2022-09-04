function [y] = create_number(num)       %num = [5 2 0 ..]
% Given a certain number in array form, it creates its graph and its
% magnitude response

%given data -- frequencies for each character
n1 = [697 1209];    %number 1
n2 = [697 1336];    %number 2
n3 = [697 1477];    %number 3
nA = [697 1633];    %character 'A'
n4 = [770 1209];    %number 4
n5 = [770 1336];    %number 5
n6 = [770 1477];    %number 6
nB = [770 1633];    %character 'B'
n7 = [852 1209];    %number 7
n8 = [852 1336];    %number 8
n9 = [852 1477];    %number 9
nC = [852 1633];    %character 'C'
nSTAR = [941 1209]; %character '*'
n0 = [941 1336];    %number 0
nSHARP = [941 1477];%character '#'
nD = [941 1633];    %character 'D'

fs = 8000;      %sampling frequency
N = 0.5*fs;     %duration of each number
n = 0:N-1;

Np = 0.1*fs;    %duration of the pause
pause = zeros(1,Np); %pause signal with zeros samples

for k=1:10      %check each digit of the given number
    if num(k) == 0
        x = cos(2*pi*n*(n0(1)/fs)) + cos(2*pi*n*(n0(2)/fs));
    elseif num(k) == 1
        x = cos(2*pi*n*(n1(1)/fs)) + cos(2*pi*n*(n1(2)/fs));
    elseif num(k) == 2
        x = cos(2*pi*n*(n2(1)/fs)) + cos(2*pi*n*(n2(2)/fs));
    elseif num(k) == 3
        x = cos(2*pi*n*(n3(1)/fs)) + cos(2*pi*n*(n3(2)/fs));
    elseif num(k) == 4
        x = cos(2*pi*n*(n4(1)/fs)) + cos(2*pi*n*(n4(2)/fs));
    elseif num(k) == 5
        x = cos(2*pi*n*(n5(1)/fs)) + cos(2*pi*n*(n5(2)/fs));
    elseif num(k) == 6
        x = cos(2*pi*n*(n6(1)/fs)) + cos(2*pi*n*(n6(2)/fs));
    elseif num(k) == 7
        x = cos(2*pi*n*(n7(1)/fs)) + cos(2*pi*n*(n7(2)/fs));
    elseif num(k) == 8
        x = cos(2*pi*n*(n8(1)/fs)) + cos(2*pi*n*(n8(2)/fs));
    elseif num(k) == 9
        x = cos(2*pi*n*(n9(1)/fs)) + cos(2*pi*n*(n9(2)/fs));
    elseif num(k) == 'A'
        x = cos(2*pi*n*(nA(1)/fs)) + cos(2*pi*n*(nA(2)/fs));
    elseif num(k) == 'B'
        x = cos(2*pi*n*(nB(1)/fs)) + cos(2*pi*n*(nB(2)/fs));
    elseif num(k) == 'C'
        x = cos(2*pi*n*(nC(1)/fs)) + cos(2*pi*n*(nC(2)/fs));
    elseif num(k) == 'D'
        x = cos(2*pi*n*(nD(1)/fs)) + cos(2*pi*n*(nD(2)/fs));
    elseif num(k) == '*'
        x = cos(2*pi*n*(nSTAR(1)/fs)) + cos(2*pi*n*(nSTAR(2)/fs));
    elseif num(k) == '#'
        x = cos(2*pi*n*(nSHARP(1)/fs)) + cos(2*pi*n*(nSHARP(2)/fs));
    end
       
    if k == 1               %1st loop
        y = x; 
    else
        y = cat(2,y,x); %put new signal into the array y
    end
    if k<10                 %do not put a pause after the last digit
        y = cat(2,y,pause); %put pause between the signals
    end
end

figure(1);
plot(y);
title('Signal of 10 digits with their pauses');

figure(2)
freq = 0:0.01:pi;
Y = freqz(y,1,freq);                    %frequency response of the final signal
plot(freq,abs(Y));                              
title('Magnitude response')

sound(y,fs);                      %listen to sound

end

