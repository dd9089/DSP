Trep = 1e-6;
t = [0:Trep:0.01];
ftone = 1000;
x = cos(2*pi*ftone*t);
figure;
plot(t, x);grid

Xjw = fft(x);
Xjw = fftshift(Xjw);
faxis = linspace(-1/Trep/2,1/Trep/2,length(Xjw));
figure;
plot(faxis, abs(Xjw));grid
axis([-2000 2000 -inf inf])

xt = Inv_Fourier(Xjw);
figure;
plot(t, xt); grid
axis([-inf inf -1 1])