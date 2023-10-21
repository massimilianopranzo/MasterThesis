function [] = asksave(vartosave, path, ext)
    varname = inputname(1);
    varfilename = varname;
    if ~isfolder(path)
        error('Path does not exist')
    end
    
    while true
        if isfolder(path)
            issave = input(['Save "' varname '" in path "' path '" as ' varfilename ext '? (y / n / path / name): '], 's');
            if strcmp(lower(issave), 'y') || strcmp(lower(issave), 'yes') || isempty(issave)
                save([path '\' varname ext], "vartosave")
                disp('Saved.')
                break
            elseif strcmp(lower(issave), 'n') || strcmp(lower(issave), 'no')
                disp('Not saved')
                break
            elseif strcmp(lower(issave), 'path')
                path = input('Enter path: ', 's');
            elseif strcmp(lower(issave), 'name')
                varfilename = input('Enter name: ', 's');
            else
                disp('Invalid input')
            end
        else
            disp('Path does not exist, enter a valid path')
            path = input('Enter path: ', 's');
        end
    end 
    
    
end

