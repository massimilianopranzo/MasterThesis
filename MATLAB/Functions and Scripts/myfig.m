function [] = myfig(num, name)
    fig = figure(num); clf;
    set(fig, 'Name', string(name))%, 'Visible', 'off')
end

