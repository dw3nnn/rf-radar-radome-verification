function sweep_angle()

% sweep_angle: oblique-incidence KPI sweeps (TE / TM)
% Sweeps incidence angle and computes worst-case KPIs across 77-81 GHz
% Saves plots to figures/level2/

C = constants();
M = materials();

f = C.f;

% output directory
outDir = fullfile("..","..","figures","level2");
if ~exist(outDir, "dir"); mkdir(outDir); end

% sweeping angles
angles = [0 10 20 30 40 50 60];

% selected n = 2 thickness
baseline(1).name = "ABS";
baseline(1).t_mm = 2.228;

baseline(2).name = "Polycarbonate";
baseline(2).t_mm = 2.192;

% kpi arrays
pols = ["TE","TM"];

R = struct();

% material -> polarization -> angle nested loop
for b = 1:numel(baseline)
    matName = baseline(b).name;

    % find material properties
    idx = find(strcmp([M.name], matName), 1);
    if isempty(idx)
        error("Material '%s' not found in materials().", matName); 
    end

    eps_r = M(idx).eps_r;
    tanD  = M(idx).tanD;
    t_m   = baseline(b).t_mm * 1e-3;
    
    % initialize container for material
    R.(matName) = struct();

    for p = 1:numel(pols)

        pol = pols(p);

        % allocate kpi arrays for this (material, pol)
        Gmax     = zeros(1, numel(angles));
        ILmax    = zeros(1, numel(angles));
        ILripple = zeros(1, numel(angles));

        for a = 1:numel(angles)

            th = angles(a);

            % Run oblique slab model
            s = slab_model_oblique(f, eps_r, tanD, t_m, th, pol);

            % Compute KPIs over the band
            k = kpi_metrics(s.Gamma, s.IL);

            % Store per-angle KPIs
            Gmax(a)     = k.G_max;
            ILmax(a)    = k.IL_max;
            ILripple(a) = k.IL_ripple;

        end

        % save arrays into results struct
        R.(matName).(pol).angles = angles;
        R.(matName).(pol).Gmax       = Gmax;
        R.(matName).(pol).ILmax      = ILmax;
        R.(matName).(pol).ILripple   = ILripple;
    end
end

% plotting kpi vs angle
for b = 1:numel(baseline)
    matName = baseline(b).name;

    % |Γ| max vs angle
    fig = figure('Visible','off');
    plot(angles, R.(matName).TE.Gmax, 'LineWidth', 1.7); hold on;
    plot(angles, R.(matName).TM.Gmax, 'LineWidth', 1.7);
    grid on;
    xlabel('Incidence Angle (deg)');
    ylabel('|Γ|_{max} over 77–81 GHz');
    title(sprintf('%s: Worst-Case Reflection vs Angle (TE vs TM)', matName));
    legend('TE','TM','Location','best');
    saveas(fig, fullfile(outDir, "L2A_Gmax_vs_angle_" + matName + ".png"));

    % ILmax vs angle
    fig = figure('Visible','off');
    plot(angles, R.(matName).TE.ILmax, 'LineWidth', 1.7); hold on;
    plot(angles, R.(matName).TM.ILmax, 'LineWidth', 1.7);
    grid on;
    xlabel('Incidence Angle (deg)');
    ylabel('IL_{max} (dB) over 77–81 GHz');
    title(sprintf('%s: Worst-Case Insertion Loss vs Angle (TE vs TM)', matName));
    legend('TE','TM','Location','best');
    saveas(fig, fullfile(outDir, "L2A_ILmax_vs_angle_" + matName + ".png"));
end

save(fullfile(outDir, "L2A_results.mat"), "R");
disp("Level 2A complete: saved figures and results to figures/level2/");




