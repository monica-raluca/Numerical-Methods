function [Error] = lasso_regression_cost_function(Theta, Y, FeMatrix, lambda)
    
    [m, ~] = size(FeMatrix);
    
    sum = 0;

    for i = 1 : m
        sum = sum + (Y(i) - FeMatrix(i, :) * Theta(2 : end))^2;
    end
    
    theta_sum = 0;

    for j = 1 : size(Theta, 1)
        theta_sum = theta_sum + abs(Theta(j));
    end
    
    Error = sum / m + lambda * theta_sum;

end

