function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
    
    % Shuffle the examples randomly
    index = randperm(size(X, 1));
    X = X(index, :);
    y = y(index);
    
    % Compute the split index
    index_split = round(percent * size(X, 1));
    
    % Split the dataset into training and test sets
    X_train = X(1 : index_split, :);
    y_train = y(1 : index_split);
    X_test = X(index_split + 1 : end, :);
    y_test = y(index_split + 1 : end);

end
