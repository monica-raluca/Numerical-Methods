function [Error] = ridge_regression_cost_function(Theta, Y, FeMatrix, lambda)
    [m, ~] = size(FeMatrix);
    
    sum = 0;

    for i = 1 : m
        sum = sum + (FeMatrix(i, :) * Theta(2 : end) - Y(i))^2;
    end
    
    theta_sum = 0;

    for j = 1 : size(Theta, 1)
        theta_sum = theta_sum + Theta(j)^2;
    end
    
    Error = sum / (2 * m) + lambda * theta_sum;
end
