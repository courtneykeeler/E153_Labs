%% First order low pass filter analysis
clear all

% Set an arbitrary corner frequency.
% The corner frequency itself does not matter because we're doing our
% analysis here based on the fact the filter drops off at -20 dB/decade
% after the corner.
fc = 1;

% V_pp = 1 V, so amplitude = 0.5 V
V_in = 0.5;

t = linspace(0, 2/fc, 1000); % Two periods of time data

% The following harmonics will be used to construct the waves using the
% fourier series
harmonics = (1:1:999)';

%%% Input waves
input_square = square_wave(t, V_in, fc, harmonics, ones(999,1));
input_triangle = triangle_wave(t, V_in, fc, harmonics, ones(999,1));

% The system is a low pass filter, meaning after the cutoff frequency the
% FRF drops off at -20 dB/decade. This means the gain for any
% frequency after the corner frequency is G = f_corner / f

% For an input at the corner frequency, the gain for each harmonic is
% just the inverse of the harmonic
fc_gains = 1 ./ harmonics;

fc_square = square_wave(t, V_in, fc, harmonics, fc_gains);
fc_triangle = triangle_wave(t, V_in, fc, harmonics, fc_gains);

%%% For an input at 10 times the corner frequency, the gain for each
%%% harmonic is 1/(10n)
ten_fc_gains = 1 ./ (10 * harmonics);

ten_fc_square = square_wave(t, V_in, fc, harmonics, ten_fc_gains);
ten_fc_triangle = triangle_wave(t, V_in, fc, harmonics, ten_fc_gains);

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
axis([0 2/fc -0.6 0.6])
set(gca,'XTick',(1/fc):(1/fc),'XTickLabel','T','FontSize',30)
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
set(gca,'XTick',(1/fc):(1/fc),'XTickLabel','T','FontSize',30)
xlabel('time')
set(gca,'YTick',0:V_in:V_in,'YTickLabel',['0';'A'],'FontSize',30)
ylabel('Voltage')
