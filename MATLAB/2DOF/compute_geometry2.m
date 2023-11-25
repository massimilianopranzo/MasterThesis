function [varargout] = compute_geometry2(t_f, structin, varargin)
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

function structin = compute_geom(t_f, structin, varargin)
    syms epsilon_1(x) tf_0 l_0 l_c epsilon_p epsilon_f xi xi_0 tp_0 l_0 w_0 

    structin.l_a = (l_0 - l_c) + (x - tf_0)^2 / (8 * (l_0 - l_c)); % from linearisation of sqrt((l_0 - lc)^2 + (x - tf_0)^2 / 2)
    structin.A1 = l_c * structin.w;
    structin.A2 = structin.l_a * structin.w;
    structin.dA = structin.w * (1 + epsilon_1(x)); % * dxi
    structin.Cp1 = structin.A1 * epsilon_p / structin.t_p;
    structin.Cf1 = structin.A1 * epsilon_f / t_f(tf_0);
    structin.C1 = ((2 / structin.Cp1) + (1 / structin.Cf1)) ^ (-1);
    structin.dCp2 = structin.dA * epsilon_p / structin.t_p;
    structin.dCf2 = structin.dA * epsilon_f / t_f(x);
    structin.dC2 = ((2 / structin.dCp2) + (1 / structin.dCf2))^(-1);
    structin.C2 = int(structin.dC2, xi);
    structin.C2 = subs(structin.C2, xi, xi_0 + l_0) - subs(structin.C2, xi, xi_0);
    w = structin.w;
    l_a = structin.l_a;
    t_p = structin.t_p;
    structin.Vol_p = 2 * w * t_p * (l_c + l_a);
    structin.Vol_f = w * (tf_0 * l_c + ((x + tf_0) * (l_0 - l_c) / 2) + xi_0 * x); % w * (tf0 rectangle + x trapezoid + xi_0 rectangle)
    structin.Vol = structin.Vol_p + structin.Vol_f;
    structin.Vol_0 = 2 * w_0 * tp_0 * l_0;
end
