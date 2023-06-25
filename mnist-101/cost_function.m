function [J, grad] = cost_function(params, X, y, lambda, input_layer_size, hidden_layer_size, output_layer_size)
    
    % Define sigmoid and sigmoid derivative
    sigmoid = @(x) 1./(1 + exp(-x));
    sigmoid_derivative = @(x) sigmoid(x) .* (1 - sigmoid(x));

    % Reshape the parameter vector into the matrices of weights
    % for each layer of the neural network
    Theta1 = reshape(params(1 : hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
    Theta2 = reshape(params((1 + (hidden_layer_size * (input_layer_size + 1))) : end), output_layer_size, (hidden_layer_size + 1));
    
    % The number of training examples
    m = size(X, 1);
    
    % Forward propagation
    a1 = [ones(m, 1) X];
    z2 = a1 * Theta1';
    a2 = [ones(size(z2, 1), 1) sigmoid(z2)];
    z3 = a2 * Theta2';
    a3 = sigmoid(z3);
    
    % Transform y into a binary matrix representation,
    % each row representing an example and each column a different class
    y_matrix = eye(output_layer_size);
    y_matrix = y_matrix(y, :);
    
    % Cost function without the regularization
    J = (-1 / m) * sum(sum(y_matrix .* log(a3) + (1 - y_matrix) .* log(1 - a3)));
    
    % Regularization term
    regularization = (lambda/(2 * m)) * (sum(sum(Theta1(:, 2 : end) .^ 2)) + sum(sum(Theta2(:, 2 : end) .^ 2)));
    
    % Regularized cost function
    J = J + regularization;
    
    % Backpropagation
    delta3 = a3 - y_matrix;
    delta2 = delta3 * Theta2(:, 2 : end) .* sigmoid_derivative(z2);
    Delta1 = delta2' * a1;
    Delta2 = delta3' * a2;
    
    % Gradient without the regularization
    Theta1_gradient = (1 / m) * Delta1;
    Theta2_gradient = (1 / m) * Delta2;
    
    % Regularization term
    regularization1 = (lambda / m) * [zeros(size(Theta1, 1), 1) Theta1(:, 2 : end)];
    regularization2 = (lambda / m) * [zeros(size(Theta2, 1), 1) Theta2(:, 2 : end)];
    
    % Regularized gradient
    Theta1_gradient = Theta1_gradient + regularization1;
    Theta2_gradient = Theta2_gradient + regularization2;
    
    % Unroll the gradients
    grad = [Theta1_gradient(:) ; Theta2_gradient(:)];

end