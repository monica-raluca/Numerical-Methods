function [Link] = get_link_matrix(Labyrinth)
    Link = get_adjacency_matrix(Labyrinth);
    [m, n] = size(Link);
    for i = 1 : m
        for j = 1 : n
            % Number of ones
            ones = sum(Link(i, :));
        end
        % Divide each element to the number of ones on that row
        Link(i, :) = Link(i, :) / ones;
    end
end
