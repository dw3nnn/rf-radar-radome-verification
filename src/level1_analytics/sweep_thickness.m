function sweep_thickness()
C = constants();
M = materials();

f = C.f;

t_mm = linspace(C.t_min_mm, C.t_max_mm, 301);
t_m  = t_mm * 1e-3;

outDir = fullfile("..","..","figures","level1");
if ~exist(outDir, "dir"); mkdir(outDir); end

for i = 1:numel(M)
    ILmax_vs_t = zeros(size(t_m));
    Gmax_vs_t  = zeros(size(t_m));

    for k = 1:numel(t_m)
        s = slab_model(f, M(i).eps_r, M(i).tanD, t_m(k));
        kp = kpi_metrics(s.Gamma, s.IL);
        ILmax_vs_t(k) = kp.IL_max;
        Gmax_vs_t(k)  = kp.G_max;
    end

    % ILmax vs thickness
    fig = figure('Visible','off');
    plot(t_mm, ILmax_vs_t, 'LineWidth', 1.7); grid on;
    xlabel('Thickness t (mm)'); ylabel('Worst-case IL across 77–81 GHz (dB)');
    title(sprintf('%s: IL_{max} vs thickness', M(i).name));
    saveas(fig, fullfile(outDir, "L1_ILmax_vs_t_" + M(i).name + ".png"));

    % |Gamma|max vs thickness
    fig = figure('Visible','off');
    plot(t_mm, Gmax_vs_t, 'LineWidth', 1.7); grid on;
    xlabel('Thickness t (mm)'); ylabel('Worst-case |Γ| across 77–81 GHz');
    title(sprintf('%s: |\\Gamma|_{max} vs thickness', M(i).name));
    saveas(fig, fullfile(outDir, "L1_Gmax_vs_t_" + M(i).name + ".png"));

    [bestIL, idx] = min(ILmax_vs_t);
    fprintf("%s best (ILmax-only): t = %.3f mm, ILmax = %.3f dB, Gmax = %.3f\n", ...
        M(i).name, t_mm(idx), bestIL, Gmax_vs_t(idx));
end

disp("Saved plots to figures/level1/");
end
