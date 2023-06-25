function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)
   
	% Save initial approximation into x_prev
	x_prev = x0;

	% Steps so far
	steps = 0;
	err = 1;

	% We stop when we reach the max number of steps
	% or when we get an error smaller than the tolerated error
	while steps < max_steps + 1 && err > tol
		x = G * x_prev + c;
		err = norm(x - x_prev);
		steps = steps + 1;
		x_prev = x;
	end

end