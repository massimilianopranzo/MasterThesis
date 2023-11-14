function col = plcol(i, l)
    if ~exist("l", "var")
        l = '';
    end
    col = ['r', 'g', 'b', 'c', 'm', 'k', 'y'];
    col = [col(i), l];
end
