function C = constants()
% Physical constants + band definition

C.c  = 299792458;     % m/s
C.f0 = 79e9;          % Hz (center)
C.fmin = 77e9;        % Hz
C.fmax = 81e9;        % Hz
C.Nf = 401;           % points in sweep
C.f = linspace(C.fmin, C.fmax, C.Nf);

% KPI thresholds (you can tune later)
C.IL_max_limit = 0.50;   % dB
C.G_max_limit  = 0.10;   % magnitude

% Thickness/standoff search windows (initial)
C.t_min_mm = 1.0;
C.t_max_mm = 4.0;
C.D_min_mm = 0.0;
C.D_max_mm = 10.0;
end
