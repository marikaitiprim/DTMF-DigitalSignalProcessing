function [number] = decode_DTMF(s,fs)
%given a signal, it finds the number
% seperating each part of the signal, using bandpass filters and compare energies, we find each digit 

low_freqs = [697 770 852 941];          %low frequencies
high_freqs = [1209 1336 1477 1633];     %high frequencies

number = [];        %store the number

d_size = 0.5*fs;    %duration of each digit
p_size = 0.1*fs;    %duration of the pause

index1 = 1;
index2 = d_size;

for k = 1:10    %for each part of the signal find the number  
       
    x = s(index1:index2);   %the part of the signal
    index1 = index1 + d_size + p_size;
    index2 = index1 + d_size - 1;
    
    Energy_matrix_low = [];     %store the energy of the signal filtered with the bandpass low frequency
    Energy_matrix_high = [];    %store the energy of the signal filtered with the bandpass high frequency
    
    for i = 1:4    %for each low and high frequency
         
        low_band = bandpass(low_freqs(i),fs);    %bandpass for every low frequency
        yl = filter(low_band,1,x);
        frl = 0:0.01:pi;
        Yl = freqz(yl,1,frl);
        
        figure(k);
        if k~=1 && i~=1 %not to have a problem in figure 1 in main.m
            hold on;
        end
        plot(frl,abs(Yl));                              
        title('Magnitude response of signal filtered with each bandpass')
        
        ESl = (abs(Yl)).^2;                     %find energy signal
        El = 0;
        for l = 1:length(Yl)
            El = El+ESl(l);                     %find the total energy of the signal
        end
        
        Energy_matrix_low = cat(2,Energy_matrix_low,El); %store the total energy in the same position
        
        
        high_band = bandpass(high_freqs(i),fs); %bandpass for high frequencies 
        yh = filter(high_band,1,x);
        frh = 0:0.01:pi;
        Yh = freqz(yh,1,frh);
        
        figure(k);
        hold on;
        plot(frh,abs(Yh));   %show both low and high frequency                           

        ESh = (abs(Yh)).^2;
        Eh = 0;
        for h = 1:length(Yh)
            Eh = Eh+ESh(h);
        end

        Energy_matrix_high = cat(2,Energy_matrix_high,Eh);
    end
            
    [low_energy,low_index] = max(Energy_matrix_low);        %find the max energy and its position in the low energy matrix
    [high_energy,high_index]=max(Energy_matrix_high);       %find the max energy and its position in the high energy matrix
    low_freq = low_freqs(low_index);                  %find the corresponding frequency into the array with the given frequencies
    high_freq = high_freqs(high_index);               %find the corresponding frequency into the array with the given frequencies

    if low_freq == low_freqs(1) && high_freq == high_freqs(1)   %combine the low and high frequencies found, to find the digit
        number = cat(2,number,1);
    elseif low_freq == low_freqs(1) && high_freq == high_freqs(2) 
        number = cat(2,number,2);
    elseif low_freq == low_freqs(1) && high_freq == high_freqs(3) 
        number = cat(2,number,3);
    elseif low_freq == low_freqs(1) && high_freq == high_freqs(4) 
        number = cat(2,number,'A');
    elseif low_freq == low_freqs(2) && high_freq == high_freqs(1)
        number = cat(2,number,4);
    elseif low_freq == low_freqs(2) &&  high_freq == high_freqs(2)
        number = cat(2,number,5);
    elseif low_freq == low_freqs(2) &&  high_freq == high_freqs(3)
        number = cat(2,number,6);
    elseif low_freq == low_freqs(2) && high_freq == high_freqs(4) 
        number = cat(2,number,'B');
    elseif low_freq == low_freqs(3) && high_freq == high_freqs(1) 
        number = cat(2,number,7);
    elseif low_freq == low_freqs(3) &&  high_freq == high_freqs(2)
        number = cat(2,number,8);
    elseif low_freq == low_freqs(3) && high_freq == high_freqs(3) 
        number = cat(2,number,9);
    elseif low_freq == low_freqs(3) && high_freq == high_freqs(4) 
        number = cat(2,number,'C');
    elseif low_freq == low_freqs(4) && high_freq == high_freqs(1) 
        number = cat(2,number,'*');
    elseif  low_freq == low_freqs(4)&& high_freq == high_freqs(2) 
        number = cat(2,number,0);
    elseif low_freq == low_freqs(4) && high_freq == high_freqs(3) 
        number = cat(2,number,'#');
    elseif low_freq == low_freqs(4) && high_freq == high_freqs(4) 
        number = cat(2,number,'D');
    end
end  
disp('The number of the file is: ');

end

