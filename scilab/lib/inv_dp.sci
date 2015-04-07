function invA = inv_LU_dp(A, L, U, precisao, formato, formato_i)
    // ------------------------------------------------------------------------
    // Cálculo da inversa
    // ------------------------------------------------------------------------
    mprintf("\n-----------------------------------------------------------------------------------\n");
    mprintf("\nCálculo de matriz inversa de A por decomposição LU:\n\n")
    // A*x = b, sendo x = invA(:, i) e b = I(:, i), pois A*invA = I.
    // Na decomposição LU = A, L*U*invA = I:
    // Para cada coluna i:
    Ident = eye(A);
    n = size(A, 1);
    for i = 1:n
        exibe_sistema(' Sistema triangular inferior Ly = I(coluna '+string(i)+')  (por substituições sucessivas)', 'y', formato, L, Ident(:, i))
        mprintf('\n');

        // 1: L*y = I(:, i)    => y = I(:, 1)/L
        y = substSuces(L, Ident(:, i))

        exibe_vetor(' y', formato_i, y)
        mprintf('\n');
        exibe_sistema_inv(' Sistema triangular superior UinvA(coluna '+string(i)+') = y  (por substituições retroativas)', ...
                      'invA', i, formato_i, U, y)
        // 2: U*invA(:, i) = y => invA(:, i) = y/U
        invA(:, i) = substRetro(U, y)

        mprintf('\n');
        exibe_vetor(' invA(coluna '+string(i)+')', formato_i, invA(:, i))
        mprintf("...................................................................................\n");
    end

    Ident2 = zera(A*invA, precisao);
    exibe_inversa(' Solução da matriz inversa de A', A, formato, invA, formato_i, Ident2)

    if ~isequal(Ident2, Ident) then
        disp('Falha nos cálculos da inversa!')
    end

endfunction

function invA = inv_LUP_dp(A, L, U, P, precisao, formato, formato_i)
    // ------------------------------------------------------------------------
    // Cálculo da inversa
    // ------------------------------------------------------------------------
    mprintf("\n-----------------------------------------------------------------------------------\n");
    mprintf("\nCálculo de matriz inversa de A por decomposição LU com pivotação parcial:\n\n");
    // P*A*x = P*b, sendo x = invA(:, i) e b = I(:, i), pois P*A*invA = P*I. 
    // Como P*I = P, tem-se P*A*invA = P.
    // Na decomposição LU = A, ou seja, P*L*U*invA = P.
    // Para cada coluna i:
    Ident = eye(A);
    n = size(A, 1);
    for i = 1:n
        exibe_sistema(' Sistema triangular inferior Ly = P(coluna '+string(i)+')  (por substituições sucessivas)', 'y', formato, L, P(:, i))
        mprintf('\n');

        // 1: L*y = P(:, i)    => y = P(:, 1)/L
        y = substSuces(L, P(:, i))
        
        exibe_vetor(' y', formato_i, y)
        mprintf('\n');
        exibe_sistema_inv(' Sistema triangular superior UinvA(coluna '+string(i)+') = y  (por substituições retroativas)', ...
                      'invA', i, formato_i, U, y)

        // 2: U*invA(:, i) = y => invA(:, i) = y/U
        invA(:, i) = substRetro(U, y)

        mprintf('\n');
        exibe_vetor(' invA(coluna '+string(i)+')', formato_i, invA(:, i))
        mprintf("...................................................................................\n");
    end
    mprintf('\n');
    
    Ident2 = zera(A*invA, precisao)
    exibe_inversa(' Solução da matriz inversa de A', A, formato, invA, formato_i, Ident2)

    if ~isequal(Ident2, Ident) then
        error('Falha nos cálculos da inversa!')
    end
endfunction

