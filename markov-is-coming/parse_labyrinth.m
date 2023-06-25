function [Labyrinth] = parse_labyrinth(file_path)
    % Open the file
    input = fopen(file_path);

    % Read dimensions
    dimensions = fscanf(input, "%d", 2);
    m = dimensions(1);
    n = dimensions(2);

    % Read the matrix one element at a time
    Labyrinth = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            Labyrinth(i, j) = fscanf(input, "%d", 1);
        end
    end

    % Close the file
    fclose(input);
end



