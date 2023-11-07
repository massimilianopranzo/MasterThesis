function leg = placelegend(m, n, p, leg, lw)
    if ~exist("lw", "var")
        lw = 1.5;
    end
    tt = subplot(m, n, p); hold on
    set(tt, 'Visible', 'off')
    for i = 1:length(leg.String)
        plot(0, NaN, plcol(i), 'LineWidth', lw)
    end
    leg = legend(leg.String, 'Location', 'north');
end

