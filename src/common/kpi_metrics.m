function k = kpi_metrics(Gamma, IL)
k.G_max = max(abs(Gamma));
k.IL_max = max(IL);
k.IL_min = min(IL);
k.IL_ripple = k.IL_max - k.IL_min;
k.IL_avg = mean(IL);
end
