
set(0,'defaulttextfontweight','Bold');
set(0,'defaultlegendfontweight','Bold');
set(0,'defaultlegendfontweight','Bold');
set(0,'defaultaxesfontname','times new roman');
set(0,'defaulttextfontname','times new roman');
set(0, 'DefaultLegendFontName', 'times new roman'); 
set(0,'defaultAxesFontSize',14);
set(0,'defaultLegendFontSize',12);

set(0,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'DefaultTextInterpreter', 'latex');

%%

if exist('Tn','var') == 0
    Hydrodynamic_parameters_scaling;
end

ss_type = 1; % 1 monochromatic, 2 polychormatic
H_vec = 0.5:0.5:4; % m wave height OR significant wave height (Hs)
alpha_vec = linspace(0,1,15);
res_sim = cell(length(H_vec), length(alpha_vec));

% load grid data (z1, z2, Fs1, Fs2, V1, V2)
data_grids;

for j = 1:length(H_vec)
    H = H_vec(j);  
    T = 10; % s period OR energy period (Te) 
    Tsim = 20 * T;
    Kes = 1e0*Kb;
    Bes = 1e4*Bext; 
    Vmax = 20; % m/s 
    
    dt = 1e-2; % s
    t = (0:dt:100*T)'; % time vector 
    
    % Compute wave force
    Fw = compute_Fw(ss_type, H, T, omega, gamma, t);
    
    % state space identification - radiation
    ssdim=3;
    
    [Ass, Bss, Css] = ss_identification(ssdim, omega, Mad, Br);

    % PTO    
    Kpto = 0;
    Bpto = 0; 
    
    % Dynamic simulation  
    for k = 1:length(alpha_vec)
        alpha = alpha_vec(k);
        res_sim{j,k} = sim('Piston.slx');
    end
    
    % max_amp{j} = cellfun(@(x) max(x.Pos.Data(x.Pos.Time > 0.9 * Tsim)), res_sim(j,:), 'UniformOutput', true);
end

% Steady state
std_cond = res_sim{1,1}.Pos.Time >= 17 * T;

%%
z_fixed_alpha = figure(1); clf; 
st = {'--', '-'};
idx_H = [1, ceil(length(H_vec)/3), ceil(2 * length(H_vec)/3), length(H_vec)];
idx_alpha = [1, ceil(length(alpha_vec)/3), ceil(2 * length(alpha_vec)/3), length(alpha_vec)];
idx_sub = 1;

for j = idx_H
    subplot(2, 2, idx_sub); hold on; grid on; box on; set(gcf, 'Color', 'w')
    title(['H = ', num2str(H_vec(j)), 'm'])
    for k = idx_alpha
        plot(res_sim{j, k}.Pos.Time, res_sim{j, k}.Pos.Data, 'LineWidth', 1.5, 'DisplayName', ['$\alpha$ = ' num2str(alpha_vec(k),'%.2f'), ' [-]'])
    end
    legend('Location', 'bestoutside')
    xlabel('t [s]')
    ylabel('z [m]')
    idx_sub = idx_sub + 1;
end

%%
max_amp = cellfun(@(x) max(x.Pos.Data(std_cond)), res_sim, 'UniformOutput', true);

alpha_vs_maxamp = figure(2); clf; hold on; grid on; box on; set(gcf, 'Color', 'w')

for j = 1:length(H_vec)
    plot(alpha_vec, max_amp(j,:), '-o', 'LineWidth', 1.5, 'DisplayName', ['H = ' num2str(H_vec(j)), ' m'])
end
title('Max. amplitude as a function of $\alpha$')
xlabel('$\alpha$ [-]')
ylabel('Max. amplitude (steady state) [m]')
xlim("padded")
legend('Location','best', 'NumColumns', 2)


%%
figure(3); clf; hold on; grid on; box on; set(gcf, 'Color', 'w')
% Plot mean Pgen for fixed H as a function of alpha
mean_PG = zeros(length(H_vec), length(alpha_vec));
for j = 1:length(H_vec)
    for k = 1:length(alpha_vec)
        mean_PG(j,k) = mean(res_sim{j,k}.PG.Data(std_cond));
    end
    p = plot(alpha_vec, mean_PG(j,:), '-o', 'LineWidth', 1.5, 'DisplayName', ['H = ' num2str(H_vec(j)), ' m']);
    p.MarkerFaceColor = [1 1 1];
end
title('Mean $P_G$ as a function of $\alpha$')
xlabel('$\alpha$ [-]')
ylabel('Mean $P_G$ [W]')
legend('Location', 'best')
ylim('padded')

%%
figure(4); clf; hold on; grid on; box on; set(gcf, 'Color', 'w')
idx_sub = 1;
for i = idx_H(end) 
    subplot(2, 1, 1); hold on; grid on; box on; set(gcf, 'Color', 'w')
    for j = idx_alpha
        plot(res_sim{i,j}.Pos.Time(std_cond), res_sim{i,j}.FG.Data(std_cond), 'LineWidth', 1.5, 'DisplayName', ['$\alpha$ = ' num2str(alpha_vec(j),'%.2f'), ' [-]'])
    end
    title(['FG as a function of time for H = ', num2str(H_vec(i)), 'm'])
    xlabel('t [s]')
    ylabel('FG [N]')
    legend('Location', 'bestoutside')

    subplot(2, 1, 2); hold on; grid on; box on; set(gcf, 'Color', 'w')
    for j = idx_alpha
        plot(res_sim{i,j}.Pos.Time(std_cond), res_sim{i,j}.Vel.Data(std_cond), 'LineWidth', 1.5, 'DisplayName', ['$\alpha$ = ' num2str(alpha_vec(j),'%.2f'), ' [-]'])
    end
    title(['Velocity as a function of time for H = ', num2str(H_vec(i)), 'm'])
    xlabel('t [s]')
    ylabel('$\dot{z}$ [m/s]')
    legend('Location', 'bestoutside')
end


%%
figure;hold on
plot(z1data, Fs1data(end,:))
plot(z2data, -Fs2data(end,:))
plot(res_sim{3,length(alpha_vec)}.Pos.Data, res_sim{3,length(alpha_vec)}.FG.Data, 'LineWidth', 2, 'DisplayName', ['$\alpha$ = ' num2str(alpha_vec(k),'%.2f'), ' [-]'])
%%
save("res_sim.mat", "res_sim")
% %%
% export_fig(z_fixed_alpha, "z_fixed_alpha.png")
% export_fig(alpha_vs_maxamp, "alpha_vs_maxamp.png")
% export_fig(fixed_alpha_vs_Pgen, "fixed_alpha_vs_Pgen.png")
% export_fig(fixed_alpha_vs_Ugen, "fixed_alpha_vs_Ugen.png")







