function myyline(y, name, style, orientation)
    
    % if ~exist("style", "var")
    %     style = '--g';
    % end
    if ~exist("orientation", "var")
        orientation = 'horizontal';
    end

    yline(y, style, name, 'LabelOrientation', orientation, 'FontName', 'times new roman', 'FontWeight','bold', 'HandleVisibility', 'off')
end
