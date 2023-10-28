function [varargout] = compute_geometry1(t_f, structin, varargin)
    syms epsilon_2(x) epsilon_3(x) w_0 tp_0 t_p(x) w(x)

    if length(varargin) == 1
        
        switch varargin{1}
            case "PSTRAIN" % epsilon_2 = 0
                tmp_w = w_0;
                tmp_tp = tp_0 * (1 + epsilon_3);
            case "PSTRESS" % all epsilon_i ~= 0
                tmp_w = w_0 * (1 + epsilon_2(x));
                tmp_tp = tp_0 * (1 + epsilon_3(x));
            case "NO_STRAIN"
                tmp_w = w_0;
                tmp_tp = tp_0;
            case "GENERAL"
                structin.w = w(x);
                structin.t_p = t_p(x);
                structin = compute_geom(@(x)t_f(x), structin);
                varargout{1} = structin;
                return;
            otherwise
                error("Provide deformation: PSTRAIN | PSTRESS | NO_STRAIN | GENERAL")           
        end    
        structout = subs_fields(structin, tmp_w, tmp_tp);
        varargout{1} = structout;

    elseif isempty(varargin)
        tmp_w = w_0;
        tmp_tp = tp_0 * (1 + epsilon_3);
        structout = subs_fields(structin, tmp_w, tmp_tp);
        varargout{1} = structout;

        tmp_w = w_0 * (1 + epsilon_3);
        tmp_tp = tp_0 * (1 + epsilon_3);
        structout = subs_fields(structin, tmp_w, tmp_tp);
        varargout{2} = structout;

        tmp_w = w_0;
        tmp_tp = tp_0;
        structout = subs_fields(structin, tmp_w, tmp_tp, "NOSTRAIN");
        varargout{3} = structout;
    else
        error("Invalid number of input arguments")
    end
end

function structin = compute_geom(t_f, structin, varargin)
    syms epsilon_1(x) l_0 epsilon_p epsilon_f xi xi_0
    if ~isempty(varargin) && varargin{1} == "NO_STRAIN"
        epsilon_1(x) = 0;
    end
    structin.l = l_0 * (1 + epsilon_1(x));
    structin.A = structin.l * structin.w;
    structin.dA = structin.w * (1 + epsilon_1(x)); % * dxi
    structin.dCp = structin.dA * epsilon_p / structin.t_p;
    structin.dCf = structin.dA * epsilon_f / t_f;
    structin.dC = ((2 / structin.dCp) + (1 / structin.dCf)) ^ (-1);
    structin.C = int(structin.dC, xi);
    structin.C = subs(structin.C, xi, xi_0 + l_0) - subs(structin.C, xi, xi_0);
end

function structout = subs_fields(structin, tmp_w, tmp_tp, nostrain)
    syms epsilon_1(x) w(x) t_p(x)
    if exist("nostrain", "var") && strcmpi(nostrain, "NOSTRAIN")
        tmp_eps1 = 0;
    else
        tmp_eps1 = epsilon_1(x);
    end
    names = fieldnames(structin);
    for i = 1:length(names)
        name = names{i};
        structout.(name) = subs(structin.(name), {w, t_p, epsilon_1},{tmp_w, tmp_tp, tmp_eps1});
    end
end
