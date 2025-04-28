%%
%------------------------Q1----------------------------------
n = 0:15;
input1 = cos(n*pi/3);
input2 = sin(n*pi/7);

output1x = system1(input1);
output1y = system1(input2);
output_sum1 = system1(input1 + input2);

sys1 = norm(output_sum1 - (output1x + output1y)) < 1e-10;
if (sys1)
    disp("System1 is linear");
else
    disp("System1 is not linear");
end


output2x = system2(input1);
output2y = system2(input2);
output_sum2 = system2(input1 + input2);
sys2 = norm(output_sum2 - (output2x + output2y)) < 1e-10;
if (sys2)
    disp("System2 is linear");
else
    disp("System2 is not linear");
end

output3x = system3(input1);
output3y = system3(input2);
output_sum3 = system3(input1 + input2);
sys3 = norm(output_sum3 - (output3x + output3y)) < 1e-10;
if (sys3)
    disp("System3 is linear");
else
    disp("System3 is not linear");
end


%----------------B---------------------
impulse = [1, zeros(1,99)];
output2 = system2(impulse);

nonzero_idx = find(abs(output2) > 1e-5);
if nonzero_idx(end) < length(output2)
    disp("System2 is FIR");
else
    disp("System2 is IIR");
end

output3 = system3(impulse);
nonzero_idx = find(abs(output3) > 1e-5);
if nonzero_idx(end) < length(output3)
    disp("System3 is FIR");
else
    disp("System3 is IIR");
end

%%
% -------------------------------Q2----------------------
h1 = [0.0030, -0.0050, 0.0067, 0, -0.0252, 0.0721, -0.1306, 0.1801, 0.7979,...
      0.1801, -0.1306, 0.0721, -0.0252, 0, 0.0067, -0.0050, 0.0030];

% Impulse response
figure;
stem(h1);
title('Impulse Response h1');
xlabel('n'); ylabel('h1[n]');

% Frequency response
figure;
freqz(h1,1);
title('Frequency Response of h1');
%Low pass filter

%----------------------B-------------------
h2 = [0.0030, 0.0050, 0.0067, 0, -0.0252, -0.0721, -0.1306, -0.1801, 0.7979,...
      -0.1801, -0.1306, -0.0721, -0.0252, 0, 0.0067, 0.0050, 0.0030];

% Impulse response
figure;
stem(h2);
title('Impulse Response h2');
xlabel('n'); ylabel('h2[n]');

% Frequency response
figure;
freqz(h2,1);
title('Frequency Response of h2');
%High pass filter

%------------------C------------------------
h_cascade = conv(h1, h2); % h1 and h2 already defined

figure;
stem(h_cascade);
title('Impulse Response of Cascaded Filter');
xlabel('n'); ylabel('Amplitude');

figure;
freqz(h_cascade, 1);
title('Frequency Response of Cascaded Filter (Time Domain)');

[H1, w] = freqz(h1, 1);
[H2, ~] = freqz(h2, 1);
H_cascade_freq = H1 .* H2;

figure;
plot(w/pi, abs(H_cascade_freq));
grid on;
title('Frequency Response of Cascaded Filter (Frequency Domain)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');

figure;
plot(w/pi, abs(H_cascade_freq), 'b-', 'LineWidth', 1.5); hold on;
plot(w_direct/pi, abs(H_cascade_direct), 'r--', 'LineWidth', 1.5);
grid on;
legend('Multiplication of H1 and H2', 'Freqz of h_{cascade}');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
title('Comparison of Cascaded Filter Frequency Responses');

%%
% --------------------Q3-----------------------------------------
b = [0.0186, 0.0743, 0.1114, 0.0743, 0.0186];
a = [1, -1.5704, 1.2756, -0.4844, 0.0762];

%-----------B--------------------------------
b = [0.0186, 0.0743, 0.1114, 0.0743, 0.0186];
a = [1, -1.5704, 1.2756, -0.4844, 0.0762];

[h, n] = impz(b, a, 40); % 40 samples

disp("The first three samples are: ");
disp(h(1:3));

stem(n, h);
title('Impulse Response of the IIR Filter');
xlabel('n'); ylabel('h[n]');


%------------C------------------------------
figure;
freqz(b, a);
title('Frequency Response of the IIR Filter');

%------------D-----------------------------------
zeros_iir = roots(b); % zeros
poles_iir = roots(a); % poles

figure;
zplane(b, a);
title('Pole-Zero Plot of the IIR Filter');

%%
%-----------------Q4--------------------------------------------
f = [0 0.2 0.35 0.65 0.8 1]; 

m = [0 0 1 1 0 0]; 

N = 50; 
b = firpm(N, f, m);

figure;
stem(b);
title('Impulse Response h[n]');
xlabel('n'); ylabel('Amplitude');

figure;
freqz(b,1,1024);
title('Frequency Response');

% Frequency Response
[H, w] = freqz(b, 1, 1024);

% Convert magnitude to dB
mag_dB = 20*log10(abs(H) + eps); % +eps to avoid log(0)

% Define bands (normalized to pi)
w_norm = w / pi;

% Passband: 0.35 to 0.65
passband = (w_norm >= 0.35) & (w_norm <= 0.65);

% Stopbands: 0 to 0.2 and 0.8 to 1
stopband1 = (w_norm >= 0) & (w_norm <= 0.2);
stopband2 = (w_norm >= 0.8) & (w_norm <= 1);

% Check conditions
passband_min = min(mag_dB(passband));
stopband1_max = max(mag_dB(stopband1));
stopband2_max = max(mag_dB(stopband2));

% Display results
disp(['Minimum magnitude in passband: ', num2str(passband_min), ' dB']);
disp(['Maximum magnitude in stopband 0-0.2π: ', num2str(stopband1_max), ' dB']);
disp(['Maximum magnitude in stopband 0.8π-π: ', num2str(stopband2_max), ' dB']);

% Quick pass/fail
if passband_min > -1
    disp('PASS: Passband meets specification.');
else
    disp('FAIL: Passband does not meet specification.');
end

if stopband1_max < -20
    disp('PASS: Stopband 0-0.2π meets specification.');
else
    disp('FAIL: Stopband 0-0.2π does not meet specification.');
end

if stopband2_max < -20
    disp('PASS: Stopband 0.8π-π meets specification.');
else
    disp('FAIL: Stopband 0.8π-π does not meet specification.');
end