function invA = inv_LLt_dp(A, L, precisao, formato, formato_i)
    // ------------------------------------------------------------------------
    // Cálculo da inversa
    // ------------------------------------------------------------------------
    mprintf("\n-----------------------------------------------------------------------------------\n");
    mprintf(" Cálculo de matriz inversa de A por decomposição de Cholesky:\n\n")
    // A*x = b, sendo x = invA(:, i) e b = I(:, i), pois A*invA = I.
    // Na decomposição LL' = A, L*L'*invA = I:
    // Para cada coluna i:
    Ident = eye(A);
    n = size(A, 1);
    for i = 1:n
        exibe_sistema(' Sistema triangular inferior Ly = I(coluna '+string(i)+')  (por substituições sucessivas)', 'y', ...
                      formato_i, L, Ident(:, i))
        mprintf('\n');

        // 1: L*y = I(:, i)    => y = I(:, 1)/L
        y = substSuces(L, Ident(:, i))

        exibe_vetor(' y', formato_i, y)
        mprintf('\n');
        exibe_sistema_inv(' Sistema triangular superior L''invA(coluna '+string(i)+') = y  (por substituições retroativas)', ...
                      'invA', i, formato_i, L', y)

        // 2: L'*invA(:, i) = y => invA(:, i) = y/L'
        invA(:, i) = substRetro(L', y)

        mprintf('\n');
        exibe_vetor(' invA(coluna '+string(i)+')', formato_i, invA(:, i))
        mprintf("...................................................................................\n");
    end
    mprintf('\n');
    
    Ident2 = zera(A*invA, precisao)
    exibe_inversa(' Solução da matriz inversa de A', A, formato, invA, formato_i, Ident2)

    if ~isequal(Ident2, Ident) then
        error('Falha nos cálculos da inversa!')
    end
endfunction

function invA = inv_LDLt_dp(A, L, D, precisao, formato, formato_i)
    // ------------------------------------------------------------------------
    // Cálculo da inversa
    // ------------------------------------------------------------------------
    mprintf("\n-----------------------------------------------------------------------------------\n");
    mprintf(" Cálculo de matriz inversa de A por decomposição LDLt:\n\n"), 
    // A*x = b, sendo x = invA(:, i) e b = I(:, i), pois A*invA = I.
    // Na decomposição LDL' = A, L*D*L'*x = b:
    // Para cada coluna i:
    Ident = eye(A);
    n = size(A, 1);
    for i = 1:n
        exibe_sistema(' Sistema triangular inferior Ly = I(coluna '+string(i)+')  (por substituições sucessivas)', 'y', formato, L, Ident(:, i))
        mprintf('\n');

        // 1: L*y = I(:, i)    => y = I(:, 1)/L
        y = substSuces(L, Ident(:, i))

        exibe_vetor(' y', formato_i, y)
        mprintf('\n');
        exibe_sistema(' Sistema diagonal Dt = y  (solução direta por t(i)=y(i)/D(i,i))', 't', formato_i, D, y)
        mprintf('\n');

        // 2: D*t = y    => t = y/D
        n = size(D, 1)
        for ii = 1:n
            t(ii) = y(ii)/D(ii,ii)
        end

        exibe_vetor(' t', formato_i, t)
        mprintf('\n');
        exibe_sistema_inv(' Sistema triangular superior L''invA(coluna '+string(i)+') = t  (por substituições retroativas)', ...
                      'invA', i, formato_i, L', t)
        mprintf('\n');

        // 3: L'*invA(:, i) = y => invA(:, i) = y/L'
        invA(:, i) = substRetro(L', t)

        exibe_vetor(' invA(coluna '+string(i)+')', formato_i, invA(:, i))
        mprintf("...................................................................................\n");
    end
    mprintf('\n');
    
    Ident2 = zera(A*invA, precisao)
    exibe_inversa(' Solução da matriz inversa de A', A, formato, invA, formato_i, Ident2)

    if ~isequal(Ident2, Ident) then
        error('Falha nos cálculos da inversa!')
    end
endfunction


