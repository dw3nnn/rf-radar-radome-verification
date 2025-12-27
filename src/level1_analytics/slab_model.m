function out = slab_model(f, eps_r, tanD, t_m)
% Normal incidence air -> dielectric slab -> air.
% Outputs: reflection Gamma(f), transmission tau(f), power T(f), IL(f) in dB.

C = constants();
c = C.c;

w  = 2*pi*f;
k0 = w./c;

% complex relative permittivity
eps_c = eps_r * (1 - 1j*tanD);

% refractive indices (mu_r ~ 1)
n0 = 1.0;
n1 = sqrt(eps_c);
n2 = 1.0;

% Fresnel coefficients
r01 = (n0 - n1)./(n0 + n1);
r12 = (n1 - n2)./(n1 + n2);
t01 = 2*n0./(n0 + n1);
t12 = 2*n1./(n1 + n2);

% propagation inside slab
beta = k0 .* n1;
phi  = exp(-1j * beta * t_m);     % one-way

% total reflection (multiple internal reflections)
Gamma = (r01 + r12.*phi.^2) ./ (1 + r01.*r12.*phi.^2);

% total transmission amplitude
tau = (t01 .* t12 .* phi) ./ (1 + r01.*r12.*phi.^2);

% power transmission (n2/n0 = 1)
T = abs(tau).^2;
T = max(T, 1e-15);

IL = -10*log10(T);

out.Gamma = Gamma;
out.tau   = tau;
out.T     = T;
out.IL    = IL;
end
