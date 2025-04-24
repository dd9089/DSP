clear all
%% Declare Variables
Trep = 1e-6;
t = [0:Trep:0.01];
ftone = 1000;
%any number below 40 * ftone produces an imperfect reconstruction
fs = ftone * 2.5;
Ts = 1/fs;

A=1e-3;
raiseindex=max(find(t<A));
decayindex=max(find(t<2*A));
xt=zeros(size(t));
xt(1:raiseindex)=t(1:raiseindex)/A;
xt(raiseindex+1:decayindex)=1-t(1:raiseindex)/A;

%% Continuous Signal
subplot(6,1,1);
plot(t, xt);grid
xlabel("time (s)");
ylabel("Amplitude");
title('Original Continuous-time signal x(t)');

%% Fourier Transfrom
Xjw = fft(xt);
Xjw = fftshift(Xjw);
faxis = linspace(-1/Trep/2,1/Trep/2,length(Xjw));
subplot(6,1,2);
plot(faxis, abs(Xjw));grid
axis([-fs fs -inf inf])
xlabel("Frequency (Hz)");
ylabel("Magnitude")
title('|X(j\omega)|');


%% Impulse train
y = zeros(size(t));
y(1:1/(fs*Trep):end) = 1;

%Xs(t)
xs = xt .* y;

%% Fourier transform of Xs
Xsjw = fft(xs, length(t));
Xsjw = fftshift(Xsjw);

subplot(6,1,3);
plot(faxis, abs(Xsjw));grid
axis([-fs fs -inf inf]);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title('Sampled signal |X_s(j\omega)|');

%% Filtered signal low pass filter
Hr = Ts * (abs(2 * pi * faxis) < (pi/Ts));

% Hr = zeros(1, length(faxis));
% 
% for i = 1:length(faxis)
%   if abs(2 * pi * faxis(i)) < (pi / Ts)
%     Hr(i) = Ts;
%   end
% end

Xrjw =  Xsjw .* Hr;

subplot(6,1,4);
plot(faxis, abs(Xrjw));grid
axis([-fs fs -inf inf]);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title('Filtered Signal |X_r(j\omega)|');

%% Reconstructed signal
xrt = Inv_Fourier(Xrjw);

xrt=max(xt)/max(xrt)*xrt;

subplot(6,1,5);
plot(t, xrt); grid
xlabel("Time (s)");
ylabel("Amplitude");
title('Reconstructed signal x_r(t)');

subplot(6,1,6);
plot(t,xt, '-r', t, xrt, '-c');grid
xlabel("Time (s)");
ylabel("Amplitude");
legend('Original Signal x(t)', 'Reconstructed Signal x_r(t)')
title('Original Signal x(t) & Reconstructed signal x_r(t)');

