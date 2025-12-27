dielec = readmatrix('Dielectric_constant_data_F25-2.txt');
n = 20;
disp(dielec(n,1));
disp(dielec(n,2));
plot(dielec(:,1), dielec(:,2), '-', 'LineWidth', 2);   % main plot
hold on; grid on
plot(dielec(n,1), dielec(n,2), 'ro', 'MarkerSize', 8, 'LineWidth', 2); % operating freq marker
xlabel('Frequency (GHz)', 'FontSize', 13);
ylabel('Estimated Dielectric Constant', 'FontSize', 13);
title('Dielectric Constant of Material X vs Frequency', 'FontSize', 16);
legend('Material X vs Frequency', 'Operating Frequency');

