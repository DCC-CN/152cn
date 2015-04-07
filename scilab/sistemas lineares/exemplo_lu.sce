// 
clc;
clear ;
getd('../lib');

function exemplo_LU(label, A, b, prec)
    if ~exists("prec", "local") then
        prec = 2;
    end
    tamanho = prec + 5;
    pausa = %F;
    mprintf("\n###################################################################################\n");
    mprintf("Exemplo %s de solução de sistema linear por decomposição LU\n", label)
    mprintf("-----------------------------------------------------------\n");
    try
        [L, U, P, x, r, Det] = declu_dp(A, b, %F, tamanho, prec, pausa)
    catch
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        mprintf('%s\n',lasterror());
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    end

    mprintf("\n===================================================================================\n");
    mprintf("Exemplo %s de solução de sistemas lineares por decomposição LU com pivotação parcial\n", label);
    mprintf("------------------------------------------------------------------------------------\n");
    try
        [L, U, P, x, r, Det] = declu_dp(A, b, %T, tamanho, prec, pausa)
    catch
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        mprintf('%s\n',lasterror());
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
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
exemplo_LU('1', A, b)

//------------------------------------------
// exemplo 2 de sistema linerar (pág. 63)
// Matriz de coeficientes
A = [ 4, -1,  0, -1;
      1, -2,  1,  0;
      0,  4, -4,  1;
      5,  0,  5, -1];
          
// Vetor de termos_independentes  
b = [ 1; -2; -3; 4 ];
exemplo_LU('2', A, b)

//------------------------------------------
// exemplo 3 de sistema linerar (pág. 64)
// Matriz de coeficientes
A = [ 1 -3  2;
     -2  8 -1;
     -1  5  1];

// Vetor de termos_independentes  
b = [ 22; -12; 10];
exemplo_LU('3a', A, b)

// Vetor de termos_independentes  
b = [ 22; -10; 10];
exemplo_LU('3b', A, b)

//------------------------------------------
// exemplo 4 de sistema linerar
// Matriz de coeficientes
A = [1,   6,   2,   4;
     3,  19,   4,  15;
     1,   4,   8, -12;
     5,  33,   9,   3];
          
// Vetor de termos_independentes  
b = [ 8; 25; 18; 72 ];
exemplo_LU('4', A, b, 4)

//------------------------------------------
// exemplo 5 de sistema linerar
// Matriz de coeficientes
A = [ 1  2  3  4; 
      2  4  1  3; 
      3  1  4  2; 
      4  3  2  5]

// Vetor de termos_independentes  
b = [ 13; 11; 19; 17];
exemplo_LU('5', A, b)

//------------------------------------------
// exemplo 6 de sistema linerar
// Matriz de coeficientes
A = [ 8  12  4; 
      2  3   1; 
      4  6   2]

// Vetor de termos_independentes  
b = [ 44; 11; 22 ];
exemplo_LU('6', A, b)



//------------------------------------------
// exemplo de sistemas singulares 2
// Matriz de coeficientes
A = [ 2   5  1; 
      6  19  6; 
      2  13  7]

// Vetor de termos_independentes  
b = [ 6; 21; 12];
exemplo_LU('7', A, b)

// Vetor de termos_independentes  
c = [ 6; 21; 14];
exemplo_LU('7', A, c)



