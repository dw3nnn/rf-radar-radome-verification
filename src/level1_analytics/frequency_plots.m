function frequency_plots()
% Level 1B: Frequency-domain plots at selected baseline thicknesses.
% Generates IL(f) and |Gamma(f)| for nominal and ±0.1 mm thickness cases.

C = constants();
M = materials();
f = C.f;

outDir = fullfile("..","..","figures","level1");
if ~exist(outDir, "dir"); mkdir(outDir); end

% Selected baseline thicknesses from your n=2 vs n=3 study (mm)
% (Keep these in one place so the report and code stay aligned.)
baseline(1).name = "ABS";
baseline(1).t_mm = 2.228;

baseline(2).name = "Polycarbonate";
baseline(2).t_mm = 2.192;

tol_mm = 0.1;
caseLabels = ["nominal", "t_minus_tol", "t_plus_tol"];

for b = 1:numel(baseline)
    matName = baseline(b).name;

    % Find corresponding material struct in M
    idx = find(strcmp([M.name], matName), 1);
    if isempty(idx)
        error("Material '%s' not found in materials(). Check naming.", matName);
    end

    eps_r = M(idx).eps_r;
    tanD  = M(idx).tanD;

    t_cases_mm = [baseline(b).t_mm, baseline(b).t_mm - tol_mm, baseline(b).t_mm + tol_mm];

    % Precompute responses for the three thickness cases
    S = cell(1,3);
    KP = cell(1,3);

    fprintf("\n===== Level 1B: %s (eps_r=%.3f, tanD=%.4f) =====\n", matName, eps_r, tanD);

    for k = 1:3
        t_mm = t_cases_mm(k);
        S{k} = slab_model(f, eps_r, tanD, t_mm*1e-3);
        KP{k} = kpi_metrics(S{k}.Gamma, S{k}.IL);

        fprintf("%-11s  t=%.3f mm | ILmax=%.4f dB, |G|max=%.4f, ripple=%.4f dB\n", ...
            caseLabels(k), t_mm, KP{k}.IL_max, KP{k}.G_max, KP{k}.IL_ripple);
    end

    % -------- Plot IL(f) --------
    fig = figure('Visible','off');
    plot(f/1e9, S{1}.IL, 'LineWidth', 1.7); hold on;
    plot(f/1e9, S{2}.IL, 'LineWidth', 1.7);
    plot(f/1e9, S{3}.IL, 'LineWidth', 1.7);
    grid on;
    xlabel('Frequency (GHz)');
    ylabel('Insertion Loss IL (dB)');
    title(sprintf('%s: IL vs Frequency (t=%.3f mm, \\pm %.1f mm)', matName, baseline(b).t_mm, tol_mm));
    legend( ...
        sprintf('Nominal (%.3f mm)', t_cases_mm(1)), ...
        sprintf('t - %.1f mm (%.3f mm)', tol_mm, t_cases_mm(2)), ...
        sprintf('t + %.1f mm (%.3f mm)', tol_mm, t_cases_mm(3)), ...
        'Location','best' ...
    );
    saveas(fig, fullfile(outDir, "L1B_IL_vs_f_" + matName + "_tol.png"));

    % -------- Plot |Gamma(f)| --------
    fig = figure('Visible','off');
    plot(f/1e9, abs(S{1}.Gamma), 'LineWidth', 1.7); hold on;
    plot(f/1e9, abs(S{2}.Gamma), 'LineWidth', 1.7);
    plot(f/1e9, abs(S{3}.Gamma), 'LineWidth', 1.7);
    grid on;
    xlabel('Frequency (GHz)');
    ylabel('|Γ|');
    title(sprintf('%s: |\\Gamma| vs Frequency (t=%.3f mm, \\pm %.1f mm)', matName, baseline(b).t_mm, tol_mm));
    legend( ...
        sprintf('Nominal (%.3f mm)', t_cases_mm(1)), ...
        sprintf('t - %.1f mm (%.3f mm)', tol_mm, t_cases_mm(2)), ...
        sprintf('t + %.1f mm (%.3f mm)', tol_mm, t_cases_mm(3)), ...
        'Location','best' ...
    );
    saveas(fig, fullfile(outDir, "L1B_Gamma_vs_f_" + matName + "_tol.png"));
end

disp("Level 1B complete: saved plots to figures/level1/");
end
