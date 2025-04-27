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


