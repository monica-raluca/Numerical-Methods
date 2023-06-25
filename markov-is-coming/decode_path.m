function [decoded_path] = decode_path(path, lines, cols)

	% Get the size of the path, we only care about
	% one of the sizes so we only store m
	[m, ~] = size(path);

	% Decrease m since win state has no coordinates
	% into our labyrinth
	m = m - 1;

	% Fill the decoded path with zeroes
	decoded_path = zeros(m, 2);

	% Convert the number to the row and column indices
	for i = 1 : m
		decoded_path(i, 1) = ceil(path(i, 1) / cols);
		decoded_path(i, 2) = mod(path(i, 1) - 1, cols) + 1;
	end
	
end
