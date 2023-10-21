function [varargout] = compute_geometry2(t_f, varargin)
    syms epsilon_1(x) epsilon_2(x) epsilon_3(x) w_0 tp_0 l_0 l_c epsilon_p epsilon_f xi xi_0
    if length(varargin) == 1
        switch varargin{1}
            case "PSTRAIN"
                pstrain.l = l_0 * (1 + epsilon_1(x));
                pstrain.l_c = l_c;
                pstrain.l_a 
                pstrain.t_p = tp_0 * (1 + epsilon_3(x));
                pstrain.w = w_0;
                pstrain.A = pstrain.l * pstrain.w;
                dA = pstrain.w * (1 + epsilon_1(x)); % * dxi
                dCp = dA * epsilon_p / pstrain.t_p;
                dCf = dA * epsilon_f / t_f;
                pstrain.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
                pstrain.C = int(pstrain.dC, xi);
                pstrain.C = subs(pstrain.C, xi, xi_0 + l_0) - subs(pstrain.C, xi, xi_0);    
                varargout{1} = pstrain;
            case "PSTRESS"
                pstress.l = l_0 * (1 + epsilon_1(x));
                pstress.t_p = tp_0;
                pstress.w = w_0 * (1 + epsilon_2(x));
                pstress.A = pstress.l * pstress.w;
                dA = pstress.w * (1 + epsilon_1(x)); % * dxi
                dCp = dA * epsilon_p / pstress.t_p;
                dCf = dA * epsilon_f / t_f;
                pstress.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
                pstress.C = int(pstress.dC, xi);
                pstress.C = subs(pstress.C, xi, xi_0 + l_0) - subs(pstress.C, xi, xi_0);
                varargout{1} = pstress;
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
        pstrain.l = l_0 * (1 + epsilon_1(x));
        pstrain.t_p = tp_0 * (1 + epsilon_3(x));
        pstrain.w = w_0;
        pstrain.A = pstrain.l * pstrain.w;
        dA = pstrain.w * (1 + epsilon_1(x)); % * dxi
        dCp = dA * epsilon_p / pstrain.t_p;
        dCf = dA * epsilon_f / t_f;
        pstrain.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
        pstrain.C = int(pstrain.dC, xi);
        pstrain.C = subs(pstrain.C, xi, xi_0 + l_0) - subs(pstrain.C, xi, xi_0);

        pstress.l = l_0 * (1 + epsilon_1(x));
        pstress.t_p = tp_0;
        pstress.w = w_0 * (1 + epsilon_2(x));
        pstress.A = pstress.l * pstress.w;
        dA = pstress.w * (1 + epsilon_1(x)); % * dxi
        dCp = dA * epsilon_p / pstress.t_p;
        dCf = dA * epsilon_f / t_f;
        pstress.dC = ((2 / dCp) + (1 / dCf)) ^ (-1);
        pstress.C = int(pstress.dC, xi);
        pstress.C = subs(pstress.C, xi, xi_0 + l_0) - subs(pstress.C, xi, xi_0);

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

        varargout{1} = pstrain;
        varargout{2} = pstress;
        varargout{3} = nostrain;
    else
        error("Invalid number of input arguments")
    end




end