function [] = myfig(num, name)
    set_env;
    fig = figure(num); clf;
    set(fig, 'Name', string(name), 'Visible', 'on')
end

