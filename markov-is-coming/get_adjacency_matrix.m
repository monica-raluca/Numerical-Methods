function [adj] = get_adjacency_matrix(Labyrinth)

	% Labyrinth sizes
    [m, n] = size(Labyrinth);

	% Adjacency matrix sizes, with win and lose states
    new_m = m + 2;
    new_n = n + 2;

	% Create a new matrix that is bigger than the original Labyrinth matrix, 
    % with a border of zeros around it
    aux = zeros(new_m, new_n);
    aux(2 : end - 1, 2 : end - 1) = Labyrinth;

    adj_m = m * n + 2;
    adj_n = adj_m;

	% Initialize the adjacency matrix
    adj = zeros(adj_m, adj_n);

    for i = 2 : new_m - 1
		for j = 2 : new_n - 1
			if i + 1 == new_m
				adj((j - 1 + (i - 2) * n), adj_m - 1) = ~bitget(aux(i, j), 3);
				adj(adj_m - 1, (j - 1 + (i - 2) * n)) = ~bitget(aux(i, j), 3);
			else
				adj((j - 1 + (i - 2) * n), j - 1 + (i - 1) * n) = ~bitget(aux(i, j), 3);
				adj((j - 1 + (i - 1) * n), j - 1 + (i - 2) * n) = ~bitget(aux(i, j), 3);
			end
			if i - 1 == 1
				adj((j - 1 + (i - 2) * n), adj_m - 1) = ~bitget(aux(i, j), 4);
				adj(adj_m - 1, (j - 1 + (i - 2) * n)) = ~bitget(aux(i, j), 4);
			else
				adj((j - 1 + (i - 2) * n), j - 1 + (i - 3) * n) = ~bitget(aux(i, j), 4);
				adj((j - 1 + (i - 3) * n), j - 1 + (i - 2) * n) = ~bitget(aux(i, j), 4);
			end

			if j + 1 == new_n
				adj((j - 1 + (i - 2) * n), adj_m) = ~bitget(aux(i, j), 2);
				adj(adj_m, (j - 1 + (i - 2) * n)) = ~bitget(aux(i, j), 2);
			else
				adj((j - 1 + (i - 2) * n), j + (i - 2) * n) = ~bitget(aux(i, j), 2);
				adj((j + (i - 2) * n), (j - 1 + (i - 2) * n)) = ~bitget(aux(i, j), 2);
			end

			if j - 1 == 1
				adj((j - 1 + (i - 2) * n), adj_m) = ~bitget(aux(i, j), 1);
				adj(adj_m, (j - 1 + (i - 2) * n)) = ~bitget(aux(i, j), 1);
			else
				adj((j - 1 + (i - 2) * n), (j - 2) + (i - 2) * n) = ~bitget(aux(i, j), 1);
				adj(((j - 2) + (i - 2) * n), (j - 1 + (i - 2) * n)) = ~bitget(aux(i, j), 1);
			end
		end
    end

	% Modify the win and lose states 
    adj(adj_m - 1, :) = 0;
    adj(adj_m - 1, adj_m - 1) = 1;
    adj(adj_m, :) = 0;
    adj(adj_m, adj_m) = 1;

	% Convert the adjacency matrix to sparse format
    adj = sparse(adj);

end