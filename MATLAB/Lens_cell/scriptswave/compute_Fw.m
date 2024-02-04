function Fw = compute_Fw(ss_type, H, T, omega, gamma, t)
    % ss_type   -> 1 monochromatic, 2 poly-chromatic
    % H         -> wave height (scalar)
    % T         -> wave period (scalar)
    % omega     -> wave frequencies (vector)
    % gamma     -> wave amplitudes (vector)
    % t         -> time (vector)

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


end