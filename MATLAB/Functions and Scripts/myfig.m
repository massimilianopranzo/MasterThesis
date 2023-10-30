function fig = myfig(num, name)
    fig = figure(num); clf;
    grid on; 
    set(fig, 'Name', string(name), 'Visible', 'on')
    set(gcf,'color',[1 1 1])
end

