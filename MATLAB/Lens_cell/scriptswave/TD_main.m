
ss_type = 1; % 1 monochromatic, 2 polychormatic
H = 4; % m wave height OR significant wave height (Hs) 
T = 10; % s period OR energy period (Te) 

Kes = 1e0*Kb;
Bes = 1e4*Bext; 
Vmax = 20; % m/s 

dt = 1e-2; % s
t = (0:dt:100*T)'; % time vector 

if ss_type == 1
    Fw = interp1(omega,gamma,2*pi/T)*H/2*sin(2*pi/T*t); 
elseif ss_type == 2
    Som=262.9*T^(-4)*H^2*omega.^(-5).*exp(-1054*T^(-4)*omega.^(-4));
    figure(2)
    hold on
    plot(omega,Som,'k')

    Fw = 0;
    rng(H^2)
    for i = 1:length(omega)
        phi = 2*pi*rand();
        Fw = Fw + gamma(i)*sqrt(2*(omega(2)-omega(1))*Som(i))*sin(omega(i)*t+phi);
    end

else
    error('invalid sea state')
end

%% state space identification - radiation
ssdim=3;

Kr=1i*omega.*Mad+Br;
gfr=idfrd(Kr,omega,0);
ms = ssest(gfr,ssdim,'focus','stability');
% figure(88)

A=ms.A;
B=ms.B;
C=ms.C;
D=ms.D;

[z,p,gain]=ss2zp(A,B,C,D,1);

[mmz,iz]=max(real(z));
z(iz)=0;
ss2=ss(zpk(z,p,gain));
Ass=ss2.a;
Bss=ss2.b;
Css=ss2.c;
% Dss=ss2.d;

figure
compare(gfr,ms,ss2)

%% PTO

Kpto = 0;
Bpto = 0; 

%% Dynamic simulation
% load grid data (z1, z2, Fs1, Fs2, V1, V2)
data_grids;

alpha_vec = linspace(0,1,15);
res_sim = cell(1,length(alpha_vec));
sim('Buoy_TD_model')
for i = 1:length(alpha_vec)
    alpha = alpha_vec(i);
    res_sim{i} = sim('Piston.slx');
end
%%
figure;
hold on
for k = 14:1:length(alpha_vec)
    plot(res_sim{k}.Pos.Time,res_sim{k}.Pos.Data)
end

max_amp = cellfun(@(x) max(x.Pos.Data(x.Pos.Time > 10 * T)), res_sim, 'UniformOutput', true);

figure;
plot(alpha_vec, max_amp, 'o')
%%
figure;
plot(Pos.Time,Pos.Data,'k')
hold on 
grid on 
xlabel('time (s)')
ylabel('Displacement (m)')

figure;
plot(Pos.Time,1e-3*(Kpto*Pos.Data.*Vel.Data+Bpto*Vel.Data.^2),'k')
hold on 
grid on 
xlabel('time (s)')
ylabel('PTO inst. power (kW)')

if ss_type ==1
    I = find(Pos.Time>t(end)-10*T);
    P_avg = trapz(Pos.Time(I),Bpto*Vel.Data(I).^2)/(Pos.Time(I(end))-Pos.Time(I(1)));
else  
    P_avg = trapz(Pos.Time,Bpto*Vel.Data.^2)/t(end);
end


%%
figure;
plot(Pos.Data,Vel.Data .* FG.Data)