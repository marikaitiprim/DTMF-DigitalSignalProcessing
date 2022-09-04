function [hd,n] = ideal_hp(wc,N)
a = (N-1)/2;
m = 0:1:(N-1);
n = m-a+eps;
hd = sinc(n)- sin(wc*n)./(pi*n);
end

