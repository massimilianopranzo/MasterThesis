function [varargout] = compute_geometry1(t_f, structin, varargin)
    % If varargin is empty, compute geometry for all three cases and you have to pass the general case structure of 1DOF
    % If varargin is "PSTRAIN" | "PSTRESS" | "NO_STRAIN", structing is the general case structure of 1DOF and you get the structure for the specific case
    % If varargin is "GENERAL", you have to pass an empty struct and you get the general case structure of 1DOF
    syms epsilon_2(x) epsilon_3(x) w_0 tp_0 t_p(x) w(x)
    
    if isstruct(t_f) && ismember(structin, ["PSTRAIN", "PSTRESS", "NO_STRAIN"]) && isempty(varargin)
        varargin = {structin};
        structin = t_f;
        t_f = NaN;
    end

    no_strain = 0;
    if length(varargin) == 1
        switch varargin{1}
            case "PSTRAIN" % epsilon_2 = 0
                if isempty(fieldnames(structin))
                    error("Provide struct for general case")
                end
                tmp_w = w_0;
                tmp_tp = tp_0 * (1 + epsilon_3);
            case "PSTRESS" % sigma_2 = 0
                if isempty(fieldnames(structin))
                    error("Provide struct for general case")
                end
                tmp_w = w_0 * (1 + epsilon_2(x));
                tmp_tp = tp_0 * (1 + epsilon_3(x));
            case "NO_STRAIN"
                if isempty(fieldnames(structin))
                    error("Provide struct for general case")
                end
                tmp_w = w_0;
                tmp_tp = tp_0;
                no_strain = varargin{1}; 
            case "GENERAL"
                if ~isempty(fieldnames(structin))
                    error("Provide empty struct for general case")
                end
                structin.w = w(x);
                structin.t_p = t_p(x);
                structin = compute_geom(@(x)t_f(x), structin);
                varargout{1} = structin;
                return;
            otherwise
                error("Provide deformation: PSTRAIN | PSTRESS | NO_STRAIN | GENERAL")           
        end    
        structout = subs_fields(structin, tmp_w, tmp_tp, no_strain);
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
    syms epsilon_1(x) l_0 epsilon_p epsilon_f xi xi_0 tf_0
    structin.l = l_0 * (1 + epsilon_1(x));
    structin.A = structin.l * structin.w;
    structin.dA = structin.w * (1 + epsilon_1(x)); % * dxi
    structin.dCp = structin.dA * epsilon_p / structin.t_p;
    structin.dCf = structin.dA * epsilon_f / t_f;
    structin.dC = ((2 / structin.dCp) + (1 / structin.dCf)) ^ (-1);
    structin.C = int(structin.dC, xi);
    structin.C = subs(structin.C, xi, xi_0 + l_0) - subs(structin.C, xi, xi_0);
    w = structin.w;
    t_p = structin.t_p;
    l = structin.l;
    structin.Vol = w * 2 * t_p * l + w * (x - tf_0) / 2 * sqrt(l^2 - (x / 2)^2);
end

function structout = subs_fields(structin, tmp_w, tmp_tp, nostrain)
    syms epsilon_1(x) epsilon_2(x) epsilon_3(x) sigma_1(x) sigma_2(x) w(x) t_p(x)
    if strcmpi(nostrain, "NO_STRAIN")
        eps1 = 0; eps2 = 0; eps3 = 0; s1 = 0; s2 = 0;
    else
        eps1 = epsilon_1(x); eps2 = epsilon_2(x); eps3 = epsilon_3(x);
        s1 = sigma_1(x); s2 = sigma_2(x);
    end
    names = fieldnames(structin);
    for i = 1:length(names)
        name = names{i};
        structout.(name) = subs(structin.(name), {w, t_p, epsilon_1, epsilon_2, epsilon_3, sigma_1, sigma_2},{tmp_w, tmp_tp, eps1, eps2, eps3, s1, s2});
    end
end
