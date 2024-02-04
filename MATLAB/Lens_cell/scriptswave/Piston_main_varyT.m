
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
if in == input("Press 1 to start the simulation")
    if exist('Tn','var') == 0
        Hydrodynamic_parameters_scaling;
    end
    
    ss_type = 1; % 1 monochromatic, 2 polychormatic
    H_vec = 0.5:0.5:4; % m wave height OR significant wave height (Hs)
    alpha_vec = linspace(0,1,15);
    T_vec = ceil(Tn) * linspace(1,2,5);
    res_sim_varyT = cell(length(H_vec), length(alpha_vec), length(T_vec));
    
    % load grid data (z1, z2, Fs1, Fs2, V1, V2)
    data_grids;
    
    Kes = 1e0*Kb;
    Bes = 1e4*Bext; 
    Vmax = 20; % m/s 
    dt = 1e-2; % s
    
    % PTO    
    Kpto = 0;
    Bpto = 0; 
    
    % state space identification - radiation
    ssdim=3;
    
    [Ass, Bss, Css] = ss_identification(ssdim, omega, Mad, Br);
    
    tic
    for k = 1:length(T_vec)
        T = T_vec(k);
        Tsim = 15 * T;
        set_param("Piston","FastRestart","off")
        t = (0:dt:100*T)'; % time vector 
        
        for i = 1:length(H_vec)
            H = H_vec(i);  
            % Compute wave force
            Fw = compute_Fw(ss_type, H, T, omega, gamma, t);
            set_param("Piston","FastRestart","on")
            % Dynamic simulation  
            for j = 1:length(alpha_vec)
                alpha = alpha_vec(j);
                res_sim_varyT{i,j,k} = sim('Piston.slx');
            end
        end
        fprintf("%i%% \n", k/length(T_vec) * 100)
    end
    toc
end
%%
idx_H = [1, ceil(length(H_vec)/3), ceil(2 * length(H_vec)/3), length(H_vec)];
idx_alpha = [1, ceil(length(alpha_vec)/3), ceil(2 * length(alpha_vec)/3), length(alpha_vec)];
idx_T = [1, ceil(length(T_vec)/3), ceil(2 * length(T_vec)/3), length(T_vec)];
%%

idx_fig = 1;

z_fixed_alpha = figure(1); clf; 
for i = floor(linspace(1, length(H_vec),4))
    figure(idx_fig); clf; hold on; grid on; box on; set(gcf, 'Color', 'w');
    idx_sub = 1;
    for k = idx_T
        subplot(2, 2, idx_sub); hold on; grid on; box on; set(gcf, 'Color', 'w');
        title(['H = ', num2str(H_vec(i)), '[m], T = ', num2str(T_vec(k)), '[s]'])
        idx_st = 1;        
        for j = floor(linspace(1,length(alpha_vec),6))
            st = '-';
            if mod(idx_st+1,2) == 0
                st = '--';
            end
            plot(res_sim_varyT{i, j, k}.Pos.Time, res_sim_varyT{i, j, k}.Pos.Data, st, 'LineWidth', 1.5, 'DisplayName', ['$\alpha$ = ' num2str(alpha_vec(j),'%.2f'), ' [-]'])
            idx_st = idx_st + 1;
        end
        xlabel('t [s]')
        ylabel('z [m]')
        if idx_sub == 1
            legend('Location', 'southwest')
        end
        idx_sub = idx_sub + 1;
    end
    idx_fig = idx_fig + 1;
end

%%

figure(idx_fig+1); clf; hold on; grid on; box on; set(gcf, 'Color', 'w')
idx_sub = 1;
f = 1 ./ T_vec;
% Plot mean Pgen for selected H, for fixed alpha as a function of f
% mean_PG = zeros(length(H_vec), length(alpha_vec), length(T_vec));
for i = floor(linspace(1, length(H_vec),4))
    for j = floor(linspace(1,length(alpha_vec),6))
        for k = 1:length(T_vec)
            std_cond = res_sim_varyT{i,j,k}.Pos.Time > 15 * T_vec(k) - 1 * T_vec(k);
            mean_PG(i,j,k) = mean(res_sim_varyT{i,j,k}.PG.Data(std_cond));
        end
        if 1 %ismember(j,idx_alpha)
            leg = 'on';
        else
            leg = 'off';
        end
        subplot(2, 2, idx_sub); hold on; grid on; box on; set(gcf, 'Color', 'w')
        plot(f, squeeze(mean_PG(i,j,:)), '-o', 'LineWidth', 1.5, 'DisplayName', ['$\alpha$ = ' num2str(alpha_vec(j),'%.2f'), ' [-]' ], 'HandleVisibility', leg)
        title(['$f$ vs Mean $P_G$ (s.s.) for H = ', num2str(H_vec(i)), 'm'])
        xlabel('f [Hz]')
        ylabel('Mean $P_G$ [W]')
        legend('Location', 'best')
    end
    xline(1/Tn, '--', {'Resonance freq.'}, 'HandleVisibility', 'off')
    idx_sub = idx_sub + 1;
    
end

%%
figure(idx_fig+2); clf; hold on; grid on; box on; set(gcf, 'Color', 'w')
idx_sub = 1;
for i = idx_H(end) 
    subplot(2, 1, 1); hold on; grid on; box on; set(gcf, 'Color', 'w')
    for j = idx_alpha
        plot(res_sim_varyT{i,j}.Pos.Time(std_cond), res_sim_varyT{i,j}.FG.Data(std_cond), 'LineWidth', 1.5, 'DisplayName', ['$\alpha$ = ' num2str(alpha_vec(j),'%.2f'), ' [-]'])
    end
    title(['FG as a function of time for H = ', num2str(H_vec(i)), 'm'])
    xlabel('t [s]')
    ylabel('FG [N]')
    legend('Location', 'bestoutside')

    subplot(2, 1, 2); hold on; grid on; box on; set(gcf, 'Color', 'w')
    for j = idx_alpha
        plot(res_sim_varyT{i,j}.Pos.Time(std_cond), res_sim_varyT{i,j}.Vel.Data(std_cond), 'LineWidth', 1.5, 'DisplayName', ['$\alpha$ = ' num2str(alpha_vec(j),'%.2f'), ' [-]'])
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
plot(res_sim_varyT{3,length(alpha_vec)}.Pos.Data, res_sim_varyT{3,length(alpha_vec)}.FG.Data, 'LineWidth', 2, 'DisplayName', ['$\alpha$ = ' num2str(alpha_vec(k),'%.2f'), ' [-]'])
%%
save("res_sim_varyT.mat", "res_sim_varyT", '-v7.3')
% %%
% export_fig(z_fixed_alpha, "z_fixed_alpha.png")
% export_fig(alpha_vs_maxamp, "alpha_vs_maxamp.png")
% export_fig(fixed_alpha_vs_Pgen, "fixed_alpha_vs_Pgen.png")
% export_fig(fixed_alpha_vs_Ugen, "fixed_alpha_vs_Ugen.png")



