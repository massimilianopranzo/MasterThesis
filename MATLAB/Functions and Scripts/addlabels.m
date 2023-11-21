function addlabels(x, y, varargin)
    xlabel(x)
    ylabel(y)
    
    if nargin > 2
        title(varargin{1})
    end
end

