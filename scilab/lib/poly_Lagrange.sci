function Px = poly_Lagrange(x, y) 
    // x nós, Y valores
    // P e' o polinimo de interpolacao de Lagrange
    //
    
    n = length(x); // n é o numero de pontos. n-1 é o grau de polinômio
    X = poly(0,"x"); // inicializa um monômio x
    Px = 0; // inicializa o polinômio interpolador
    for i = 1:n, L=1;
        for j = [1:i-1,i+1:n] 
            L = L*(X-x(j))/(x(i)-x(j));
        end
        Px = Px + L*y(i); 
    end
endfunction
