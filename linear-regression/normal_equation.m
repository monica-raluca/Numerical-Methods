function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)
    [n, m] = size(FeatureMatrix);

    if n ~= m
        % Compute the Gramian matrix
        G = FeatureMatrix' * FeatureMatrix;
        % If the rank of the feature matrix is less than m, return zeros
        if rank(FeatureMatrix) < m
            Theta = zeros(m + 1, 1);
            return;
        end
        % Compute the right-hand side vector
        b = FeatureMatrix' * Y;

        % Solve the system using conjugate gradient
        x0 = zeros(m, 1);
        r = b - G * x0;
        v = r;
        k = 0; 
        while k < iter && norm(r)^2 > tol^2
            A = G * v;
            tk = (r' * r) / (v' * A); 
            x0 = x0 + tk * v; 
            new_r = r - tk * A; 
            sk = norm(new_r)^2 / norm(r)^2;
            v = new_r + sk * v; 
            r = new_r; 
            k = k + 1; 
        end
        Theta = [0; x0]; % Return the final solution
    else
        try
            L = chol(FeatureMatrix); % Compute the Cholesky decomposition of the feature matrix
        catch ME
            Theta = zeros(m + 1, 1);
            return;
        end
        r = Y;
        v = r; 
        Theta = zeros(size(FeatureMatrix, 2) + 1, 1);
        k = 1; 
        while k < iter && norm(r)^2 > tol^2
            tk = (r' * r) / (v' * (FeatureMatrix') * v); 
            Theta(2 : end) = Theta(2 : end) + tk * v;
            new_r = r - tk * FeatureMatrix * v; 
            sk = norm(new_r)^2 / norm(r)^2;
            v = new_r + sk * v;
            r = new_r; 
            k = k + 1;
        end
    end
end
