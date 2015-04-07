function [L, U, P, Det] = declu(A, Pivota)
    //
    //  Algoritmos Numéricos - Edição 2
    //  Capítulo 2 Sistemas lineares
    //  Seção 2.4 Decomposição LU
    //  Método: Decomposição LU sem/com pivotação parcial
    //
    //  parâmetros de entrada:
    //     A: matriz dos coeficientes,
    //     b: vetor dos termos independentes,
    //     Pivota: define se será usada a estratégia da pivotação parcial:
    //        Pivota = %T: com pivotação parcial,
    //        Pivota = %F: sem pivotação parcial e
    //
    //  parâmetros de saída:
    //     L: matriz triangular inferior,
    //     U: matriz triangular superior,
    //     Pivot: vetor com as linhas pivotais,
    //     Det: determinante de A.
    //
    //  Código disponível no material da disciplina de Cálculo Numérico
    //  Professor Leonardo B. Oliveira
    //  Adapatado em 2014/2: Frederico Sampaio
    //

    n = size(A,'r')
    if n < 2 then
        error("O sistema deve ter ao menos duas equações.")
    end
    if ~issquare(A) then
        error('Matriz A deve ser quadrada');
    end
    if ~exists("Pivota","local") then 
        Pivota = %F
    end

    Pivot = 1:n
    Uman = Pivot
    Det = 1
    U = A
    L = zeros(n,n)

    for j = 1:n-1
        //  escolha do elemento pivot
        if Pivota then
            p = Pivot(j), Amax = abs(U(p,j))
            for k = j+1:n
                if abs(U(Pivot(k),j)) > Amax then
                    Amax = abs(U(Pivot(k),j))
                    p = Pivot(k)
                end
            end
        else
            p = j
        end
        Det = Det * U(p,j)
        if abs(U(p,j)) ~= 0 then
            //  eliminação de Gauss
            for ii = j:n
                i = Pivot(ii)
                if i ~= p then
                    Mult = U(i,j) / U(p,j)
                    L(i,j) = Mult
                    U(i,j) = 0
                    for k = j+1:n
                        U(i,k) = U(i,k) - Mult * U(p,k)
                    end
                end
            end
            if Pivota then
                [x,k] = find(Uman == p), Uman(k) = [], Pivot(j) = p
                Pivot = [Pivot(1:j) Uman]
            end
        else
            Det = 0
            error('Pivô nulo em U('+string(p)+','+string(j)+')')
        end
    end
    Sinal = troca_sinal(Pivot)
    Det = Sinal * Det * U(Pivot(n),n)
    // ordena elementos de L
    for j = 1:n-1
        Coluna = L(Pivot(j+1:n),j)
        L(:,j) = [zeros(j-1,1); 1; Coluna]
    end
    L(:,n) = [zeros(n-1,1); 1]
    // exibe resultados
    P = eye(n,n);
    if Pivota then
        P = P(Pivot(1:n),1:n)
    end
    U = U(Pivot(1:n),1:n)
endfunction

