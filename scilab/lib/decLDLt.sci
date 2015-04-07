function [L, D, Det] = decLDLt(A)
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
    for i = 1:n-1
        for j = 1:i
            if A(i,j) ~= A(j,i) then
                error('A matriz não é simétrica.')
            end
        end
    end
    L = eye(A)
    Det = 1
    for j = 1:n
        Soma = 0,
        for k = 1:j-1
            Soma = Soma + L(j,k)^2 * D(k,k)
        end
        D(j,j) = A(j,j) - Soma
        Det = Det * D(j,j)
        for i = j+1:n
            Soma = 0
            for k = 1:j-1
                Soma = Soma + L(i,k) * D(k,k) * L(j,k)
            end
            L(i,j) = (A(i,j) - Soma ) / D(j,j)
        end
    end
endfunction

