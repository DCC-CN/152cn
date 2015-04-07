function [x] = substSuces(L, c)
    // L = matriz triangular inferior 
	// c = vetor de termos independentes

    n = size(L,1);
    x(1) = c(1) / L(1,1)
    for i=2:n
        soma=0
        for j = 1:i-1
            soma = soma + L(i,j) * x(j)
        end
        x(i) = (c(i) - soma) / L(i,i)
    end

endfunction
