function [varargout] = compute_geometry(t_f, varargin)
    syms epsilon_1(x) epsilon_2(x) epsilon_3(x) w_0 tp_0 l_0 epsilon_p epsilon_f xi xi_0
    if length(varargin) == 1
        switch varargin{1}
            case "PLANE_STRESS"
                pstress.l = l_0 * (1 + epsilon_1(x));
                pstress.t_p = tp_0 * (1 + epsilon_3(x));
                pstress.w = w_0;
                pstress.A = pstress.l * pstress.w;
                dA = pstress.w * (1 + epsilon_1(x)); % * dxi
                dCp = dA * epsilon_p / pstress.t_p;
                dCf = dA * epsilon_f / t_f;
                pstress.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
                pstress.C = int(pstress.dC, xi);
                pstress.C = subs(pstress.C, xi, xi_0 + l_0) - subs(pstress.C, xi, xi_0);    
                varargout{1} = pstress;
            case "PLANE_STRAIN"
                pstrain.l = l_0 * (1 + epsilon_1(x));
                pstrain.t_p = tp_0;
                pstrain.w = w_0 * (1 + epsilon_2(x));
                pstrain.A = pstrain.l * pstrain.w;
                dA = pstrain.w * (1 + epsilon_1(x)); % * dxi
                dCp = dA * epsilon_p / pstrain.t_p;
                dCf = dA * epsilon_f / t_f;
                pstrain.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
                pstrain.C = int(pstrain.dC, xi);
                pstrain.C = subs(pstrain.C, xi, xi_0 + l_0) - subs(pstrain.C, xi, xi_0);
                varargout{1} = pstrain;
            case "NO_STRAIN"
                nostrain.l = l_0;
                nostrain.t_p = tp_0;
                nostrain.w = w_0;
                nostrain.A = nostrain.l * nostrain.w;
                dA = nostrain.w * (1 + epsilon_1(x)); % * dxi
                dCp = dA * epsilon_p / nostrain.t_p;
                dCf = dA * epsilon_f / t_f;
                nostrain.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
                nostrain.C = int(nostrain.dC, xi);
                nostrain.C = subs(nostrain.C, xi, xi_0 + l_0) - subs(nostrain.C, xi, xi_0);
                varargout{1} = nostrain;
            otherwise
                error("Provide correct deformation type")
        end    
    elseif isempty(varargin)
        pstress.l = l_0 * (1 + epsilon_1(x));
        pstress.t_p = tp_0 * (1 + epsilon_3(x));
        pstress.w = w_0;
        pstress.A = pstress.l * pstress.w;
        dA = pstress.w * (1 + epsilon_1(x)); % * dxi
        dCp = dA * epsilon_p / pstress.t_p;
        dCf = dA * epsilon_f / t_f;
        pstress.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
        pstress.C = int(pstress.dC, xi);
        pstress.C = subs(pstress.C, xi, xi_0 + l_0) - subs(pstress.C, xi, xi_0);

        pstrain.l = l_0 * (1 + epsilon_1(x));
        pstrain.t_p = tp_0;
        pstrain.w = w_0 * (1 + epsilon_2(x));
        pstrain.A = pstrain.l * pstrain.w;
        dA = pstrain.w * (1 + epsilon_1(x)); % * dxi
        dCp = dA * epsilon_p / pstrain.t_p;
        dCf = dA * epsilon_f / t_f;
        pstrain.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
        pstrain.C = int(pstrain.dC, xi);
        pstrain.C = subs(pstrain.C, xi, xi_0 + l_0) - subs(pstrain.C, xi, xi_0);

        nostrain.l = l_0;
        nostrain.t_p = tp_0;
        nostrain.w = w_0;
        nostrain.A = nostrain.l * nostrain.w;
        dA = nostrain.w * (1 + epsilon_1(x)); % * dxi
        dCp = dA * epsilon_p / nostrain.t_p;
        dCf = dA * epsilon_f / t_f;
        nostrain.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
        nostrain.C = int(nostrain.dC, xi);
        nostrain.C = subs(nostrain.C, xi, xi_0 + l_0) - subs(nostrain.C, xi, xi_0);

        varargout{1} = pstress;
        varargout{2} = pstrain;
        varargout{3} = nostrain;
    else
        error("Invalid number of input arguments")
    end




end