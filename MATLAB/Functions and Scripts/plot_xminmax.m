function [outputArg1,outputArg2] = plot_xminmax(xmin, xmax, varargin)
    name = {'x_{MIN}','x_{MAX}'};
    if ~isempty(varargin)
        for i = 1:length(varargin)
            name = varargin{i};
        end
    end

    
    xline(xmin, 'g--', name{1}, 'LineWidth', 1.5, 'LabelOrientation', 'horizontal','FontName', 'times new roman', 'FontWeight','bold', 'HandleVisibility', 'off')
    xline(xmax, 'g--', name{2}, 'LineWidth', 1.5, 'LabelOrientation', 'horizontal','FontName', 'times new roman', 'FontWeight','bold', 'HandleVisibility', 'off')
    
end

