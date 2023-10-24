function [varargout] = compute_geometry2(t_f, varargin)
    syms epsilon_2(x) epsilon_3(x) w_0 tp_0 
    
    if length(varargin) == 1
        switch varargin{1}
            case "PSTRAIN" % epsilon_2 = 0
                pstrain.w = w_0;
                pstrain.t_p = tp_0 * (1 + epsilon_3(x));
                pstrain = compute_geom(@(x)t_f(x), pstrain);
                varargout{1} = pstrain;
            case "PSTRESS" % all epsilon_i ~= 0
                pstress.w = w_0 * (1 + epsilon_2(x));
                pstress.t_p = tp_0 * (1 + epsilon_3(x));
                pstress = compute_geom(@(x)t_f(x), pstress);
                varargout{1} = pstress;
            case "NO_STRAIN"
                nostrain = struct();
                nostrain.t_p = tp_0;
                nostrain.w = w_0;
                nostrain = compute_geom(@(x)t_f(x), nostrain, "NO_STRAIN");
                varargout{1} = nostrain;
            otherwise
                error("Provide correct deformation type")
        end    
        
    elseif isempty(varargin)
        pstrain.w = w_0;
        pstrain.t_p = tp_0 * (1 + epsilon_3(x));
        pstrain = compute_geom(@(x)t_f(x), pstrain);
        varargout{1} = pstrain;

        pstress.w = w_0 * (1 + epsilon_2(x));
        pstress.t_p = tp_0 * (1 + epsilon_3(x));
        pstress = compute_geom(@(x)t_f(x), pstress);
        varargout{2} = pstress;

        nostrain = struct();
        nostrain.t_p = tp_0;
        nostrain.w = w_0;
        nostrain = compute_geom(@(x)t_f(x), nostrain, "NO_STRAIN");
        varargout{3} = nostrain;
    else
        error("Invalid number of input arguments")
    end
end

function structin = compute_geom(t_f, structin, varargin)
    syms epsilon_1(x) tf_0 l_0 l_c epsilon_p epsilon_f xi xi_0
    if ~isempty(varargin) && varargin{1} == "NO_STRAIN"
        epsilon_1(x) = 0;
    end
    structin.l_a = (l_0 - l_c) + (x - tf_0)^2 / (8 * (l_0 - l_c));
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
end