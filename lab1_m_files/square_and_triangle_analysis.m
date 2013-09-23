function square_and_triangle_analysis( input_capacitance, label )
%square_and_triangle_analysis Function to analyze what a square and 
% triangle wave looks like at the corner and 10x corner frequency.
%   We are modeling the response of a capacitor in series with
%   a function generator having a 10 kOhm source impedance. This is a first
%   order low pass filter and is a simplistic model of a 10x probe and a
%   BNC cable (each one having a different input capacitance.)

R = 10e3; % 10 kOhm

tau = R * input_capacitance;
wc = 1/tau;
fc = wc/(2*pi);

H = tf(1, [tau 1]);

% fourier series harmonics we'll use to create a square and triangle wave
harmonics = (1:1:999)'; 

%% corner frequency
t_fc = linspace(0,5/fc,10000); % 5 periods of the waves
square = square_wave(t_fc, 0.5, fc, harmonics,...
    ones(length(harmonics),1));
triangle = triangle_wave(t_fc, 0.5, fc, harmonics,...
    ones(length(harmonics),1));

[y_square_fc, t_fc] = lsim(H,square,t_fc);
[y_triangle_fc, t_fc] = lsim(H,triangle,t_fc);


%% 10x corner frequency
t_10fc = linspace(0,5/(10*fc),10000);
square = square_wave(t_10fc, 0.5, 10*fc, harmonics, ...
    ones(length(harmonics),1));
triangle = triangle_wave(t_10fc, 0.5, 10*fc, harmonics, ...
    ones(length(harmonics),1));

[y_square_10fc, t_10fc] = lsim(H,square,t_10fc);
[y_triangle_10fc, t_10fc] = lsim(H,triangle,t_10fc);


%% Plotting

figure
plot(t_fc, square, 'k--')
hold on
plot(t_fc, y_square_fc, 'b')
hold on
plot(10*t_10fc, y_square_10fc,'r')
title(strcat(label, ' square wave input and response'),'FontSize',30)
ylabel('Amplitude (volts)','FontSize',30)
xlabel('Time (seconds)','FontSize',30)
legend('Input','Output at corner freq.',...
    'Output at 10x corner freq. (time scaled)')
set(gca,'FontSize',30)

figure
plot(t_fc, triangle, 'k--')
hold on
plot(t_fc, y_triangle_fc, 'b')
hold on
plot(10*t_10fc, y_triangle_10fc,'r')
title(strcat(label, ' triangle wave input and response'),'FontSize',30)
ylabel('Amplitude (volts)','FontSize',30)
xlabel('Time (seconds)','FontSize',30)
legend('Input','Output at corner freq.',...
    'Output at 10x corner freq. (time scaled)')
set(gca,'FontSize',30)

end

