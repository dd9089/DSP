Trep = 1e-6;
t = [0:Trep:0.01];
ftone = 1000;
x = cos(2*pi*ftone*t);
subplot(4,1,1);
plot(t, x);grid

Xjw = fft(x);
Xjw = fftshift(Xjw);
faxis = linspace(-1/Trep/2,1/Trep/2,length(Xjw));
subplot(4,1,2);
plot(faxis, abs(Xjw));grid
axis([-2000 2000 -inf inf])

xt = Inv_Fourier(Xjw);
% subplot(4,1,3);
% plot(t, xt); grid
% axis([-inf inf -1 1])

fs = 4000;
Ts = 1/fs;
y = zeros(size(t));
y(1:1/(fs*Trep):end) = 1; 

subplot(4,1,3);
stem(t,y); grid


%Xs(t)
Xs = xt .* y;

%Fourier transform of Xs
Xsjw = fft(Xs);
Xsjw = fftshift(Xsjw);
faxis = linspace(-1/Trep/2,1/Trep/2,length(Xsjw));
subplot(4,1,4);
plot(faxis, abs(Xsjw));grid
axis([-2000 2000 -inf inf])

%Filtered signal
Xrjw = linspace()
