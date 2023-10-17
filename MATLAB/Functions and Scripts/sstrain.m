function [newexpr] = sstrain(expr)
    syms x l_0 nu tf_0 epsilon_1(x) Y_p
    
    eps1 = -1 + sqrt(1 + ((x - tf_0) / (2 * l_0))^2);

    if contains(string(expr), "sigma_1")
        syms sigma_1(x)
        s1 = - Y_p * epsilon_1(x) / (nu^2 - 1);
        expr = subs(expr, sigma_1(x), s1);
    end  

    if contains(string(expr), "epsilon_3")% Plane stress
        syms epsilon_3(x)
        eps3 = eps1 * nu / (nu - 1);
        newexpr = subs(expr, {epsilon_1(x), epsilon_3(x)}, {eps1 ,eps3});
    elseif contains(string(expr), "epsilon_2") % Plane strain
        syms epsilon_2(x)
        eps2 = eps1 * nu / (nu - 1);
        newexpr = subs(expr, {epsilon_1(x), epsilon_2(x)}, {eps1 ,eps2});
    elseif contains(string(expr), "epsilon_1")
        newexpr = subs(expr, epsilon_1(x), eps1);
    else
        warning("No strain variable found.")
        newexpr = expr;
    end    
end

