function [newexpr] = sdata2(expr, varargin)
    syms nu Y_p epsilon_p epsilon_f EBD_p EBD_f l_0 w_0 tp_0 tf_0 xi_0 x
    eps_0 = 8.85e-12;

    allvars = {nu, Y_p, epsilon_p, epsilon_f, EBD_p, EBD_f, l_0, w_0, tp_0, tf_0, xi_0};
    values = def_data();

    is_defcond = 0;
    is_strains = 0;
    if contains(string(expr), ["epsilon_1", "epsilon_2", "epsilon_3", "sigma_1", "sigma_2", "sigma_3"])
        is_strains = 1;
    end 

    if sum(myismember(varargin, "PSTRAIN"))  
            is_defcond = 1;
            expr = sstrain2(expr, "PSTRAIN");
        elseif sum(myismember(varargin, "PSTRESS"))
            is_defcond = 1;
            expr = sstrain2(expr, "PSTRESS");
    end

    if is_defcond && length(varargin) > 1
        varargin = varargin(2:end);
    elseif is_defcond && length(varargin) == 1
        varargin = {};
    end

    if isempty(varargin)
        newexpr = subs(expr, allvars, values);

    elseif length(varargin) == 1
        if ~isstring(varargin{1})
            if length(varargin{1}) > 1 && sum(myisnumeric(varargin{1}))
                subsvars = varargin{1}(1:2:end);
                subsvalues = cell(varargin{1}(2:2:end));
                
                is_x = ~isempty(find(subsvars == x));
                if is_x && ~is_defcond && is_strains
                    warning("Provided x without deformation conditions. Plane strain is assumed.");
                    expr = sstrain2(expr, "PSTRAIN");
                end
                newexpr = subs(expr, subsvars, subsvalues);
            else
                subsvars = varargin{1};
                [selected_vars, idx] = intersect(string(allvars), string(subsvars), 'stable');
                selected_vars = sym2cell(str2sym(selected_vars));
                selected_values = values(idx);
                newexpr = subs(expr, selected_vars, selected_values);

            end
        else
            error("Unexpected string argument.");
        end

    elseif length(varargin) >= 2 && mod(length(varargin), 2) == 0 && (isstring(varargin{1}) || ischar(varargin{1}))
        if sum(myismember(varargin, "except")) % Subs all variables with default values except specific variables
            idx_except = myfindstr(varargin, "except");
            exceptvars = varargin{idx_except+1};
            [selected_vars, idx] = setdiff(string(allvars), string(exceptvars), 'stable');
            selected_vars = sym2cell(str2sym(selected_vars));
            selected_values = values(idx);
            newexpr = subs(expr, selected_vars, selected_values);
        else
            idx_except = 0;
            exceptvars = [];
            newexpr = expr;
        end
        if sum(myismember(varargin, "only")) % Subs only specific variables with default values
            if ~isempty(exceptvars)
                error("Cannot use 'except' and 'only' at the same time.");
            end
            idx_only = myfindstr(varargin, "only");
            onlyvars = varargin{idx_only+1};
            [selected_vars, idx] = intersect(string(allvars), string(onlyvars), 'stable');
            selected_vars = sym2cell(str2sym(selected_vars));
            selected_values = values(idx);
            newexpr = subs(newexpr, selected_vars, selected_values);
        else
            idx_only = 0;
            onlyvars = [];
        end
        if sum(myismember(varargin, "s")) % Subs specific variables with specific values
            idx_subs = myfindstr(varargin, "s");
            subsvars = {varargin{idx_subs+1}{1:2:end}};
            is_x = ~isempty(find(subsvars == x));
            
            if is_x && ~is_defcond && is_strains
                warning("Provided x without deformation conditions. Plane strain is assumed.");
                newexpr = sstrain2(newexpr, "PSTRAIN");
            end
            subsvalues = {varargin{idx_subs+1}{2:2:end}};
            newexpr = subs(newexpr, subsvars, subsvalues);
        else
            idx_subs = 0;
            subsvars = [];
        end

        if ~isempty(exceptvars) && ~isempty(subsvars) && ~isempty(setdiff(string(subsvars), string(exceptvars)))
            subsvars = string(setdiff(string(subsvars), string(exceptvars), 'stable'));
            str = "";
            for i = 1:length(subsvars)
                if i == length(subsvars)
                    str = str + subsvars(i);
                else
                    str = str + subsvars(i) + ", ";
                end
            end
            error("The variables " + str + " have been already substituted by 'except'.");
        
            
        end

    else
        error("Unexpected number of arguments.");
    end
        
end

function indexes = myismember(arg1, arg2)
    if ~iscell(arg1)
        arg1 = cell(arg1);
    end
    indexes = zeros(1, length(arg1));
    for i = 1:length(arg1)
        if isstring(arg1{i}) || ischar(arg1{i})
            memb = ismember(arg1{i}, arg2);
            indexes(i) = memb;
        end
    end
end

function indexes = myfindstr(arg1, arg2)
    if length(arg1) == 1
        if isstring(arg1) || ischar(arg1)
            if strcmp(arg1, arg2)
                indexes = 1;
            end
        end
    else
        indexes = [];
        for i = 1:length(arg1)
            if isstring(arg1{i}) || ischar(arg1{i})
                if strcmp(arg1{i}, arg2)
                    indexes = [indexes, i];
                end
            end
        end
    end
end

function indexes = myisnumeric(arg)
    indexes = zeros(1, length(arg));
    for i = 1:length(arg)
        if isnumeric(arg{i})
           indexes(i) = 1; 
        end
    end
end
