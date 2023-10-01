% 
clear; close all; clc;
%

% Data --------------------------------------------------------------
% Constants
eps_0 = 8.85e-12; 			% F/m , permittivity of vacuum

% Geometry
% tp_0 = 25e-6; 				% m   , initial thickness of polymer layer
% l_0 = 50e-3 / 2; 			% m   , initial length of polymer layer

% Acrylic dielectric
% mu_DE = 20..50; 				% -   		, Shear modulus
% lambda_DE = 7..9; 			% -   		, Max stretch
% epsilon_p = 4..4.5 * eps_0;	% F/m 		, permittivity of poymeric layer
% EBD_DE = 70..120; 			% kV / mm   , Breakdown field
% ni = 0.3; 					%  -  , Poisson's ratio of polymer

% Fluid (seawater)
% epsilon_f = 80 * eps_0; 		% F/m , permittivity of fluid (seawater)


% Operational limits -------------------------------------------------
% VBD = EfBD * [h_f + epsilon_f / epsilon_p * (x - h_f)];
% h_f is the "thickness" of the fluid layer	 where the term in [] is minimum

% epsilon_i = lambda_DE - 1; 	% - , Max strain

% Symbolic variables ------------------------------------------------
% Physical properties
syms ni Y EfBD epsilon_p epsilon_f

% Geometry of the capacitor
syms x l_0 w tp_0 xsi t_f(x) 
% t_f(x) armature distance at a certain xsi

% Physical quantities
syms Uel(x) V F(x,V) C(x)

% Strains: eps1 along the polymer, eps3 thickness strain of the polymer
syms epsilon_1(x) epsilon_3(x) 

% Equations ---------------------------------------------------------
epsilon_1(x) = sqrt(1 + x^2 / (4 * l_0^2)) - 1;
epsilon_3(x) = epsilon_1(x) * ni;

l(x) = l_0 * (1 + epsilon_1(x));
t_p(x) = tp_0 * (1 + epsilon_3(x));
t_f(x) = (x / 2 - 2 * t_p) * (l_0 - xsi) / l_0; 

dA = w * (1 + epsilon_1) ; % * dxsi
% Polymer infinitesimal capacitance
dCp = (t_p * (1 + epsilon_3)) / (epsilon_p * dA);
% Fluid infinitesimal capacitance
dCf = t_f / (epsilon_f * dA);

% Total infinitesimal capacitance
dC = simplify((1 / dCp + 1 / dCf)^(-1))

% Total capacitance +++++++++++++++++++++++++++++++++++++++++++++++++
C(x) = int(dC, xsi);
C(x) = simplify(subs(C(x), xsi, l_0) - subs(C(x), xsi, 0))
% V-Q relation ++++++++++++++++++++++++++++++++++++++++++++++++++++++
V = Q / C(x);

% Force +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
F(x,V) = diff(Uel(x), x) - V^2 / 2 * diff(C(x), x);

