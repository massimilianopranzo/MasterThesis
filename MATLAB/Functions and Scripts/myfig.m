function myfig(num, name)
    % close(figure(num));
    figure(num); clf;
    grid on; 
    set(gcf, 'DefaultFigureWindowStyle','docked')
    set(gcf, 'Name', string(name), 'Visible', 'on')
    set(gcf,'color',[1 1 1])
end

