function [newexpr] = sdata2(expr, varargin)
    syms x
    
    [allvars, values] = def_data();

    is_defcond = 0;
    is_strains = 0;
    if contains(string(expr), ["epsilon_1", "epsilon_2", "epsilon_3", "sigma_1", "sigma_2", "sigma_3"])
        is_strains = 1;
    end 
    
    if find(cellfun(@(x)(isstring(x) || ischar(x)) && strcmpi("PSTRAIN", x), varargin), 1)
            is_defcond = 1;
            expr = sstrain2(expr, "PSTRAIN");
    elseif find(cellfun(@(x)(isstring(x) || ischar(x)) && strcmpi("PSTRESS", x), varargin), 1)
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
            if length(varargin{1}) > 1 && isnumeric(varargin{1})
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
        idx_except = find(cellfun(@(x)(isstring(x) || ischar(x)) && strcmpi("except", x), varargin));
        idx_only = find(cellfun(@(x)(isstring(x) || ischar(x)) && strcmpi("only", x), varargin));
        idx_subs = find(cellfun(@(x)(isstring(x) || ischar(x)) && strcmpi("s", x), varargin));
        if ~isempty(idx_except) % Subs all variables with default values except specific variables
            
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
        if ~isempty(idx_only) % Subs only specific variables with default values
            if ~isempty(exceptvars)
                error("Cannot use 'except' and 'only' at the same time.");
            end
            onlyvars = varargin{idx_only+1};
            [selected_vars, idx] = intersect(string(allvars), string(onlyvars), 'stable');
            selected_vars = sym2cell(str2sym(selected_vars));
            selected_values = values(idx);
            newexpr = subs(newexpr, selected_vars, selected_values);
        else
            idx_only = 0;
            onlyvars = [];
        end
        if ~isempty(idx_subs) % Subs specific variables with specific values
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
