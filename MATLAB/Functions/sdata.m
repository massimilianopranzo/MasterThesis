function [newexpr] = sdata(expr, varargin)
    syms nu Y_p epsilon_p epsilon_f EBD_p EBD_f l_0 w tp_0 x epsilon_1(x) epsilon_3(x)
    eps_0 = 8.85e-12;

    allvars = {nu, Y_p, epsilon_p, epsilon_f, EBD_p, EBD_f, l_0, w, tp_0};
    values = {
        0.3         , ... nu
        1.5e9       , ... Y_p
        4.5 * eps_0 , ... epsilon_p
        2.5 * eps_0  , ... epsilon_f
        500e6      , ... EBD_p
        100e6       , ... EBD_f
        50e-3 / 2   , ... l_0
        10e-2           , ... w
        25e-6       , ... tp_0
    };
    
    if ~isempty(varargin)
        if strcmp(varargin{1}, 'all')  
            eps1 = -1 + sqrt(1 + (x / (2 * l_0))^2);
            eps3 = eps1 * nu / (nu - 1);
            newexpr = subs(expr, {epsilon_1(x), epsilon_3(x)}, {eps1 ,eps3});
            newexpr = subs(newexpr, allvars, values);
        else
            [selvars, idx] = intersect(string(allvars), string(varargin));
            selvars = sym2cell(str2sym(selvars));
            selvals = values(idx);
            newexpr = subs(expr, selvars, selvals);
        end
    else        
        newexpr = subs(expr, allvars, values);
    end
    
    if isempty(symvar(newexpr))
        newexpr = double(newexpr);
    end
    




end

