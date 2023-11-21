function myfig(num, name)
    close(figure(num)); set(0,'DefaultFigureWindowStyle','docked');
    figure(num); clf; grid on; hold on;
    set(gcf, 'DefaultFigureWindowStyle','docked')
    set(gcf, 'Name', string(name), 'Visible', 'on')
    set(gcf,'color',[1 1 1])
end

