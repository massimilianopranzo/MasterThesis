function [varargout] = compute_geometry2(t_f, varargin)
    syms epsilon_1(x) epsilon_2(x) epsilon_3(x) w_0 tp_0 tf_0 l_0 l_c epsilon_p epsilon_f xi xi_0
    if length(varargin) == 1
        switch varargin{1}
            case "PSTRAIN"
                pstrain.l = l_0 * (1 + epsilon_1(x));
                pstrain.w = w_0;
                pstrain.t_p = tp_0 * (1 + epsilon_3(x));
                pstrain.l_a = (l_0 - l_c) + (x - tf_0)^2 / (8 * (l_0 - l_c));
                pstrain.A = pstrain.l * pstrain.w;
                dA = pstrain.w * (1 + epsilon_1(x)); % * dxi

                pstrain.Cp1 = pstrain.A * epsilon_p / tp_0;
                pstrain.Cf1 = pstrain.A * epsilon_f / t_f(tf_0);
                pstrain.C1 = ((2 / pstrain.Cp1) + (1 / pstrain.Cf1)) ^ (-1);

                pstrain.dCp2 = dA * epsilon_p / pstrain.t_p;
                pstrain.dCf2 = dA * epsilon_f / t_f(x);
                pstrain.dC2 = ((2 / pstrain.dCp2) + (1 / pstrain.dCf2))^(-1);
                pstrain.C2 = int(pstrain.dC2, xi);
                pstrain.C2 = subs(pstrain.C2, xi, xi_0 + l_0) - subs(pstrain.C2, xi, xi_0);    
                varargout{1} = pstrain;
            case "PSTRESS"
                pstress.l = l_0 * (1 + epsilon_1(x));
                pstress.w = w_0 * (1 + epsilon_2(x));
                pstress.t_p = tp_0 * (1 + epsilon_3(x));
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
        pstrain.w = w_0;
        pstrain.t_p = tp_0 * (1 + epsilon_3(x));
        pstrain.A = pstrain.l * pstrain.w;
        dA = pstrain.w * (1 + epsilon_1(x)); % * dxi

        pstrain.Cp1 = A * epsilon_p / tp_0;
        pstrain.Cf1 = A * epsilon_f / t_f(t_f0);
        pstrain.C1 = ((2 / Cp1) + (1 / Cf1)) ^ (-1);
        
        pstrain.dCp2 = dA * epsilon_p / pstrain.t_p;
        pstrain.dCf2 = A * epsilon_f / t_f;
        pstrain.dC2 = ((2 / dCp2) + (1 / dCf2))^(-1);
        pstrain.C2 = int(pstrain.dC2, xi);
        pstrain.C2 = subs(pstrain.C2, xi, xi_0 + l_0) - subs(pstrain.C2, xi, xi_0);    
        varargout{1} = pstrain;

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
        varargout{2} = pstress;

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
        varargout{3} = nostrain;
    else
        error("Invalid number of input arguments")
    end




end