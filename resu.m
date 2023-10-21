1 DOF Cell Model in plane strain
Data
clear all; close all; clc;
set_env;
addpath("Functions and Scripts\");
addpath("1DOF\");

% Data --------------------------------------------------------------
% Constants
eps_0 = 8.85e-12; 			% F/m , permittivity of vacuum
epsilon1_max = 0.05;

pstrain = "PSTRAIN";
% Symbolic variables ------------------------------------------------
% Physical properties
syms nu Y_p epsilon_p epsilon_f EBD_p EBD_f real positive

% Geometry of the capacitor
syms x l_0 w_0 tp_0 xi xi_0 tf_0 dt_f dtf real positive
% t_f(x) armature distance at a certain xsi

% Physical quantities
syms Uel(x) V F(x,V) C(x)
% 
% % Strains: eps1 along the polymer, eps3 thickness strain of the polymer

syms epsilon_1(x) epsilon_2(x) epsilon_3(x) sigma_1(x)


Equations
syms eps1 eps2 eps3 s1 s2 s3   
% Equations ---------------------------------------------------------
eqstrain = [
eps1 == 1 / Y_p * (s1 - nu * (s2 + s3)),...
eps2 == 1 / Y_p * (s2 - nu * (s1 + s3)),...
eps3 == 1 / Y_p * (s3 - nu * (s1 + s2))
]

% Plane strain: eps2 = 0 and s3 = 0
soldef = solve(subs(eqstrain, {eps2,s3}, {0,0}), [s1, s2, eps3])
sstrain1(sigma_1)


clear eps1 eps2 eps3 s1 s2 s3


% Geometry ------------------------------
dt_f(x) = simplify(solve((x/2 - tf_0 / 2) / l_0 == (dtf / 2) / (l_0 - (xi - xi_0)), dtf), 25)
t_f(x) = tf_0 + dt_f;

p_strain = compute_geometry(t_f, "PSTRAIN")
l = p_strain.l;
t_p = p_strain.t_p;
w = p_strain.w;
A = l * w;

% Range limit
x_min = sdata1(tf_0)
x_max = sdata1(rhs(isolate(sstrain1(epsilon_1(x)) == epsilon1_max, x)))


dA = w * (1 + epsilon_1(x)) ; % * dxi

% Polymer infinitesimal capacitance
dCp = dA * epsilon_p / t_p
% Fluid infinitesimal capacitance
dCf = dA * epsilon_f / t_f

% Total infinitesimal capacitance
dC = ((2 / dCp) + (1 / dCf))^(-1)


Capacitance
% Total capacitance +++++++++++++++++++++++++++++++++++++++++++++++++
C(x) = int(dC, xi)
C(x) = subs(C(x), xi, xi_0 + l_0) - subs(C(x), xi, xi_0)
CC(x) = sstrain1(C, pstrain);
Cplane = simplify(limit(CC, x, tf_0))
C(x) = piecewise(x <= tf_0+1e-10, Cplane, x > tf_0+1e-10, CC(x))

% Min capacitance
Cmin = vpa(subs(sdata1(C), x, x_max), 4)

% Max C
Cmax = vpa(sdata1(Cplane), 4)


% Plot x - C(x)
myfig(1,"x - C(x)");
hold on
fplot(x, sdata1(C(x)), [double(sdata1(x_min)), double(sdata1(x_max))], 'LineWidth', 2)
xline(double(sdata1(x_max)), "--g", "x_{MAX}",'LabelOrientation','horizontal', 'FontWeight','bold')
hold off
title("x - C(x)")
xlabel("x [m]")
ylabel("C(x) [F]")


Max voltage
% Max voltage
% Vmax(x) = A / C * min(epsilon_p * EBD_p, epsilon_f * EBD_f)
makeassumptions
Vmax(x) = 2 * t_p / epsilon_p * min(epsilon_p * EBD_p, epsilon_f * EBD_f)

% Plot x - Vmax(x)
myfig(2,"x - Vmax(x)");
fplot(x, sdata1(Vmax(x),pstrain), [double(x_min) double(x_max)], 'LineWidth', 2)
title("$x - V_{max}(x)$")
xlabel("x [m]")
ylabel("$V_{max}$(x) [V]")


Force
% Force
Uel(x) = 2 * sdata1(1 / 2 * (sigma_1 * epsilon_1) * w * t_p * l, pstrain)
F(x,V) = simplify(diff(Uel, x) - V^2 / 2 * diff(sdata1(C), x))

% Min and max force for V = 0 and V = Vmax
FVmin = vpa(F(x, 0), 4);
FVmax= vpa(F(x, sdata1(Vmax,pstrain)), 4);

% Plot x - F(x) 
myfig(3,"x - F(x)"); hold on
fplot(x, FVmin, [double(sdata1(x_min)), double(sdata1(x_max))], 'LineWidth', 2, 'DisplayName', '$V_{min}$')
fplot(x, real(FVmax), [double(sdata1(x_min)), double(sdata1(x_max))], '--', 'LineWidth', 2, 'DisplayName', '$V_{max}$')
title("x - F(x)")
legend("Location","north")
xlabel("x [m]")
ylabel("F(x) [V]")


% Redefine x limits
x_range = double(x_min:1e-6:x_max);
[fvmax_peak, idx] = findpeaks(real(double(subs(FVmax, x_range))));
xstart = x_range(idx);
xend = double(min(sdata1(x_max), 0.01));


myfig(4,"x - F(x)")
hold on
fplot(x, FVmin, [xstart xend], 'LineWidth', 1.5, 'DisplayName', "$V_{MIN}$")
fplot(x, real(FVmax), [xstart xend], '--', 'LineWidth', 1.5, 'DisplayName', "$V_{MAX}$")
myxline(xstart, "--g", "x_{START}")
myxline(xend, "--g", "x_{MAX}")
hold off
legend("Location", "north")
title("x - F(x)")
xlim("padded")
xlabel("x [m]")
ylabel("F(x) [N]")

% Energy from x - F(x), use step of 2e-5
x_range = double(xstart:1e-5:xend);
FVmax_vec = double(subs(FVmax,x_range));
FVmin_vec = double(subs(FVmin,x_range));

Uel_Fx = double(trapz(x_range, FVmax_vec) - trapz(x_range, FVmin_vec))

Q - V
% Plot Q - V
C_vec = double(subs(sdata1(C), x, x_range));
Vmax_vec = double(subs(sdata1(Vmax, pstrain), x, x_range));
Q_vec = C_vec .* Vmax_vec;

V_vec = linspace(0, min(Vmax_vec), 100);
Qmaxstr = double(V_vec * Cmin);
Qminstr = double(V_vec * Cmax);

myfig(4,"Q - V"); clf
hold on
plot(Q_vec, Vmax_vec, 'DisplayName', "Voltage breakdown", "LineWidth", 1.5)
plot(Qminstr, V_vec, 'DisplayName', "Min. stretch", "LineWidth", 1.5)
plot(Qmaxstr, V_vec, 'DisplayName', "Max. stretch", "LineWidth", 1.5)
legend('Location','best')
xlabel("Q [A]")
ylabel("V [V]")
ylim([0, 1.1 * max(Vmax_vec)])
title("Q - V")
hold off



% Energy from Q - V
Uel_QV = trapz(Qmaxstr, V_vec) + max(Vmax_vec) * (Qminstr(end) - Qmaxstr(end)) - trapz(Qminstr, V_vec)

% Save results
res1dof_pstrain.l = l;
res1dof_pstrain.w = w;	
res1dof_pstrain.t_p = t_p;
res1dof_pstrain.A = A;
res1dof_pstrain.t_f = t_f;
res1dof_pstrain.C = C;	
res1dof_pstrain.Vmax = Vmax;
res1dof_pstrain.Uel = Uel;
res1dof_pstrain.F = F;
res1dof_pstrain.FVmin = FVmin;
res1dof_pstrain.FVmax = real(FVmax);
res1dof_pstrain.x_min = xstart;
res1dof_pstrain.x_max = xend;
res1dof_pstrain.x_range = x_range;
res1dof_pstrain.Uel_Fx = Uel_Fx;
res1dof_pstrain.Uel_QV = Uel_QV;
res1dof_pstrain.Cmin = Cmin;
res1dof_pstrain.Cmax = Cmax;
res1dof_pstrain.Q_vec = Q_vec;
res1dof_pstrain.V_vec = V_vec;
res1dof_pstrain.Vmax_vec = Vmax_vec;
res1dof_pstrain.Qmaxstr = Qmaxstr;
res1dof_pstrain.Qminstr = Qminstr;

