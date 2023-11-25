function [var_out] = solve_adiab(var1lhs, var1rhs, var2rhs, eq)
    syms p1 p2 V1 V2 T1 T2 gamma_air

    eq_pv = p1 * V1^gamma_air == p2 * V2^gamma_air;
    eq_Tv = T1 * V1^(gamma_air-1) == T2 * V2^(gamma_air-1);
    eq_pT = T1 * p1^(1 / gamma_air - 1) == T2 * p2^(1 / gamma_air - 1);
    
    if strcmpi(eq, 'pv')
        var_out = solve(eq_pv, p1);
        var_out = subs(var_out, {V1, p2, V2}, {var1lhs, var1rhs, var2rhs});
    elseif strcmpi(eq, 'Vp')
        var_out = solve(eq_pv, V1);
        var_out = subs(var_out, {p1, V2, p2}, {var1lhs, var1rhs, var2rhs});
    elseif strcmpi(eq, 'pT')
        var_out = solve(eq_pT, p1);
        var_out = subs(var_out, {T1, p2, T2}, {var1lhs, var1rhs, var2rhs});
    elseif strcmpi(eq, 'Tp')
        var_out = solve(eq_pT, T1);
        var_out = subs(var_out, {p1, T2, p2}, {var1lhs, var1rhs, var2rhs});
    elseif strcmpi(eq, 'VT')
        var_out = solve(eq_Tv, V1);
        var_out = subs(var_out, {T1, V2, T2}, {var1lhs, var1rhs, var2rhs});
    elseif strcmpi(eq, 'TV')
        var_out = solve(eq_Tv, T1);
        var_out = subs(var_out, {V1, T2, V2}, {var1lhs, var1rhs, var2rhs});
    else
        error('Error: invalid input')
    end
end

