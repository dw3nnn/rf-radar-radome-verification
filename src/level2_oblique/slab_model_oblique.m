function s = slab_model_oblique(f, eps_r, tanD, t_m, theta0_deg, pol)

% slab_model_oblique: oblique-incidence air-dielectric-air slab slab_model
% Inputs: f (Hz), eps_r, tanD, t_m (m), theta0_deg(deg), pol ("TE" or "TM")
% Outputs: s.Gamma, s.tau, s.IL (all vs frequency)

C = constants();
c = C.c;

theta0 = deg2rad(theta0_deg);


% complex permittivity and refractive indices
eps_c = eps_r * (1 - 1j*tanD);

n0 = 1;
n1 = sqrt(eps_c);
n2 = 1;

% angles in each medium (Snells Law)

sin_t1 = (n0/n1) * sin(theta0);
cos_t0 = cos(theta0);
cos_t1 = sqrt(1 - sin_t1.^2);

cos_t2 = cos_t0;

% fresnel coefficients at each interface (TE vs TM)

pol = upper(string(pol));



if strcmpi(pol, "TE")
    disp("Using TE");
    r01 = (n0*cos_t0 - n1*cos_t1) / (n0*cos_t0 + n1*cos_t1);
    t01 = (2*n0*cos_t0)         / (n0*cos_t0 + n1*cos_t1);

    r12 = (n1*cos_t1 - n2*cos_t2) / (n1*cos_t1 + n2*cos_t2);
    t12 = (2*n1*cos_t1)           / (n1*cos_t1 + n2*cos_t2);

elseif strcmpi(pol, "TM")
    % use proportion n / cos(theta)
    disp("Using TM");
    Y0 = n0 / cos_t0;
    Y1 = n1 / cos_t1;
    Y2 = n2 / cos_t2;

    r01 = (Y0 - Y1) / (Y0 + Y1);
    t01 = (2*Y0)    / (Y0 + Y1);

    r12 = (Y1 - Y2) / (Y1 + Y2);
    t12 = (2*Y1)    / (Y1 + Y2);

else
    error('pol must be "TE" or "TM"');
end

% phase accumulation through the slab at oblique incidence

k0 = 2 * pi * f / c;
kz1 = k0 * (n1*cos_t1);

phi = exp(-1j * kz1 * t_m);
phi2 = phi.^2;

% F-P closed forms
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

s.f = f;
s.theta0_deg = theta0_deg;
s.pol = pol;
s.eps_r = eps_r;
s.tanD = tanD;
s.t_m = t_m;

end
