function [newexpr] = sstrain1(expr, varargin)
    syms x l_0 nu tf_0 Y_p sigma_1(x) sigma_2(x) epsilon_1(x) epsilon_2(x) epsilon_3(x)
    
    eps1 = -1 + sqrt(1 + ((x - tf_0) / (2 * l_0))^2);
    
    if isstruct(expr)
        names = fieldnames(expr);
    end

    if isempty(varargin) || upper(varargin{1}) == "PSTRAIN"
        s1 = - Y_p * eps1 / (nu^2 - 1);
        s2 = - Y_p * nu * eps1 / (nu^2 - 1);
        eps3 = eps1 * nu / (nu - 1);
        if isstruct(expr)
            for i = 1:length(names)
                name = names{i};
                check_strain(expr.(name), "epsilon_2", "PSTRAIN");
                newexpr.(name) = subs(expr.(name), {sigma_1, sigma_2, epsilon_1, epsilon_3}, {s1, s2, eps1, eps3});
            end
        else
            check_strain(expr, "epsilon_2", "PSTRAIN");
            newexpr = subs(expr, {sigma_1, sigma_2, epsilon_1, epsilon_3}, {s1, s2, eps1, eps3});  
        end
       
    elseif upper(varargin{1}) == "PSTRESS"
        s1 = Y_p * eps1;
        eps2 = - eps1 * nu;
        eps3 = - eps1 * nu;
        if isstruct(expr)
            for i = 1:length(names)
                name = names{i};
                check_strain(expr.(name), "sigma_2", "PSTRESS");
                newexpr.(name) = subs(expr.(name), {sigma_1, epsilon_1, epsilon_2, epsilon_3}, {s1, eps1, eps2, eps3});
            end
        else
            check_strain(expr, "sigma_2", "PSTRESS");
            newexpr = subs(expr, {sigma_1, epsilon_1, epsilon_2, epsilon_3}, {s1, eps1, eps2, eps3});  
        end
    elseif upper(varargin{1}) == "NO_STRAIN"
        s1 = 0; s2 = 0;
        eps1 = 0; eps2 = 0; eps3 = 0;
        if isstruct(expr)
            for i = 1:length(names)
                name = names{i};
                newexpr.(name) = subs(expr.(name), {sigma_1, sigma_2, epsilon_1, epsilon_2, epsilon_3}, {s1, s2, eps1, eps2, eps3});
            end
        else
            newexpr = subs(expr, {sigma_1, sigma_2, epsilon_1, epsilon_2, epsilon_3}, {s1, s2, eps1, eps2, eps3});  
        end
    else
        error("Incorrect deformation condition.")
    end    
end

function check_strain(expr, str, deftype)
    if contains(string(expr), str)
        warning("Expression contains " + str + " not expected by " + deftype + " deformation")
    end
end

