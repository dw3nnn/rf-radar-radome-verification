function compare_n2_n3()
C = constants();
M = materials();
f = C.f;

% Thickness tolerance (mm)
tol_mm = 0.1;

% Local search window around each nominal (mm)
win_mm = 0.25;

% Nominal guesses (mm) – you can adjust later or compute from lambda_m
% Use same nominal for both materials for now; local search will refine.
t_nom_n2 = 2.2;
t_nom_n3 = 3.3;

outDir = fullfile("..","..","figures","level1");
if ~exist(outDir, "dir"); mkdir(outDir); end

for i = 1:numel(M)
    fprintf("\n===== %s: n=2 vs n=3 comparison =====\n", M(i).name);

    % Refine local best around n=2 and n=3 candidates
    t2 = local_best_t(f, M(i), t_nom_n2, win_mm);
    t3 = local_best_t(f, M(i), t_nom_n3, win_mm);

    % Evaluate nominal and tolerance corners
    R2 = eval_with_tolerance(f, M(i), t2, tol_mm);
    R3 = eval_with_tolerance(f, M(i), t3, tol_mm);

    % Print summary tables
    print_summary("n=2", t2, R2);
    print_summary("n=3", t3, R3);

    % Decision logic (simple + defensible):
    % prioritize worst-case ILmax under tolerance, then worst-case |Gamma|, then ripple.
    score2 = 1.0*R2.ILmax_wc + 0.5*R2.Gmax_wc + 0.2*R2.ripple_wc;
    score3 = 1.0*R3.ILmax_wc + 0.5*R3.Gmax_wc + 0.2*R3.ripple_wc;

    if score2 <= score3
        fprintf("Decision: Choose n=2 (t=%.3f mm) based on lower worst-case KPI score.\n", t2);
    else
        fprintf("Decision: Choose n=3 (t=%.3f mm) based on lower worst-case KPI score.\n", t3);
    end
end

end

function t_best = local_best_t(f, mat, t_center_mm, win_mm)
% Search locally around a candidate thickness and choose t that minimizes ILmax.
t_vec = linspace(t_center_mm-win_mm, t_center_mm+win_mm, 301);
ILmax = zeros(size(t_vec));
Gmax  = zeros(size(t_vec));
rip   = zeros(size(t_vec));

for k = 1:numel(t_vec)
    s = slab_model(f, mat.eps_r, mat.tanD, t_vec(k)*1e-3);
    kp = kpi_metrics(s.Gamma, s.IL);
    ILmax(k) = kp.IL_max;
    Gmax(k)  = kp.G_max;
    rip(k)   = kp.IL_ripple;
end

% Choose by ILmax (primary). You could also use a weighted objective.
[~, idx] = min(ILmax);
t_best = t_vec(idx);
end

function R = eval_with_tolerance(f, mat, t_mm, tol_mm)
% Evaluate at t, t±tol and return nominal + worst-case under tolerance.
t_cases = [t_mm, t_mm - tol_mm, t_mm + tol_mm];

ILmax = zeros(size(t_cases));
Gmax  = zeros(size(t_cases));
rip   = zeros(size(t_cases));

for j = 1:numel(t_cases)
    s = slab_model(f, mat.eps_r, mat.tanD, t_cases(j)*1e-3);
    kp = kpi_metrics(s.Gamma, s.IL);
    ILmax(j) = kp.IL_max;
    Gmax(j)  = kp.G_max;
    rip(j)   = kp.IL_ripple;
end

R.t_cases = t_cases;
R.ILmax   = ILmax;
R.Gmax    = Gmax;
R.ripple  = rip;

R.ILmax_nom = ILmax(1);
R.Gmax_nom  = Gmax(1);
R.ripple_nom = rip(1);

R.ILmax_wc = max(ILmax);
R.Gmax_wc  = max(Gmax);
R.ripple_wc = max(rip);
end

function print_summary(label, t_mm, R)
fprintf("\n--- %s candidate ---\n", label);
fprintf("Refined t* = %.3f mm\n", t_mm);
fprintf("Nominal:    ILmax=%.4f dB, |G|max=%.4f, ripple=%.4f dB\n", R.ILmax_nom, R.Gmax_nom, R.ripple_nom);
fprintf("t - tol:    t=%.3f mm -> ILmax=%.4f dB, |G|max=%.4f, ripple=%.4f dB\n", R.t_cases(2), R.ILmax(2), R.Gmax(2), R.ripple(2));
fprintf("t + tol:    t=%.3f mm -> ILmax=%.4f dB, |G|max=%.4f, ripple=%.4f dB\n", R.t_cases(3), R.ILmax(3), R.Gmax(3), R.ripple(3));
fprintf("Worst-case: ILmax=%.4f dB, |G|max=%.4f, ripple=%.4f dB\n", R.ILmax_wc, R.Gmax_wc, R.ripple_wc);
end
