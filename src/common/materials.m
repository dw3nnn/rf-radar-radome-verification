function M = materials()
% Priors (initial). Adjust as you find better references or measurements.

M(1).name = "ABS";
M(1).eps_r = 2.9;
M(1).tanD  = 0.0;      % start lossless; add later
M(1).eps_unc_frac = 0.10;  % ±10% (uniform)
M(1).tanD_range = [0.0, 0.02]; % placeholder for Monte Carlo later

M(2).name = "Polycarbonate";
M(2).eps_r = 3.0;
M(2).tanD  = 0.0;      % start lossless; add later
M(2).eps_unc_frac = 0.10;  % ±10% (uniform)
M(2).tanD_range = [0.0, 0.02]; % placeholder for Monte Carlo later
end
