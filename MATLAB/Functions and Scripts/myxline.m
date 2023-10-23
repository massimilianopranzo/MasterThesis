function myxline(x, name, style, orientation)
    
    if ~exist("style", "var")
        style = '--g';
    end
    if ~exist("orientation", "var")
        orientation = 'horizontal';
    end

    xline(x, style, name, 'LabelOrientation', orientation, 'FontName', 'times new roman', 'FontWeight','bold', 'HandleVisibility', 'off')
end

