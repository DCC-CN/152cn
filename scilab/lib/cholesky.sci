function [L, Det] = cholesky(A)
    //
    //  Algoritmos Numéricos - Edição 2
    //  Capítulo 2 Sistemas lineares
    //  Seção 2.5 Decomposição de Cholesky e LDL^T
    //  Método: Decomposição de Cholesky
    //
    //  parâmetros de entrada:
    //     A: matriz dos coeficientes,
    //
    //  parâmetros de saída:
    //     L: matriz triangular inferior,
    //     Det: determinante de A.
    //
    
    n = size(A,'r')
    Det = 1
    for i = 1:n-1
        for j = 1:i
            if A(i,j) ~= A(j,i) then
                error('A matriz não é simétrica.')
            end
        end
    end
    for j = 1:n
        Soma = 0,
        for k = 1:j-1
            Soma = Soma + L(j,k)^2
        end
        t = A(j,j) - Soma
        if t > 0
            L(j,j) = sqrt(t)
            Det = Det * t
        else
            error('A matriz não é definida positiva.')
        end
        for i = j+1:n
            Soma = 0
            for k = 1:j-1
                Soma = Soma + L(i,k) * L(j,k)
            end
            L(i,j) = ( A(i,j) - Soma ) / L(j,j)
        end
    end
endfunction

