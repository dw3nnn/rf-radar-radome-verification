function robust_kpi()
% robust_kpi: robustness metrics (worst-case over angle)
% Loads results and summarizes global worst-case KPIs vs angle/pol.
% Writes a report-style summary to figures/level2/L2B_summary.txt.

    % ---- Paths ----
    inDir = fullfile("..","..","figures","level2");
    inPath = fullfile(inDir, "L2A_results.mat");

    if ~exist(inPath, "file")
        error("Missing Level 2A results file: %s\nRun sweep_angle() first.", inPath);
    end

    S = load(inPath, "R");
    R = S.R;

    % ---- Materials / pols expected in the results struct ----
    matList = ["ABS", "Polycarbonate"];
    pols = ["TE","TM"];

    % ---- Output file ----
    outPath = fullfile(inDir, "L2B_summary.txt");
    fid = fopen(outPath, "w");
    if fid < 0
        error("Could not open output file for writing: %s", outPath);
    end

    % Ensure we always close the file even if an error occurs
    cleanupObj = onCleanup(@() fclose(fid)); %#ok<NASGU>

    % ---- Header ----
    fprintf(fid, "Level 2B Robust KPI Summary (Worst-case over angle, 77–81 GHz)\n");
    fprintf(fid, "============================================================\n\n");
    fprintf(fid, "Inputs:\n");
    fprintf(fid, "  Source: %s\n", inPath);
    fprintf(fid, "  Metrics: |Gamma|max and ILmax (already worst-case across frequency)\n");
    fprintf(fid, "  Robustness: max over angle (and worst of TE/TM)\n\n");

    % ---- Loop over materials ----
    for m = 1:numel(matList)
        matName = matList(m);

        % Validate material exists
        if ~isfield(R, matName)
            fprintf(fid, "Material: %s\n", matName);
            fprintf(fid, "  ERROR: Material not found in results struct R.\n\n");
            continue;
        end

        % Angles (assume TE/TM share same angles)
        if ~isfield(R.(matName), "TE") || ~isfield(R.(matName).TE, "angles")
            fprintf(fid, "Material: %s\n", matName);
            fprintf(fid, "  ERROR: Missing TE angles field.\n\n");
            continue;
        end
        angles = R.(matName).TE.angles;

        fprintf(fid, "Material: %s\n", matName);
        fprintf(fid, "----------------------------\n");

        worst = struct();

        % ---- Loop over polarizations ----
        for p = 1:numel(pols)
            pol = pols(p);

            if ~isfield(R.(matName), pol)
                fprintf(fid, "%s:\n", pol);
                fprintf(fid, "  ERROR: Polarization not found in results.\n");
                continue;
            end

            % Extract KPI arrays vs angle
            if ~isfield(R.(matName).(pol), "Gmax") || ~isfield(R.(matName).(pol), "ILmax")
                fprintf(fid, "%s:\n", pol);
                fprintf(fid, "  ERROR: Missing Gmax and/or ILmax fields.\n");
                continue;
            end

            G = R.(matName).(pol).Gmax;
            IL = R.(matName).(pol).ILmax;

            % Worst-case over angle and where it occurs
            [G_worst, iG] = max(G);
            [IL_worst, iIL] = max(IL);

            worst.(pol).G_worst = G_worst;
            worst.(pol).G_angle = angles(iG);
            worst.(pol).IL_worst = IL_worst;
            worst.(pol).IL_angle = angles(iIL);

            fprintf(fid, "%s:\n", pol);
            fprintf(fid, "  Worst |G|max over angle: %.4f at %g deg\n", G_worst, angles(iG));
            fprintf(fid, "  Worst ILmax over angle:  %.4f dB at %g deg\n", IL_worst, angles(iIL));
        end

        % ---- Polarization-robust worst-case (worst of TE/TM) ----
        hasTE = isfield(worst, "TE");
        hasTM = isfield(worst, "TM");

        if hasTE && hasTM
            G_all = max([worst.TE.G_worst, worst.TM.G_worst]);
            IL_all = max([worst.TE.IL_worst, worst.TM.IL_worst]);

            if worst.TE.G_worst >= worst.TM.G_worst
                G_pol = "TE"; G_ang = worst.TE.G_angle;
            else
                G_pol = "TM"; G_ang = worst.TM.G_angle;
            end

            if worst.TE.IL_worst >= worst.TM.IL_worst
                IL_pol = "TE"; IL_ang = worst.TE.IL_angle;
            else
                IL_pol = "TM"; IL_ang = worst.TM.IL_angle;
            end

            fprintf(fid, "\nPolarization-robust (worst of TE/TM):\n");
            fprintf(fid, "  Worst |G|max overall: %.4f (%s at %g deg)\n", G_all, G_pol, G_ang);
            fprintf(fid, "  Worst ILmax overall:  %.4f dB (%s at %g deg)\n", IL_all, IL_pol, IL_ang);
        else
            fprintf(fid, "\nPolarization-robust (worst of TE/TM):\n");
            fprintf(fid, "  ERROR: Missing TE and/or TM results; cannot compute combined worst-case.\n");
        end

        fprintf(fid, "\n\n");
    end

    fprintf("Level 2B complete: wrote %s\n", outPath);
end
