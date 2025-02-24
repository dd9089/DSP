Trep = 1e-6;
t = [0:Trep:0.01];
ftone = 1000;
xt = cos(2*pi*ftone*t);
plot(t, xt);grid
Xjw = fft(xt);
Xjw = fftshift(Xjw);
faxis = linspace(-1/Trep/2,1/Trep/2,length(Xjw));
plot(faxis, abs(Xjw));grid

