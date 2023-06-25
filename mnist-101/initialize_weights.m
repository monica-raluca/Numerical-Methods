function [matrix] = initialize_weights(L_prev, L_next)
    
    % Initialize epsilon with the right value
    epsilon = sqrt(6) / sqrt(L_prev + L_next);

    % L_prev + 1 so that we account for the bias column
    % Initialize the matrix with random values between -epsilon and epsilon
    matrix = rand(L_next, L_prev + 1) * (2 * epsilon) - epsilon;

end
