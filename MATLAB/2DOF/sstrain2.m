function [newexpr] = sstrain2(expr, varargin)
    syms x l_0 l_c nu tf_0 Y_p sigma_1(x) sigma_2(x) epsilon_1(x) epsilon_2(x) epsilon_3(x)
    
    eps1 = (x - tf_0)^2 / (8 * l_0 * (l_0 - l_c));
    
    if isempty(varargin) || upper(varargin{1}) == "PSTRAIN"
        s1 = - Y_p * eps1 / (nu^2 - 1);
        s2 = - Y_p * nu * eps1 / (nu^2 - 1);
        eps3 = eps1 * nu / (nu - 1);
        newexpr = subs(expr, {sigma_1, sigma_2, epsilon_1, epsilon_3}, {s1, s2, eps1, eps3});
    elseif upper(varargin{1}) == "PSTRESS"
        s1 = Y_p * eps1;
        eps2 = - eps1 * nu;
        eps3 = - eps1 * nu;
        newexpr = subs(expr, {sigma_1, epsilon_1, epsilon_2, epsilon_3}, {s1, eps1, eps2, eps3});
    else
        error("Incorrect deformation condition.")
    end    
end

