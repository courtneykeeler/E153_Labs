%%  BNC Analysis
clear all

fc = 1; % Hz. Arbitrary.
f = fc;

% V_pp = 1 V, so amplitude = 0.5 V
V_in = 0.5;

t = linspace(0, 2/f, 1000); % Two periods of time data

% Harmonics and corresponding gains to build the input waves using 
% fourier series
harmonics = (1:1:999)';
input_gains = ones(999,1);

%%% Input waves
input_square = square_wave(t, V_in, f, harmonics, input_gains);
input_triangle = triangle_wave(t, V_in, f, harmonics, input_gains);

% The system is a low pass filter, meaning after the cutoff frequency the
% response goes down at -20 dB/decade. This means the gain for any
% frequency after the corner frequency is G = f_corner / f

%%% Output waves at corner frequency
fc_gains = (fc / f) ./ harmonics;

fc_square = square_wave(t, V_in, f, harmonics, fc_gains);
fc_triangle = triangle_wave(t, V_in, f, harmonics, fc_gains);

%%% Output waves at 10 times corner frequencyasdfas
ten_fc_gains = (fc / (10 * f)) ./ harmonics;

ten_fc_square = square_wave(t, V_in, f, harmonics, ten_fc_gains);
ten_fc_triangle = triangle_wave(t, V_in, f, harmonics, ten_fc_gains);

% Plot square waves
figure(1)
clf

plot(t, input_square, 'k--')
hold on
plot(t, fc_square, 'r')
hold on
plot(t, ten_fc_square, 'b')

title('Square wave through low pass filter','FontSize',30)
legend('Input','Output at corner freq.', 'Output at 10x corner freq.')
axis([0 2/f -0.6 0.6])
set(gca,'XTick',(1/f):(1/f),'XTickLabel','T','FontSize',30)
xlabel('time')
set(gca,'YTick',0:V_in:V_in,'YTickLabel',['0';'A'],'FontSize',30)
ylabel('Voltage')

% Plot triangle waves
figure(2)
clf

plot(t, input_triangle, 'k--')
hold on
plot(t, fc_triangle, 'r')
hold on
plot(t, ten_fc_triangle, 'b')

title('Triangle wave through low pass filter','FontSize',30)
legend('Input','Output at corner freq.', 'Output at 10x corner freq.')
set(gca,'XTick',(1/f):(1/f),'XTickLabel','T','FontSize',30)
xlabel('time')
set(gca,'YTick',0:V_in:V_in,'YTickLabel',['0';'A'],'FontSize',30)
ylabel('Voltage')
