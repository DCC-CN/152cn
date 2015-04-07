function x = subsuc(L, c, Exibe)
    //
    //   Substituicoes sucessivas
    //
    n = length(c);
    x = zeros(n,1);
    x(1) = digitos(c(1) / L(1,1), Exibe);
    for i = 2:n
        Soma = 0;
        for j = 1:i-1
            Soma = Soma + digitos(L(i,j) * x(j), Exibe);
        end
        x(i) = digitos((c(i) - Soma) / L(i,i), Exibe);
    end
endfunction

