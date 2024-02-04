clear; close all; clc

% CHOOSE THE BUOY RADIUS
r = 2.5; % m radius

rho = 1030; % kg/m^3 sea water density
g = 9.81; % m/s^2 gravity acceleration

%% Reference buoy design 

r_ref=2.5; % [m] buoy radius (if this is changed, the data in the files should be changed too!)
d_ref=4.7; %[m] buoy draft
% V = 2*pi*r^2*Zmax; % [m^3] buoy submerged volume

SF = r/r_ref; % scaling factor 

% load data (from hydrodynamic software)
load('test12_MassDampStiffMatsRadSS_SmallCyl_311013.mat');
D=load('omega_addedmass_raddamp2.txt');
wave_forces = load('test12.2');

omega_ref = (2*pi./wave_forces(:,1))'; % vector of angular frequencies

Kb_ref = rho*g*pi*r_ref^2; % hydrostatic stiffness (N/m)

M_ref=1/inv_reduced_mass_matrix; % time-invariant mass contribution (M+Minf) (kg)
Mad_ref = interp1(D(:,1),D(:,2),omega_ref,'linear','extrap'); % frequency-dependent component of the added mass
Br_ref = interp1(D(:,1),D(:,3),omega_ref,'linear','extrap'); % radiation damping (N*s/m)
Br_ref(Br_ref<0) = 0;
Bext_ref = 2e3; % external damping (e.g., friction, hydrodynamics) (N*s/m) 
B_ref = Br_ref + Bext_ref; % total damping (external + radiation)

gamma_ref = rho*g*wave_forces(:,4);

% natural frequency
[~,im] = min(abs(omega_ref - sqrt(Kb_ref./(M_ref+Mad_ref))));
omega_nat_ref = omega_ref(im); % natural angular frequency
Tn_ref = 2*pi/omega_nat_ref; % natural period

%% Scaled buoy parameters (using Froude)

d = SF*d_ref; % buoy draft omega
omega = SF^-0.5*omega_ref;
M = SF^3*M_ref; % total mass 
Mad = SF^3*Mad_ref;
Kb = rho*g*pi*r^2; % hydrostatic stiffness
Br = SF^2.5*Br_ref;
Bext = SF^2.5*Bext_ref; % external damping 
B = Br + Bext;
gamma = SF^3*gamma_ref; % excitation coefficient 

[~,im] = min(abs(omega - sqrt(Kb./(M+Mad))));
omega_nat = omega(im); % natural angular frequency
Tn = 2*pi/omega_nat % natural period

% checks (should be zero)
% Kb/Kb_ref-SF^2 
% Tn/Tn_ref-SF^0.5

figure(1)

subplot(3,1,1)
hold on
plot(omega,M+Mad,'k')
grid on
xlabel('omega (rad/s)')
ylabel('Mass (floater + added mass) (kg)')

subplot(3,1,2)
hold on
plot(omega,Br,'k')
grid on
xlabel('omega (rad/s)')
ylabel('Radiation damping (Ns/m)')

subplot(3,1,3)
hold on
plot(omega,gamma,'k')
grid on
xlabel('omega (rad/s)')
ylabel('Wave excitation coefficient $\gamma$ (N/m)')
