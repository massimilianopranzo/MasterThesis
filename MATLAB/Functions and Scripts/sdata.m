function [newexpr] = sdata(expr, varargin)
    syms nu Y_p epsilon_p epsilon_f EBD_p EBD_f l_0 w_0 tp_0 tf_0 xi_0
    eps_0 = 8.85e-12;

    allvars = {nu, Y_p, epsilon_p, epsilon_f, EBD_p, EBD_f, l_0, w_0, tp_0, tf_0, xi_0};
    values = {
        0.3         , ... nu
        2.5e9       , ... Y_p
        3.4 * eps_0 , ... epsilon_p
        2.7 * eps_0 , ... epsilon_f
        303e6       , ... EBD_p
        157.40e6    , ... EBD_f
        50e-3 / 2   , ... l_0
        10e-2       , ... w_0
        25e-6       , ... tp_0
        100e-6       , ... tf_0
        3e-3        , ... xi_0
    };
    
    if ~isempty(varargin)
        if strcmp(varargin{1}, 'except') 
            if contains(string(expr), ["epsilon_1", "epsilon_2", "epsilon_3", "sigma_1"])
                expr = sstrain(expr);
            end
            [selvars, idx] = setdiff(string(allvars), string(varargin(2:end)), 'stable');
            selvars = sym2cell(str2sym(selvars));
            selvals = values(idx);
            newexpr = subs(expr, selvars, selvals);
        elseif varargin{1} == 1 && nargin == 2
            newexpr = sstrain(expr);
            newexpr = subs(newexpr, allvars, values);
        elseif varargin{1} == 1 && strcmp(string(varargin{2}), 'x')
            if contains(string(expr), ["epsilon_1", "epsilon_2", "epsilon_3", "sigma_1"])
                expr = sstrain(expr);
            end
            newexpr = subs(expr, allvars, values);
            newexpr = subs(newexpr, varargin{2}, varargin{3});
        elseif strcmp(string(varargin{1}), 'x') && nargin == 3
            if contains(string(expr), ["epsilon_1", "epsilon_2", "epsilon_3"])
                expr = sstrain(expr);
            end
            newexpr = subs(expr, varargin{1}, varargin{2});
        else
            [selvars, idx] = intersect(string(allvars), string(varargin));
            selvars = sym2cell(str2sym(selvars));
            selvals = values(idx);
            newexpr = subs(expr, selvars, selvals);
        end
    else        
        newexpr = subs(expr, allvars, values);
    end
    
%     if isempty(symvar(newexpr))
%         newexpr = double(vpa(newexpr, 4));
%     end




end

