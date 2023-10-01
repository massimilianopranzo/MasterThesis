function [newexpr] = testsubs(expr)
    tmp = num2cell(symvar(expr));
    
    newexpr = subs(expr, tmp, 1:length(tmp));
end

