// 
clc;
clear ;
getd('../lib');

function ex_sol_e_inv_LU(label, A, b)

    Ident = eye(A)
    precisao = 4 // casas decimais
    n = size(A, 1)
    formato = '%4.0f'
    formato_x = '%7.2f'
    formato_i = '%9.4f'

    mprintf("\n###################################################################################\n");
    titulo = sprintf("Exemplo %s do sistema Ax = b", label);
    exibe_sistema(titulo, 'x', formato, A, b)

    if  det(A) == 0 then
        mprintf("\nMatriz singular.\n") 
        return;
    end

    // ========================================================================
    // Decomposição LU sem pivotação parcial
    // ========================================================================
    try
        [L, U] = declu(A)

        if ~isequal(L*U, A) then
            error('Falha na decomposição LU!')
        end

        solve_LU_dp(A, b, L, U, precisao, formato_x, formato_x)
        inv_LU_dp(A, L, U, precisao, formato_i, formato_i)
    catch
        mprintf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        mprintf(lasterror())
        mprintf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    end

    // ========================================================================
    // Decomposição LU com pivotação parcial
    // ========================================================================
    try
        [L, U, P] = lu(A)
    
        // utilização de precisão por causa de diferença de PF
        if ~isequal(digitos(L*U, precisao), digitos(P*A, precisao)) then
            error('Falha na decomposição LU com pivotação parcial!')
        end

        solve_LUP_dp(A, b, L, U, P, precisao, formato_x, formato_x)
        inv_LUP_dp(A, L, U, P, precisao, formato_i, formato_i);
    catch
        mprintf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        mprintf(lasterror())
        mprintf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        abort
    end

endfunction

//------------------------------------------
// exemplo 1 de sistema linerar (pág. 58)
// Matriz de coeficientes
A = [ 1 -3  2;
     -2  8 -1;
      4 -6  5];
          
// Vetor de termos_independentes  
b = [ 11; -15; 29];
ex_sol_e_inv_LU('1', A, b)

//------------------------------------------
// exemplo 2 de sistema linerar (pág. 63)
// Matriz de coeficientes
A = [ 4, -1,  0, -1;
      1, -2,  1,  0;
      0,  4, -4,  1;
      5,  0,  5, -1];
          
// Vetor de termos_independentes  
b = [ 1; -2; -3; 4 ];
ex_sol_e_inv_LU('2', A, b)

//------------------------------------------
// exemplo 3 de sistema linerar (pág. 64)
// Matriz de coeficientes
A = [ 1 -3  2;
     -2  8 -1;
     -1  5  1];

// Vetor de termos_independentes  
b = [ 22; -12; 10];
ex_sol_e_inv_LU('3a', A, b)

// Vetor de termos_independentes  
b = [ 22; -10; 10];
ex_sol_e_inv_LU('3b', A, b)

//------------------------------------------
// exemplo 4 de sistema linerar
// Matriz de coeficientes
A = [1,   6,   2,   4;
     3,  19,   4,  15;
     1,   4,   8, -12;
     5,  33,   9,   3];
          
// Vetor de termos_independentes  
b = [ 8; 25; 18; 72 ];
ex_sol_e_inv_LU('4', A, b)

//------------------------------------------
// exemplo 5 de sistema linerar (pág. 63)
// Matriz de coeficientes
A = [ 4, -1,  0, -1;
      1, -2,  1,  0;
      0,  4, -4,  1;
      5,  0,  5, -1];
          
// Vetor de termos_independentes  
b = [ 1; -2; -3; 4 ];
ex_sol_e_inv_LU('5', A, b)

//------------------------------------------
// exemplo 6 de sistema linerar (pág. 63)
// Matriz de coeficientes
A = [ 4,  1,  0,  5;
      1, -2,  4,  0;
      0,  4, -4,  5;
      5,  0,  5, -1];
          
// Vetor de termos_independentes  
b = [ 1; -2; -3; 4 ];
ex_sol_e_inv_LU('6', A, b)

//------------------------------------------
// exemplo 6 de sistema linerar 
// Matriz de coeficientes
A = [ 1,  2,  3,  4;
      2,  4,  1,  3;
      3,  1,  4,  2;
      4,  3,  2,  5];
          
// Vetor de termos_independentes  
b = [ 1; 2; 3; 4 ];
ex_sol_e_inv_LU('7', A, b)




