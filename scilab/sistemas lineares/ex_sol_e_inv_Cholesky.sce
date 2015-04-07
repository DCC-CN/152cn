// 
clc;
clear ;
getd('../lib');

function ex_sol_e_inv_Cholesky(label, A, b)

    Ident = eye(A)
    precisao = 10 // casas decimais
    n = size(A, 1)
    formato = '%4.0f'
    formato_x = '%7.2f'
    formato_i = '%9.4f'

    mprintf("\n###################################################################################\n");
    titulo = sprintf("Exemplo %s do sistema Ax = b", label);
    exibe_sistema(titulo, 'x', formato, A, b)

    if  det(A) == 0 then
        mprintf("Matriz singular.") 
        return;
    end

    // ========================================================================
    // Decomposição LU sem pivotação parcial
    // ========================================================================
    try
        R = chol(A)
        // Ajusta para L coresponder ao sistema triangular superior
        L = R'  

        if ~isequal(L*L', A) then
            error('Falha na decomposição de Cholesky!')
        end

        solve_LLt_dp(A, b, L, precisao, formato, formato_x)
        inv_LLt_dp(A, L, precisao, formato, formato_i)
    catch
        mprintf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        mprintf(lasterror())
        mprintf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    end

endfunction

//------------------------------------------
// exemplo 1 de sistema linerar (pág. 74)
// Matriz de coeficientes
A = [ 9,  6, -3,  3;
      6, 20,  2, 22;
     -3,  2,  6,  2;
      3, 22,  2, 28];
          
// Vetor de termos_independentes  
b = [ 12; 64; 4; 82 ];
ex_sol_e_inv_Cholesky('1', A, b)

//------------------------------------------
// exemplo 2 de sistema linerar (pág. 80)
// Matriz de coeficientes
A = [  5  -1   2;
      -1   8   4;
       2   4  10];

// Vetor de termos_independentes  
b = [ 21; 10; 50];
ex_sol_e_inv_Cholesky('2', A, b)

//------------------------------------------
// exemplo 2 de sistema linerar (pág. 80)
// Matriz de coeficientes
A = [  1   2   -1   2;
       2   5    1   3;
      -1   1   26  -1;
       2   3   -1  15];

// Vetor de termos_independentes  
b = [ 10; 27; 75; 65];
ex_sol_e_inv_Cholesky('3', A, b)

//------------------------------------------
// exemplo 4a de sistema linerar (pág. 63)
// Matriz de coeficientes
A = [ 4, -1,  0, -1;
      1, -2,  1,  0;
      0,  4, -4,  1;
      5,  0,  5, -1];
          
// Vetor de termos_independentes  
b = [ 1; -2; -3; 4 ];
try
    ex_sol_e_inv_Cholesky('4a', A, b)
catch
    mprintf('\n%s\n',lasterror());
end

//------------------------------------------
// exemplo 4b de sistema linerar (pág. 63)
// Matriz de coeficientes
A = [ 4,  1,  0,  5;
      1, -2,  4,  0;
      0,  4, -4,  5;
      5,  0,  5, -1];
          
// Vetor de termos_independentes  
b = [ 1; -2; -3; 4 ];
try
    ex_sol_e_inv_Cholesky('4b', A, b)
catch
    mprintf('\n%s\n',lasterror());
end

//------------------------------------------
// exemplo 5 de sistema linerar 
// Matriz de coeficientes
A = [ 1,  2,  3,  4;
      2,  4,  1,  3;
      3,  1,  4,  2;
      4,  3,  2,  5];
          
// Vetor de termos_independentes  
b = [ 1; 2; 3; 4 ];
try
    ex_sol_e_inv_Cholesky('5', A, b)
catch
    mprintf('\n%s\n',lasterror());
end





