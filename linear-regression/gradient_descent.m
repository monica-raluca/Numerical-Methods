function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
    Theta = zeros(n + 1, 1);

    for i = 1 : iter
        gradient = (1 / m) * FeatureMatrix' * (FeatureMatrix * Theta(2 : end) - Y);
        Theta(2 : end) = Theta(2 : end) - alpha * gradient;
    end
end