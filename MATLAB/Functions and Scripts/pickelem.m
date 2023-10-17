function [out] = pickelem(vec,idx)
    g = @(v,i)v(i);
    out = g(vec, idx);
end

