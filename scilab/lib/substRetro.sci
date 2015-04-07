function [x] = substRetro(U, d)
    // U= matriz triangular superior 
    // d= vetor de termos independente

    n = size(U, 1);
    x(n)=d(n)/U(n,n);
    for i = n:-1:1
        soma = 0;
        for j = (i +1):n
            soma  = soma + U(i,j)*x(j);
        end
        x(i) = (d(i) - soma)/U(i,i);
    end
endfunction
