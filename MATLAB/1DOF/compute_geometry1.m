function [varargout] = compute_geometry1(t_f, varargin)
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

        nostrain.t_p = tp_0;
        nostrain.w = w_0;
        nostrain = compute_geom(@(x)t_f(x), nostrain, "NO_STRAIN");
        varargout{3} = nostrain;
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