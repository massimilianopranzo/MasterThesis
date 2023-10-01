function [newexpr] = subsstrain(expr, varargin)
    syms x l_0 nu epsilon_1(x) epsilon_3(x)

    if length(varargin) == 1
        if varargin{1} == 1
            eps1 = -1 + sqrt(1 + (x / (2 * l_0))^2);
            newexpr = subs( expr, epsilon_1(x), eps1);
        elseif varargin{1} == 3
            eps3 = epsilon_1(x) * nu / (nu - 1);
            newexpr = subs( expr, epsilon_3(x), eps3);
        end
    elseif isempty(varargin)
        eps1 = -1 + sqrt(1 + (x / (2 * l_0))^2);
        eps3 = eps1 * nu / (nu - 1);
        newexpr = subs(expr, {epsilon_1(x), epsilon_3(x)}, {eps1 ,eps3});
    end

end

