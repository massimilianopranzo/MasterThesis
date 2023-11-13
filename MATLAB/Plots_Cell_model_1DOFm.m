%% Detailed analysis of the 1DOF cell model
clear all; close all; clc;
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

%Equations
% Geometry ------------------------------

dt_f(x) = simplify(solve((x/2 - tf_0 / 2) / l_0 == (dtf / 2) / (l_0 - (xi - xi_0)), dtf), 25);
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
title("x - C(x) | Different def. condition")
xlim("padded")


%% C(x): Plane strain with epsilon_1 = 0 or epsilon_3 = 0
myfig(2,"x - C(x)"); clf; hold on
fplot(x, sdata1(pstrain.C), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane strain')
fplot(x, sdata1(subs(pstrain.C, epsilon_1, 0)), x_minmax, '*', 'LineWidth',2, 'DisplayName', '$\varepsilon_1 = 0$')
fplot(x, sdata1(subs(pstrain.C, epsilon_3, 0)), x_minmax, '+', 'LineWidth',2, 'DisplayName', '$\varepsilon_3 = 0$')
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','north')
title("x - C(x) | Plane strain")
xlim("padded")


%% C(x): Plane strain with epsilon_1 = 0 or epsilon_2 = 0
myfig(3,"x - C(x)"); clf; hold on
fplot(x, sdata1(pstress.C), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane stress')
fplot(x, sdata1(subs(pstress.C, epsilon_2, 0)), x_minmax, '*', 'LineWidth',2, 'DisplayName', '$\varepsilon_2 = 0$')
fplot(x, sdata1(subs(pstress.C, epsilon_3, 0)), x_minmax, '+', 'LineWidth',2, 'DisplayName', '$\varepsilon_3 = 0$')
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','north')
title("x - C(x) | Plane stress")
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
title("x - C(x) varying $tp_0$")
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
title("x - C(x) varying $w_0$")
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
title("x - C(x) varying $l_0$")
xlim("padded")


%% Vmax(x): Plane stress - Plane strain
myfig(7,"x - Vmax(x)"); clf; hold on
fplot(x, sdata1(pstress.Vmax), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane stress')
fplot(x, sdata1(pstrain.Vmax), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane strain')
myxline(double(x_min), "x_{MIN}");
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','southwest')
title("x - Vmax(x) | Different def. condition")
xlim("padded")


%% Uel(x): Plane stress - Plane strain
myfig(8,"x - Uel(x)"); clf; hold on;
fplot(x, sdata1(pstress.Uel), x_minmax, 'LineWidth',2, 'DisplayName', 'Plane stress')
fplot(x, sdata1(pstrain.Uel), x_minmax, '--', 'LineWidth',2, 'DisplayName', 'Plane strain')
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','northwest')
title("x - Uel(x) | Different def. condition")
xlim("padded")


%% F(x): Plane stress - Plane strain
myfig(9,"x - F(x)"); clf; hold on;
fplot(x, sdata1(pstress.FVmax), x_minmax, 'LineWidth', 2, 'DisplayName', '$V_{max}$ Plane stress')
fplot(x, sdata1(pstress.FVmin), x_minmax, '--', 'LineWidth', 2, 'DisplayName', '$V_{max}$ Plane stress')
fplot(x, sdata1(pstrain.FVmax), x_minmax, '*', 'LineWidth', 2, 'DisplayName', '$V_{max}$ Plane strain')
fplot(x, sdata1(pstrain.FVmin), x_minmax, 'o', 'LineWidth', 2, 'DisplayName', '$V_{max}$ Plane strain')
myxline(double(x_max), "x_{MAX}");
legend('FontWeight','bold', 'Location','northwest') 
title("x - F(x) | Different def. condition")


%% F(x): Plane strain with different l_0
x_rangetmp = double(linspace(sdata1(tf_0), 3e-3, 300));
l0_range = double(sdata1(l_0) * (1-0.7:0.35:1+0.7));
FVmin_l0 = cell(length(l0_range), 1);
FVmax_l0 = cell(length(l0_range), 1);

FVmin_l0tmp = subs(sdata1(pstrain.FVmin, 'except', l_0), x, x_rangetmp);
FVmax_l0tmp = subs(sdata1(pstrain.FVmax, 'except', l_0), x, x_rangetmp);
x_range = cell(length(l0_range), 1);

myfig(10, "x - F(x) varying $l_0$"); hold on
for i = 1:length(l0_range)
    
    FVmin_l0{i} = double(subs(FVmin_l0tmp, l_0, l0_range(i)));
    FVmax_l0{i} = double(subs(FVmax_l0tmp, l_0, l0_range(i)));
    % [val, idx] = findpeaks(FVmax_l0{i});
    % FVmin_l0{i} = FVmin_l0{i}(FVmax_l0{i} <= val);
    % FVmax_l0{i} = FVmax_l0{i}(FVmax_l0{i} <= val);
    % x_range{i} = x_rangetmp(FVmax_l0{i} <= val);
    FVmin_l0{i} = FVmin_l0{i}(idx:end);
    FVmax_l0{i} = FVmax_l0{i}(idx:end);
    x_range{i} = x_rangetmp(idx:end);

    subplot(2,3,i); hold on;
    plot(x_range{i}, FVmin_l0{i}, plcol(i), 'LineWidth', 2, 'DisplayName', nameVmin)
    plot(x_range{i}, FVmax_l0{i}, [plcol(i) '--'], 'LineWidth', 2, 'DisplayName', nameVmax)
    myxline(double(x_range{i}(1)), "x_{MIN}");
    myxline(double(x_range{i}(end)), "x_{MAX}");
    title("$l_0$ = " + num2str(l0_range(i)) + ' [m]')
    xlim("padded")
    ylim("padded")
end

%% Energy and energy density
Uel_l0 = zeros(length(l0_range),1);
uel_l0 = zeros(length(l0_range),1);
xnorm = zeros(length(l0_range),1);

myfig(11, "x_max / l_0 - Uel(x) - uel(x)"); hold on
for i = 1:length(l0_range)
    Vol_l0 = sdata1(pstrain.Vol, 'except', l_0, 's', {x, x_range{i}(end)});
    Uel_l0(i) = trapz(x_range{i}, FVmax_l0{i}) - trapz(x_range{i}, FVmin_l0{i});
    uel_l0(i) = Uel_l0(i) / subs(Vol_l0, l_0, l0_range(i));
    
    xnorm(i) = x_range{i}(end) ./ l0_range(i);
end
subplot(2,1,1); hold on
    plot(xnorm, Uel_l0)
    title("x - $U_{el}(x)$ varying $l_0$")
    xlabel("$x_{MAX} / l_0 \, [-] (\to l_0 \downarrow )$")
    ylabel("$U_{el} \, [J]$")
    xlim("padded")
    
    subplot(2,1,2); hold on
    plot(xnorm, uel_l0)
    title("x - $u_{el}$(x) varying $l_0$")
    xlabel("$x_{MAX} / l_0 \, [-] (\to l_0 \downarrow )$")
    ylabel("$u_{el} \, [J/m^3]$")
    xlim("padded")
% sdata1(res_1dof_pstrain.C)
% cmax = res_1dof_pstrain.Cmax
% cmin = res_1dof_pstrain.Cmin
% max(res_1dof_pstrain.Vmax_vec)^2 / 2 * (cmax - cmin)
% max(res_1dof_pstrain.Vmax_vec)^2 / 2 * (cmax)

%%
% FVmax_vec = subs(sdata1(pstrain.FVmax), x, x_range);
% Uel_l0(i) = trapz(x_range, FVmax_l0{i}) - trapz(x_range, FVmin_l0{i});
% uel_l0(i) = Uel_l0(i) / subs(Vol_l0, l_0, l0_range(i));
% 
% Uel_x = sdata1(subs(pstrain.Uel, x, x  / l_0));
% uel_x = Uel_x / sdata1(pstrain.Vol);
% 
% myfig(13, "x_max / l_0 - Uel(x)"); hold on
% fplot(Uel_x, [1e-4 1e-3] / 0.025)
% title("x - $U_{el}(x)$")
% xlabel("$x / l_0 \, [-]$")
% ylabel("$U_{el} \, [J]$")
% xlim("padded")
% 
% myfig(14, "x / l_0 - u_{el}(x)"); hold on
% fplot(uel_x, [1e-4 1e-3])
% title("x - $u_{el}$(x)")
% xlabel("$x / l_0 \, [-]$")
% ylabel("$u_{el} \, [J/m^3]$")
% xlim("padded")




















