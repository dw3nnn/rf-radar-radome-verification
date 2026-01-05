function dielectric_loss_sweep()
% dielectric_loss_sweep
% Sensitivity to dielectric loss tangent tanδ for planar slab radome.
% Sweeps tanδ and computes worst-case KPIs across 77–81 GHz vs angle and polarization.
% Saves plots + .mat results to figures/level2/.

    C = constants();
    M = materials();
    f = C.f;

    % Same angles
    angles_deg = [0 10 20 30 40 50 60];
    pols = ["TE","TM"];

    % Candidate thicknesses (from Level 1 decisions)
    baseline(1).name = "ABS";          baseline(1).t_mm = 2.228;
    baseline(2).name = "Polycarbonate"; baseline(2).t_mm = 2.192;

    % Sweep tanδ values
    tanD_list = [0 0.005 0.010 0.015 0.02];

    outDir = fullfile("..","..","figures","level2");
    if ~exist(outDir, "dir"); mkdir(outDir); end

    % Results container
    R2C = struct();
    R2C.angles_deg = angles_deg;
    R2C.tanD_list  = tanD_list;

    for b = 1:numel(baseline)
        matName = baseline(b).name;

        idx = find(strcmp([M.name], matName), 1);
        if isempty(idx); error("Material '%s' not found in materials().", matName); end

        eps_r = M(idx).eps_r;
        t_m   = baseline(b).t_mm * 1e-3;

        % Store baselines
        R2C.(matName).eps_r = eps_r;
        R2C.(matName).t_mm  = baseline(b).t_mm;

        % Arrays: tanD x angle
        for p = 1:numel(pols)
            pol = pols(p);

            Gmax = zeros(numel(tanD_list), numel(angles_deg));
            ILmax = zeros(numel(tanD_list), numel(angles_deg));

            for td = 1:numel(tanD_list)
                tanD = tanD_list(td);

                for a = 1:numel(angles_deg)
                    th = angles_deg(a);

                    s = slab_model_oblique(f, eps_r, tanD, t_m, th, pol);
                    k = kpi_metrics(s.Gamma, s.IL);

                    Gmax(td, a)  = k.G_max;
                    ILmax(td, a) = k.IL_max;
                end
            end

            R2C.(matName).(pol).Gmax  = Gmax;
            R2C.(matName).(pol).ILmax = ILmax;
        end

        % ---- Plot 1: ILmax vs angle for multiple tanD (TE and TM on separate plots) ----
        for p = 1:numel(pols)
            pol = pols(p);

            fig = figure('Visible','off');
            hold on; grid on;
            for td = 1:numel(tanD_list)
                plot(angles_deg, R2C.(matName).(pol).ILmax(td,:), 'LineWidth', 1.7);
            end
            xlabel('Incidence Angle (deg)');
            ylabel('IL_{max} (dB) over 77–81 GHz');
            title(sprintf('%s: IL_{max} vs Angle (%s), tan\\delta sweep', matName, pol));

            leg = strings(1,numel(tanD_list));
            for td = 1:numel(tanD_list)
                leg(td) = sprintf('tan\\delta = %.3f', tanD_list(td));
            end
            legend(leg, 'Location','best');
            saveas(fig, fullfile(outDir, "L2C_ILmax_vs_angle_" + matName + "_" + pol + ".png"));
        end

        % ---- Plot 2: ILmax vs tanD at selected angles (0° and 60°), TE/TM on same plot ----
        angles_pick = [0 60];
        for ap = 1:numel(angles_pick)
            th0 = angles_pick(ap);
            [~, ia] = min(abs(angles_deg - th0));

            fig = figure('Visible','off'); grid on; hold on;
            plot(tanD_list, R2C.(matName).TE.ILmax(:,ia), 'LineWidth', 1.7);
            plot(tanD_list, R2C.(matName).TM.ILmax(:,ia), 'LineWidth', 1.7);

            xlabel('tan\delta');
            ylabel(sprintf('IL_{max} (dB) at %g°', angles_deg(ia)));
            title(sprintf('%s: IL_{max} sensitivity to tan\\delta at %g°', matName, angles_deg(ia)));
            legend('TE','TM','Location','best');
            saveas(fig, fullfile(outDir, "L2C_ILmax_vs_tanD_" + matName + "_ang" + angles_deg(ia) + ".png"));
        end
    end

    save(fullfile(outDir, "L2C_results.mat"), "R2C");
    disp("Level 2C complete: saved figures and L2C_results.mat to figures/level2/");
end
