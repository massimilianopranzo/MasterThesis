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
x_min = vpa(sdata1(pstrain.x_min), 4)
x_max = subs(sstrain1(pstrain.x_max), epsilon1_max, eps1_max);
x_max = vpa(sdata1(rhs(isolate(x_max, x))), 4)
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
    
    fplot(x, pickelem(C_tp0(x), i), x_minmax, 'LineWidth',2, 'DisplayName', name)
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
    fplot(x, pickelem(C_w0(x), i), x_minmax, 'LineWidth',2, 'DisplayName', name)
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
    fplot(x, pickelem(C_l0(x), i), x_minmax, 'LineWidth',2, 'DisplayName', name)
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
myfig(9,"x - F(x)"); clf; hold on;
fplot(x, sdata1(pstress.FVmax), x_minmax, 'LineWidth', 2, 'DisplayName', '$V_{max}$ Plane stress')
fplot(x, sdata1(pstress.FVmin), x_minmax, '--', 'LineWidth', 2, 'DisplayName', '$V_{max}$ Plane stress')
fplot(x, sdata1(pstrain.FVmax), x_minmax, '*', 'LineWidth', 2, 'DisplayName', '$V_{max}$ Plane strain')
fplot(x, sdata1(pstrain.FVmin), x_minmax, 'o', 'LineWidth', 2, 'DisplayName', '$V_{max}$ Plane strain')
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','northwest') 
addlabels("x [m]", "C(x) [F]", "x - F(x) | Different def. condition")


%% F(x): Plane strain varying l_0, plane strain
ratio_xi0_l0 = sdata1(xi_0 / l_0);
l0_range = double(sdata1(l_0) * (0.5:0.5:1.5));
xi0_range = ratio_xi0_l0 * l0_range;
x_range = double(sdata1(tf_0):1e-5:10e-3)';
FVmin_l0 = cell(size(l0_range));
FVmax_l0 = cell(size(l0_range));

FVmin_tmp = sdata1(pstrain.FVmin, 'except', {l_0, xi_0}, 's', {x, x_range});
FVmax_tmp = sdata1(pstrain.FVmax, 'except', {l_0, xi_0}, 's', {x, x_range});
myfig(10, "x - F(x) varying l_0"); hold on
for i = 1:length(l0_range)
    subplot(3,1,i); hold on
    FVmin_l0{i} = double(subs(FVmin_tmp, {l_0, xi_0}, {l0_range(i), xi0_range(i)}));
    FVmax_l0{i} = double(subs(FVmax_tmp, {l_0, xi_0}, {l0_range(i), xi0_range(i)}));
    [~, idx] = findpeaks(FVmax_l0{i});
    x_range_eff = x_range(idx:end);
    FVmin_l0{i} = FVmin_l0{i}(idx:end);
    FVmax_l0{i} = FVmax_l0{i}(idx:end);
    plot(x_range_eff, FVmin_l0{i}, 'DisplayName', '$V_{MIN}$')
    plot(x_range_eff, FVmax_l0{i}, '--', 'DisplayName', '$V_{MAX}$')
    plot_xminmax(x_range(1), x_range(end));
    addlabels("x [m]", "F(x) [N]", ['$l_0$ = ' num2str(l0_range(i), '%.3e')])
    xlim("padded"); ylim("padded")
    legend('FontWeight','bold', 'Location','north')
end


%% Energy and energy density
Uel_xmax = cell(size(l0_range));
uel_xmax = cell(size(l0_range));
Vol_tmp = sdata1(pstrain.Vol);
st = 5;
myfig(11, "x_max / l_0 - Uel | uel"); hold on
for i = 1:length(l0_range)
    k = 0;
    if double(sdata1(l_0)) ~= l0_range(i)
        for j = 1:st:length(x_range_eff)
            Uel_xmax{i}(j - k * st + k) = trapz(x_range_eff(1:st:j), FVmax_l0{i}(1:st:j),1) - trapz(x_range_eff(1:st:j), FVmin_l0{i}(1:st:j),1);
            uel_xmax{i}(j - k * st + k) = Uel_xmax{i}(j - k * st + k) / subs(Vol_tmp, {x, l_0, xi_0}, {x_range_eff(j), l0_range(i), xi0_range(i)});
            k = k + 1;   
        end
        xr = x_range_eff(1:st:end);
    else
        Uel_xmax{i} = res_1dof_pstrain.Uel_xmax(res_1dof_pstrain.x_range_eff <= x_range_eff(end));
        uel_xmax{i} = res_1dof_pstrain.uel_xmax(res_1dof_pstrain.x_range_eff <= x_range_eff(end));
        xr = res_1dof_pstrain.x_range_eff(res_1dof_pstrain.x_range_eff <= x_range_eff(end));
    end
    subplot(2,1,1); hold on
    plot(xr / l0_range(i), Uel_xmax{i}, 'LineWidth', 1.5, 'DisplayName', ['$l_0$ = ' num2str(l0_range(i), '%.3e')])
    addlabels("$x_{MAX} / l_0$ [-]", "$U_{el}$ [J]", "$x_{MAX} / l_0$ vs $U_{el}$")
    legend('Location', 'southeast')

    subplot(2,1,2); hold on
    plot(xr / l0_range(i), uel_xmax{i}, 'LineWidth', 1.5)
    addlabels("$x_{MAX} / l_0$ [-]", "$u_{el} [J/m^3]$", "$x_{MAX} / l_0$ vs $u_{el}$")
end
