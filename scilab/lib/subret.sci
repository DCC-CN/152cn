function x = subret(U, d, Exibe)
    //
    //   Substituições sucessivas
    //
    n = length(d);
    x = zeros(n,1);
    x(n) = digitos(d(n) / U(n,n), Exibe);
    for i = n-1:-1:1
        Soma = 0;
        for j = i+1:n
            Soma = Soma + digitos(U(i,j) * x(j), Exibe);
        end
        x(i) = digitos((d(i) - Soma) / U(i,i), Exibe);
    end
endfunction

