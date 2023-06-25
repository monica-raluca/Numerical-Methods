function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
    [m, ~] = size(FeatureMatrix);
    
    % Formula for linear regression in matrix form
    % We use Theta(2 : end) because the first value is the initial
    % zero approximation that we do not need
    Error = sum((FeatureMatrix * Theta(2 : end) - Y) .^ 2) / (2 * m);
end
