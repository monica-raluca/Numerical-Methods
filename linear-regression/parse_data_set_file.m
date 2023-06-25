function [Y, InitialMatrix] = parse_data_set_file(file_path)
    
    % Open the file
    input = fopen(file_path, 'r');

    % Read dimensions
    dimensions = fscanf(input, "%d", 2);
    m = dimensions(1);
    n = dimensions(2);

    Y = zeros(m, 1);
    InitialMatrix = cell(m, n);

    for i = 1: m
        Y(i) = fscanf(input, '%d', 1);

        for j = 1: n
            string = fscanf(input, '%s', 1);
            numeric = str2double(string);
            if ~isnan(numeric)
                InitialMatrix{i, j} = numeric;
            else
                InitialMatrix{i, j} = string;
            end
        end
    end

    fclose(input);
end
