function s = slab_model(f, eps_r, tanD, t_m)
% Normal incidence air -> dielectric slab -> air.
% Outputs: reflection Gamma(f), transmission tau(f), power T(f), IL(f) in dB.


C = constants();
c = C.c;

% complex permittivity 
eps_c = eps_r(1 - 1j*tanD);

% refractive indices
n0 = 1;
n1 = sqrt(eps_c);
n2 = 1;

% fresnel coefficients 
r01 = (n0 - n1) ./ (n0 + n1);
t01 = (2*n0) ./ (n0 + n1);

r12 = (n1 - n2) ./ (n1 + n2);
t12 = (2*n1) ./ (n1 + n2);

% free space wavenumber
k0 = 2 * pi * f / c;

% propagation constant in slab
beta = k0 * n1;

% one-way phase factor through slab
phi = exp(-1j * beta * t_m);

% round trip
phi2 = phi.^2;

% closed form sum
den = 1 + (r01*r12) .* phi2;
Gamma = (r01 + r12 .* phi2) ./ den;
tau = (t01*t12) .* phi ./ den;

% insertion loss
T = abs(tau).^2;
IL = -10*log10(T);

% Outputs
s.Gamma = Gamma;
s.tau   = tau;
s.IL    = IL;

end


