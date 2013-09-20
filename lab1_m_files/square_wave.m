function [ square ] = square_wave( t_in, A, f, harmonics, gains )
%SQUARE_WAVE Produces a square wave of specified parameters
%   Produces a square wave using the fourier series with as many harmonics
%   as specified in the harmonics input. harmonics and gains are both
%   vectors (of the same length) representing what harmonics are present
%   and the gain for each harmonic. A is the amplitude, f is the freq.

square_fun = @(t, n) A * (4/pi) * gains(n) .* ...
                        (sin(2*pi*(2*n - 1)*f*t) ./ (2*n - 1));

square = sum(bsxfun(square_fun, t_in, harmonics), 1)';


end

