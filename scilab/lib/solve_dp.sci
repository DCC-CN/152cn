function [x, r] = solve_LU_dp(A, b, L, U, precisao, formato, formato_x)
    // ------------------------------------------------------------------------
    // Solução do sistema
    // ------------------------------------------------------------------------
    mprintf("\n-----------------------------------------------------------------------------------\n");
    mprintf("\nSolução do sistema por decomposição LU:\n\n"), 
    // A*x = b.
    // Na decomposição LU = A, L*U*x = b:
    exibe_sistema(' Sistema triangular inferior Ly = b  (por substituições sucessivas)', 'y', formato, L, b)
    mprintf('\n');

    // 1: L*y = b    => y = b/L
    y = substSuces(L, b)

    exibe_vetor(' y', formato_x, y)
    mprintf('\n');
    exibe_sistema(' Sistema triangular superior Ux = y  (por substituições retroativas)', 'x', formato, U, y)
    mprintf('\n');

    // 2: U*x = y => x = y/U
    x = substRetro(U, y)

    exibe_vetor(' x', formato_x, x)
    mprintf('\n');
    exibe_solucao(' Solução do sistema Ax = b', x, formato_x, formato, A, b)
    mprintf('\n');
    mprintf('Resíduo r = b - Ax:\n');
    r = b - A*x
    exibe_vetor(' r', formato_x, r)
endfunction

function [x, r] = solve_LUP_dp(A, b, L, U, P, precisao, formato, formato_x)
    // ------------------------------------------------------------------------
    // Solução do sistema
    // ------------------------------------------------------------------------
    mprintf("\n-----------------------------------------------------------------------------------\n");
    mprintf("\nSolução do sistema por decomposição LU com pivotação parcial:\n\n"), 
    // PA*x = Pb.
    // Na decomposição LU = A, P*L*U*x = P*b:
    exibe_sistema_pivot(' Sistema triangular inferior Ly = Pb  (por substituições sucessivas)',...
                        'y', formato, L, b, P)
    mprintf('\n');

    // 1: L*y = P*b    => y = P*b/L
    y = substSuces(L, P*b)

    exibe_vetor(' y', formato_x, y)
    mprintf('\n');
    exibe_sistema(' Sistema triangular superior Ux = y  (por substituições retroativas)', 'x', formato, U, y)
    mprintf('\n');

    // 2: U*x = y => x = y/U
    x = substRetro(U, y)


    exibe_vetor(' x', formato_x, x)
    mprintf('\n');
    exibe_solucao(' Solução do sistema Ax = b', x, formato_x, formato, A, b)
    mprintf('\n');
    mprintf('Resíduo r = b - Ax:\n');
    r = b - A*x
    exibe_vetor(' r', formato_x, r)
endfunction

function [x, r] = solve_LLt_dp(A, b, L, precisao, formato, formato_x)
    // ------------------------------------------------------------------------
    // Solução do sistema
    // ------------------------------------------------------------------------
    mprintf("\n-----------------------------------------------------------------------------------\n");
    mprintf(" Solução do sistema por decomposição de Cholesky:\n\n"), 
    // A*x = b.
    // Na decomposição LL' = A, L*L'*x = b:
    exibe_sistema(' Sistema triangular inferior Ly = b  (por substituições sucessivas)', 'y', formato, L, b)
    mprintf('\n');

    // 1: L*y = b    => y = b/L
    y = substSuces(L, b)

    exibe_vetor(' y', formato_x, y)
    mprintf('\n');
    exibe_sistema(' Sistema triangular superior L''x = y  (por substituições retroativas)', 'x', formato, L', y)
    mprintf('\n');

    // 2: L'*x = y => x = y/L'
    x = substRetro(L', y)

    exibe_vetor(' x', formato_x, x)
    mprintf('\n');
    exibe_solucao(' Solução do sistema Ax = b', x, formato_x, formato, A, b)
    mprintf('\n');
    mprintf('Resíduo r = b - Ax:\n');
    r = b - A*x
    exibe_vetor(' r', formato_x, r)
endfunction

function [x, r] = solve_LDLt_dp(A, b, L, D, precisao, formato, formato_x)
    // ------------------------------------------------------------------------
    // Solução do sistema
    // ------------------------------------------------------------------------
    mprintf("\n-----------------------------------------------------------------------------------\n");
    mprintf(" Solução do sistema por decomposição LDLt:\n\n"), 
    // A*x = b.
    // Na decomposição LDL' = A, L*D*L'*x = b:
    exibe_sistema(' Sistema triangular inferior Ly = b  (por substituições sucessivas)', 'y', formato, L, b)
    mprintf('\n');

    // 1: L*y = b    => y = b/L
    y = substSuces(L, b)

    exibe_sistema(' Sistema diagonal Dt = y  (solução direta por t(i)=y(i)/D(i,i))', 't', formato, D, y)
    mprintf('\n');

    // 2: D*t = y    => t = y/D
    n = size(D, 1)
    for i = 1:n
        t(i) = y(i)/D(i,i)
    end

    exibe_vetor(' t', formato_x, t)
    mprintf('\n');
    exibe_sistema(' Sistema triangular superior L''x = t  (por substituições retroativas)', 'x', formato, L', t)
    mprintf('\n');

    // 3: L'*x = t => x = t/L'
    x = substRetro(L', t)

    exibe_vetor(' x', formato_x, x)
    mprintf('\n');
    exibe_solucao(' Solução do sistema Ax = b', x, formato_x, formato, A, b)
    mprintf('\n');
    mprintf('Resíduo r = b - Ax:\n');
    r = b - A*x
    exibe_vetor(' r', formato_x, r)
endfunction

