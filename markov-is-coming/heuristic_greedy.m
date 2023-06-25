function [path] = heuristic_greedy(start_position, probabilities, Adj)
	
	% Start by adding the starting position to the path
	path = [start_position];
	[m, n] = size(Adj);

	% Initialize each element as false. Set start_position as visited
	visited = false(1, m);
	visited(start_position) = true;

	% We continue while we still have elements in our path
	while ~isempty(path)
		% Our current position is the latest element from the path
		position = path(end);

		% If we are on the win position we exit the function
		if position == n - 1
			return;
		end
		
		% We make an array of unvisited neighbours
		unvisited_neighbours = Adj(position, :) & ~visited;

		% If the node has no unvisited neighbours left,
		% we take the node out of the path
		if all(unvisited_neighbours == 0)
			path(end) = []; 
		else
			% If we are on a node that is a direct neighbour to the
			% win position, we add the win position to the path
			% transpose path (since we start with a row array)
			% and exit the function since we found the path
			if full(unvisited_neighbours(1, n - 1)) == 1
				path = [path, sqrt((m - 2)) * sqrt((n - 2)) + 1];
				path = path';
				return;
			end
			 
			abs_max = -1;
			new_elem = -1;
	
			% We go on the neighbours that aren't win or lose state
			for i = 1 : n - 2
				% If the neighbour is unvisited
				if full(unvisited_neighbours(1, i)) == 1
					current_elem = i;
					% We compute the max probability and if it is
					% higher than the absolute max, we change the
					% absolute max and the next element
					temp_max = max(probabilities(current_elem));
					if abs_max < temp_max
						abs_max = temp_max;
						new_elem = current_elem;
					end
				end
			end
		end

		% We add the element with the highest win chance in the path
		% and we mark it as visited
		path = [path, new_elem];
		visited(new_elem) = true;
		 
	end
end