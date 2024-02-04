
function [Ass, Bss, Css] = ss_identification(ssdim, omega, Mad, Br)

    Kr=1i*omega.*Mad+Br;
    gfr=idfrd(Kr, omega, 0);
    ms = ssest(gfr, ssdim, 'focus', 'stability');
    % figure(88)
    
    A = ms.A;
    B = ms.B;
    C = ms.C;
    D = ms.D;
    
    [z, p, gain] = ss2zp(A, B, C, D, 1);
    
    [mmz, iz] = max(real(z));
    z(iz) = 0;
    ss2 = ss(zpk(z, p, gain));
    Ass = ss2.a;
    Bss = ss2.b;
    Css = ss2.c;
    % Dss = ss2.d;

end