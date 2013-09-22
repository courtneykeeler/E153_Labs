%% Analysis based on input capacitance
Cin_probe = 21e-12; % 21 pF
square_and_triangle_analysis(Cin_probe, '10x probe')

Cin_bnc = 108e-12; % 108 pF
square_and_triangle_analysis(Cin_bnc, 'BNC')
