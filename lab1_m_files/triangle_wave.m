function [ triangle ] = triangle_wave( t, A, f, harmonics, gains )
%TRIANGLE_WAVE Produces a triangle wave of specified parameters
%   Produces a triangle wave using the fourier series with as many harmonics
%   as specified in the harmonics input. harmonics and gains are both
%   vectors (of the same length) representing what harmonics are present
%   and the gain for each harmonic. A is the amplitude, f is the freq.

triangle_fun = @(t, n) A * (8/pi^2) * gains(n) .* (-1).^(n-1) .* ...
                            (sin(2*pi*(2*n - 1)*f*t) ./ (2*n - 1).^2);

triangle = sum(bsxfun(triangle_fun, t, harmonics), 1)';

end

