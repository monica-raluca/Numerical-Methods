function [G, c] = get_Jacobi_parameters(Link)
    [m, n] = size(Link);
    G_m = m - 2;
    G_n = n - 2;
    G = Link(1 : G_m, 1 : G_n);

    c = Link(1 : G_m, G_m + 1);
end
    
    