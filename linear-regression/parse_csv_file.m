function [Y, InitialMatrix] = parse_csv_file(file_path)
   
    % Open the file
    input = fopen(file_path, 'r');

    % Determine number of rows and columns
    num_rows = 0;
    num_cols = 0;
    while ~feof(input)
        % Read the line and increment row count
        line = fgets(input);
        num_rows = num_rows + 1;

        % Determine the number of columns
        comma_count = numel(strfind(line, ','));
        if comma_count > num_cols
            num_cols = comma_count;
        end
    end
    num_cols = num_cols + 1;

    % Reset file pointer to beginning
    frewind(input);

    % Parse the data
    InitialMatrix = cell(num_rows, num_cols);
    Y = zeros(num_rows, 1);
    for i = 1:num_rows
        % Read the first value in the line as a string
        string = fscanf(input, '%s', 1);

        % Split the line into comma-separated values
        C = strsplit(string, ',');

        % Convert the first value to a double and store it in Y
        Y(i) = str2double(C{1});

        % Parse the rest of the values and store them in InitialMatrix
        for j = 2:num_cols
            value = C{j};
            if ~isnan(str2double(value))
                % Convert the value to a double if it's a number
                value = str2double(value);
            end
            InitialMatrix{i, j-1} = value;
        end
    end

    % Close the file
    fclose(input);

    % Remove first row and column
    Y = Y(2:end);
    InitialMatrix = InitialMatrix(:, 1:end-1);
    InitialMatrix = InitialMatrix(2:end, :);
end
