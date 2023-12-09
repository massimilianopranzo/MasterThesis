clearvars; close all; clc;
clear assumptions   
addpath("Functions and Scripts\");
addpath("1DOF\");
set_env;
load("cell_1dof_pstrain.mat")
load("cell_1dof_pstress.mat")
load("cell_1dof_nostrain.mat")
load("res_1dof_pstrain.mat")
%

% Data --------------------------------------------------------------
% Constants
eps1_max = 0.05;

% Symbolic variables ------------------------------------------------
% Physical properties
syms nu Y_p epsilon_p epsilon_f EBD_p EBD_f real positive

% Geometry of the capacitor
syms x l_0 w_0 tp_0 xi xi_0 tf_0 dt_f dtf real positive

% Physical quantities
syms V

syms epsilon_1(x) epsilon_2(x) epsilon_3(x) sigma_1(x) epsilon1_max

% Geometry ------------------------------

dt_f(x) = simplify(solve((x/2 - tf_0 / 2) / l_0 == (dtf / 2) / (l_0 - (xi - xi_0)), dtf), 25)
t_f(x) = tf_0 + dt_f; 

pstrain = sstrain1(pstrain_1dof, "PSTRAIN");
pstress = sstrain1(pstress_1dof, "PSTRESS");
nostrain = nostrain_1dof;

% Range limit
x_min = double(sdata1(pstrain.x_min))
x_max = subs(sstrain1(pstrain.x_max), epsilon1_max, eps1_max);
x_max = double(sdata1(rhs(isolate(x_max, x))))
x_minmax = [double(x_min) double(x_max)];

%% C(x): Plane strain - Plane stress - No strain
myfig(1,"x - C(x)"); clf; hold on
fplot(x, sdata1(pstrain.C), x_minmax, '-', 'LineWidth', 2, 'DisplayName', 'Plane strain')
fplot(x, sdata1(pstress.C), x_minmax, '*', 'LineWidth', 2, 'DisplayName', 'Plane stress')
fplot(x, sdata1(nostrain.C), x_minmax, '+', 'LineWidth',2, 'DisplayName', 'No strain')
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','north')
addlabels("x [m]", "C(x) [F]", "x - C(x) | Different def. condition")
xlim("padded")

%% C(x): Plane strain with epsilon_1 = 0 or epsilon_3 = 0
myfig(2,"x - C(x)"); clf; hold on
fplot(x, sdata1(pstrain.C), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane strain')
fplot(x, sdata1(subs(pstrain.C, epsilon_1, 0)), x_minmax, '*', 'LineWidth',2, 'DisplayName', '$\varepsilon_1 = 0$')
fplot(x, sdata1(subs(pstrain.C, epsilon_3, 0)), x_minmax, '+', 'LineWidth',2, 'DisplayName', '$\varepsilon_3 = 0$')
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','north')
addlabels("x [m]", "C(x) [F]", "x - C(x) | Plane strain")
xlim("padded")


%% C(x): Plane strain with epsilon_1 = 0 or epsilon_2 = 0
myfig(3,"x - C(x)"); clf; hold on
fplot(x, sdata1(pstress.C), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane stress')
fplot(x, sdata1(subs(pstress.C, epsilon_2, 0)), x_minmax, '*', 'LineWidth',2, 'DisplayName', '$\varepsilon_2 = 0$')
fplot(x, sdata1(subs(pstress.C, epsilon_3, 0)), x_minmax, '+', 'LineWidth',2, 'DisplayName', '$\varepsilon_3 = 0$')
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','north')
addlabels("x [m]", "C(x) [F]", "x - C(x) | Plane stress")
xlim("padded")


%% C(x): Plane strain with different tp_0
tp0_range = sdata1(tp_0) - 0.9*sdata1(tp_0) : 0.9*sdata1(tp_0) : sdata1(tp_0) + 0.9*sdata1(tp_0);
C_tp0 = subs(sdata1(pstrain.C, 'except', tp_0), tp_0, tp0_range);

myfig(4, "x - C(x) varying $tp_0$"); hold on
for i = 1:length(tp0_range)
    if i == 2
        name = strjoin(["$tp_0 =$", string(vpa(tp0_range(i),4)), "m (Nom.)"]);
    else
        name = strjoin(["$tp_0 =$", string(vpa(tp0_range(i),4)), "m"]);
    end
    
    fplot(x, pickelem(C_tp0, i), x_minmax, 'LineWidth',2, 'DisplayName', name)
end
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','north')
addlabels("x [m]", "C(x) [F]", "x - C(x) varying $tp_0$")
xlim("padded")


%% C(x): Plane strain with different w_0
w0_range = sdata1(w_0) - 0.5*sdata1(w_0) : 0.5*sdata1(w_0) : sdata1(w_0) + 0.5*sdata1(w_0);
C_w0 = subs(sdata1(pstrain.C, 'except', w_0), w_0, w0_range);

myfig(5, "x - C(x) varying $w_0$"); hold on
for i = 1:length(w0_range)
    if i == 2
        name = strjoin(["$w_0 =$", string(vpa(w0_range(i),4)), "m (Nom.)"]);
    else
        name = strjoin(["$w_0 =$", string(vpa(w0_range(i),4)), "m"]);
    end
    fplot(x, pickelem(C_w0, i), x_minmax, 'LineWidth',2, 'DisplayName', name)
end
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','north')
addlabels("x [m]", "C(x) [F]", "x - C(x) varying $w_0$")
xlim("padded")


%% C(x): Plane strain with different l_0
l0_range = sdata1(l_0) - 0.5*sdata1(l_0) : 0.5*sdata1(l_0) : sdata1(l_0) + 0.5*sdata1(l_0);
C_l0 = subs(sdata1(pstrain.C, 'except', l_0), l_0, l0_range);

myfig(6, "x - C(x) varying $l_0$"); hold on
for i = 1:length(l0_range)
    if i == 2
        name = strjoin(["$l_0 =$", string(vpa(l0_range(i),4)), "m (Nom.)"]);
    else
        name = strjoin(["$l_0 =$", string(vpa(l0_range(i),4)), "m"]);
    end
    fplot(x, pickelem(C_l0, i), x_minmax, 'LineWidth',2, 'DisplayName', name)
end
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','north')
addlabels("x [m]", "C(x) [F]", "x - C(x) varying $l_0$")
xlim("padded")


%% Vmax(x): Plane stress - Plane strain
myfig(7,"x - Vmax(x)"); clf; hold on
fplot(x, sdata1(pstress.Vmax), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane stress')
fplot(x, sdata1(pstrain.Vmax), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane strain')
myxline(double(x_min), "x_{MIN}");
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','southwest')
addlabels("x [m]", "Vmax(x) [V]", "x - Vmax(x) | Different def. condition")
xlim("padded")


%% Uel(x): Plane stress - Plane strain
myfig(8,"x - Uel(x)"); clf; hold on;
fplot(x, sdata1(pstress.Uel), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane stress')
fplot(x, sdata1(pstrain.Uel), x_minmax, '--', 'LineWidth',2, 'DisplayName', 'Plane strain')
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','northwest')
addlabels("x [m]", "Uel(x) [J]", "x - Uel(x) | Different def. condition")
xlim("padded")


%% F(x): Plane stress - Plane strain
x_range_test = [linspace(x_min, 0.5e-3, 700), (0.5e-3+1e-5):3e-5:x_max];
psig_FVmin_test = subs(sdata1(pstress.FVmin), x, x_range_test);
psig_FVmax_test = subs(sdata1(pstress.FVmax), x, x_range_test);
peps_FVmin_test = subs(sdata1(pstrain.FVmin), x, x_range_test);
peps_FVmax_test = subs(sdata1(pstrain.FVmax), x, x_range_test);

myfig(9,"x - F(x)"); clf; hold on;
plot(x_range_test, peps_FVmax_test, 'DisplayName', '$V_{MAX}$ Plane strain')
plot(x_range_test, peps_FVmin_test, 'DisplayName', '$V_{MIN}$ Plane strain')
plot(x_range_test, psig_FVmax_test, '--o', 'DisplayName', '$V_{MAX}$ Plane stress')
plot(x_range_test, psig_FVmin_test, '--x', 'DisplayName', '$V_{MIN}$ Plane stress')
myxline(double(x_min), "x_{MIN}"); myxline(double(x_max), "x_{MAX}");
xlim("padded"); ylim("padded");
legend('FontWeight','bold', 'Location','north') 
addlabels("x [m]", "F(x) [N]", "x - F(x) | Different def. condition")

%% F - x -> U(x), u(x): Plane strain varying l_0 and xi_0
l0_range = double(sdata1(l_0) * (0.5:0.5:1.5));
ratio_xi0_l0 = double(sdata1(xi_0 / l_0));
xi0_range = ratio_xi0_l0 * l0_range;
x_range = arrayfun(@(xx) [linspace(x_min, 0.5e-3, 1500), (0.5e-3+1e-5):5e-5:0.5 * xx], l0_range, 'UniformOutput', false);
FVmin_l0 = cell(size(l0_range)); FVmax_l0 = cell(size(l0_range));
FVmin_l0tmp = sdata1(pstrain.FVmin, 'except', l_0, 's', {l_0, l0_range});
FVmax_l0tmp = sdata1(pstrain.FVmax, 'except', l_0, 's', {l_0, l0_range});
Vmax_l0x = sdata1(pstrain.Vmax, 'except', l_0, 's', {l_0, l0_range}); Vmax_l0 = cell(size(l0_range));
Uasint_l0 = cell(size(l0_range)); Uel_xmax = cell(size(l0_range)); uel_xmax = cell(size(l0_range));
Cmax_l0 = sdata1(pstrain.C, 'except', l_0, 's', {l_0, l0_range, x, x_range{1}(1)});
Vol_l0 = sdata1(pstrain.Vol, 'except', {l_0, xi_0}, 's', {l_0, l0_range, xi_0, xi0_range});
for i = 1:length(l0_range)
    % x - F
    FVmin_l0{i} = double(subs(FVmin_l0tmp(i), x, x_range{i}));    
    FVmin_l0{i} = arrayfun(@(xx) (imag(xx) < 1e-8) * real(xx) + (imag(xx) >= 1e-8) * xx, FVmin_l0{i});
    FVmax_l0{i} = double(subs(FVmax_l0tmp(i), x, x_range{i}));
    FVmax_l0{i} = arrayfun(@(xx) (imag(xx) < 1e-8) * real(xx) + (imag(xx) >= 1e-8) * xx, FVmax_l0{i});
    
    % x - U
    Vmax_l0{i} = double(subs(pickelem(Vmax_l0x(x),i), x, x_range{i}));
    Uasint_l0{i} = double(sdata1(1 / 2 * Cmax_l0(i) .* Vmax_l0{i}.^2));
    Uel_xmax{i} = cumtrapz(x_range{i}, FVmax_l0{i} - FVmin_l0{i});
    uel_xmax{i} = Uel_xmax{i} ./ double(subs(Vol_l0(i), x, x_range{i}));    
end

%%
myfig(10, 'x - F(x) varying l_0')
for i = 1:length(l0_range)
    subplot(3,1,i); hold on
    plot(x_range{i} / l0_range(i), FVmin_l0{i}, plcol(i))
    plot(x_range{i} / l0_range(i), FVmax_l0{i}, '--', 'DisplayName', ['$l_0$ = ' num2str(l0_range(i), '%.3e')])
    addlabels("$x / l_0$ [-]", "F(x) [N]", "$x / l_0$ vs $F(x)$")
    xlim("padded"); ylim("padded")
    legend('FontWeight','bold', 'Location','best')
end
myfig(11, 'x - U(x) and u(x) varying l_0')
for i = 1:length(l0_range)
    subplot(2,1,1); hold on
    plot(x_range{i} / l0_range(i), Uel_xmax{i}, plcol(i))
    plot(x_range{i} / l0_range(i), Uasint_l0{i}, [plcol(i) '--'])
    addlabels("$x / l_0$ [-]", "Uel(x) [J]", "$x / l_0$ vs $U_{el}(x)$")
    xlim("padded"); ylim("padded")    
    
    subplot(2,1,2); hold on
    plot(x_range{i} / l0_range(i), uel_xmax{i}, plcol(i), 'DisplayName', ['$l_0$ = ' num2str(l0_range(i), '%.3e') ' $|$ ' '$\xi_0$ = ' num2str(xi0_range(i), '%.3e')])
    addlabels("$x / l_0$ [-]", "uel(x) [J/m^3]", "$x / l_0$ vs $u_{el}(x)$")
    legend('Location', 'best')
    xlim("padded"); ylim("padded")
end



%% U(x), u(x): Plane strain varying l_0 and xi_0
% x_range_eff = cell(size(l0_range));
% C_l0 = sdata1(pstrain.C, 'except', l_0);
% Vmax_l0 = sdata1(pstrain.Vmax, 'except', l_0);
% C_vec = cell(size(l0_range)); C_minval = zeros(size(l0_range)); C_maxval = zeros(size(l0_range));
% Vmax_vec = cell(size(l0_range)); Vmax_vectmp = cell(size(l0_range)); V_vec = cell(size(l0_range));
% V_minstr = cell(size(l0_range)); V_maxstr = cell(size(l0_range));
% Q_vec = cell(size(l0_range)); Q_vectmp = cell(size(l0_range)); 
% Q_maxstr = cell(size(l0_range)); Q_minstr = cell(size(l0_range));
% 
% myfig(10,"Q - V");
% for i = 1:length(l0_range)
%     x_range_eff{i} = (double(sdata2(tf_0)) + [logspace(-9, -6, 100) 2e-6:2e-5:(0.5 * l0_range(i))]);
%     Vmax_vectmp{i} = double(subs(Vmax_l0, {x, l_0}, {x_range_eff{i}, l0_range(i)}));
% 
%     C_vec{i} = double(subs(C_l0, {x, l_0}, {x_range_eff{i}, l0_range(i)}));
%     C_minval(i) = min(C_vec{i});
%     C_maxval(i) = max(C_vec{i});
% 
%     Q_vectmp{i} = C_vec{i} .* Vmax_vectmp{i};
%     st = abs(mean(diff(Q_vectmp{i})));
%     Q_vec{i} = min(Q_vectmp{i}):st:max(Q_vectmp{i}); 
%     Vmax_vec{i} = sort(interp1(Q_vec{i}, Vmax_vectmp{i}, Q_vec{i}), 'ascend');
%     Q_maxstr{i} = 0 : min(Q_vectmp{i}) / (length(Q_vec{i})-1) : min(Q_vectmp{i}); % steeper since the slope is 1 / Cmin
%     Q_minstr{i} = unique([Q_maxstr{i} Q_vec{i}]); % less steep since the slope is 1 / Cmax
% 
%     % Padding
%     Vmax_vec{i} = [Vmax_vec{i}(1) * ones(1, length(Q_minstr{i}) - length(Q_vec{i})) Vmax_vec{i}];
%     Q_vec{i} = [Q_vec{i}(1) * ones(1, length(Q_minstr{i}) - length(Q_vec{i})) Q_vec{i}];
%     Q_maxstr{i} = [Q_maxstr{i} Q_maxstr{i}(end) * ones(1, length(Q_minstr{i}) - length(Q_maxstr{i}))];
% 
%     V_maxstr{i} = Q_maxstr{i} / C_minval(i); 
%     V_minstr{i} = Q_minstr{i} / C_maxval(i);
%     subplot(2, 2, i + 0.5 * (i == 3))
%     hold on
%     plot(Q_vec{i}, Vmax_vec{i}, 'DisplayName', "$V_{BD}$", "LineWidth", 1.5)
%     plot(Q_minstr{i}, V_minstr{i}, 'DisplayName', "Min. str.", "LineWidth", 1.5)
%     plot(Q_maxstr{i}, V_maxstr{i}, '--' ,'DisplayName', "Max. str.", "LineWidth", 1.5)
%     if i == 3, legend('Location','best'); end
%     addlabels("Q [A]", "V [V]", ['$l_0$ = ' num2str(l0_range(i), '%.3e')])
%     xlim("padded"); ylim("padded")
% end

% %%
% Uel_xmax = cell(size(l0_range));
% uel_xmax = cell(size(l0_range));
% U_asint = cell(size(l0_range));
% x_range_eff = cell(size(l0_range));
% 
% ratio_xi0_l0 = double(sdata1(xi_0 / l_0));
% xi0_range = ratio_xi0_l0 * l0_range;
% Vol_l0xi0 = sdata1(pstrain.Vol, 'except', {l_0, xi_0}, 's', {l_0, l0_range, xi_0, xi0_range});
% 
% 
% myfig(11, 'x - U(x) and u(x) varying l_0 and xi_0')
% for i = 1:length(l0_range)
%     U_asint{i} = double(sdata1(1 / 2 * C_maxval(i) .* Vmax_vec{i}.^2));
%     Uel_xmax{i} = trapz(Q_maxstr{i}, V_maxstr{i}) + cumtrapz(Q_vec{i}, Vmax_vec{i}) - cumtrapz(Q_minstr{i}, V_minstr{i});
%     Voltmp = double(subs(Vol_l0xi0(i), {l_0, xi_0, x}, {l0_range(i), xi0_range(i), x_range_eff{i}}));
%     uel_xmax{i} = Uel_xmax{i} ./ Voltmp;
% 
%     subplot(2,1,1); hold on
%     plot(x_range_eff{i} / l0_range(i), Uel_xmax{i}, plcol(i))
%     plot(x_range_eff{i} / l0_range(i), U_asint{i}, [plcol(i) '--'])
%     addlabels("$x_{MAX} / l_0$ [-]", "$U_{el}$ [J]", "$x_{MAX} / l_0$ vs $U_{el}$")
% 
%     subplot(2,1,2); hold on
%     plot(x_range_eff{i} / l0_range(i), uel_xmax{i}, plcol(i), 'DisplayName', ['$l_0$ = ' num2str(l0_range(i), '%.3e') ' $|$ ' '$\xi_0$ = ' num2str(xi0_range(i), '%.3e')])
%     addlabels("$x_{MAX} / l_0$ [-]", "$u_{el} [J/m^3]$", "$x_{MAX} / l_0$ vs $u_{el}$")
%     legend('Location', 'best')
% end


