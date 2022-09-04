num = [5 2 0 1 9 0 0 1 6 0];    % checking with AM= 1115201900160, so the last 10 digits are 5201900160
y = create_number(num);
pause(10);              %wait 10 seconds before the next function is called
filter_number(y);
pause(10);
disp(count_aces(y));
pause(10)
[s,fs] = audioread('secret_number.wav');
disp(decode_DTMF(s,fs));