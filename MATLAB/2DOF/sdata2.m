function [newexpr] = sdata2(expr, varargin)
    syms nu Y_p epsilon_p epsilon_f EBD_p EBD_f l_0 w_0 tp_0 tf_0 xi_0 x
    eps_0 = 8.85e-12;

    allvars = {nu, Y_p, epsilon_p, epsilon_f, EBD_p, EBD_f, l_0, w_0, tp_0, tf_0, xi_0};
    % allvarsx = {nu, Y_p, epsilon_p, epsilon_f, EBD_p, EBD_f, l_0, w_0, tp_0, tf_0, xi_0, x};
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

    idx_x = find(varargin == x);
    if ~isempty(idx_x)
        allvars{end+1} = x;
        values{end+1} = varargin{idx_x+1};
    end


    isdefcond = nargin>=2 && (strcmp(upper(varargin{1}), 'PSTRAIN') || strcmp(upper(varargin{1}), 'PSTRESS'));
    if nargin == 1
        newexpr = subs(expr, allvars, values);
        
    elseif nargin == 2 && isdefcond
        newexpr = sstrain2(expr, varargin{1});
        newexpr = subs(newexpr, allvars, values);
        
    elseif nargin >= 2 && sum(ismember(string(allvars), string(varargin{1}))) >= 1 && ~isnumeric(varargin{2})
        if allvars{end} == x && sum(contains(string(expr), ["epsilon_1", "epsilon_2", "epsilon_3", "sigma_1", "sigma_2", "sigma_3"])) >= 1
            expr = sstrain2(expr, 'PSTRAIN');
            warning('Provided x without deformation condition, PSTRAIN has been assumed.')
        end
        [selected_vars, idx] = intersect(string(allvars), string(varargin));
        selected_vars = sym2cell(str2sym(selected_vars));
        selected_values = values(idx);
        newexpr = subs(expr, selected_vars, selected_values);

    elseif nargin >= 2 && sum(ismember(string(allvars), string(varargin{1}))) >= 1 && isnumeric(varargin{2})
        if allvars{end} == x && sum(contains(string(expr), ["epsilon_1", "epsilon_2", "epsilon_3", "sigma_1", "sigma_2", "sigma_3"])) >= 1
            expr = sstrain2(expr, 'PSTRAIN');
            warning('Provided x without deformation condition, PSTRAIN has been assumed.')
        end
        newexpr = subs(expr, varargin{1:2:end}, varargin{2:2:end});
        
    elseif nargin >= 3 && strcmp(varargin{1}, 'except')
        varargin = string(varargin); varargin = varargin(2:end);
        [selected_vars, idx] = setdiff(string(allvars), string(varargin), 'stable');
        selected_vars = sym2cell(str2sym(selected_vars));
        selected_values = values(idx);
        newexpr = subs(expr, selected_vars, selected_values); 
    
    elseif nargin >= 4 && isdefcond && sum(ismember(string(allvars), string(varargin{2}))) >= 1 && isnumeric(varargin{3})
        newexpr = sstrain2(expr, varargin{1});
        newexpr = subs(newexpr, varargin{2:2:end}, varargin{3:2:end});
    
    elseif nargin >= 4 && isdefcond && sum(ismember(string(allvars), string(varargin{2}))) >= 1 && ~isnumeric(varargin{3})
        newexpr = sstrain2(expr, varargin{1});
        [selected_vars, idx] = intersect(string(allvars), string(varargin));
        selected_vars = sym2cell(str2sym(selected_vars));
        selected_values = values(idx);
        newexpr = subs(newexpr, selected_vars, selected_values);
    elseif nargin >= 4 && isdefcond && strcmp(varargin{2}, 'except')
        newexpr = sstrain2(expr, varargin{1});
        varargin = string(varargin); varargin = varargin(3:end);
        [selected_vars, idx] = setdiff(string(allvars), string(varargin), 'stable');
        selected_vars = sym2cell(str2sym(selected_vars));
        selected_values = values(idx);
        newexpr = subs(newexpr, selected_vars, selected_values);
    else
        error('Wrong input arguments');
    end
        
end

