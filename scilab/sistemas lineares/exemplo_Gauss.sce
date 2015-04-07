// 
clc;
clear ;
getd('../lib');

function exemplo_Gauss(label, A, b, prec)
    if ~exists("prec", "local") then
        prec = 3;
    end
    tamanho = prec + 5;
    pausa = %F;
    mprintf("\n###################################################################################\n");
    mprintf("Exemplo %s de solução de sistema linear por método de Gauss\n", label)
    mprintf("-----------------------------------------------------------\n");
    try
        [x, r, Det] = gauss_dp(A, b, %F, tamanho, prec, pausa)
    catch
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        mprintf('%s\n',lasterror());
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    end

    mprintf("\n===================================================================================\n");
    mprintf("Exemplo %s de solução de sistemas lineares por método de Gauss com pivotação parcial\n", label);
    mprintf("------------------------------------------------------------------------------------\n");
    try
        [x, r, Det] = gauss_dp(A, b, %T, tamanho, prec, pausa)
    catch
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        mprintf('%s\n',lasterror());
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    end
endfunction

//------------------------------------------
// exemplo 1 de sistema linerar (pág. 51)
// Matriz de coeficientes
A = [ 1 -3  2;
     -2  8 -1;
      4 -6  5];
          
// Vetor de termos_independentes  
b = [ 11; -15; 29];
exemplo_Gauss('1', A, b)

//------------------------------------------
// exemplo 2 de sistema linerar (pág 53)
// Matriz de coeficientes
A = [1,   6,   2,   4;
     3,  19,   4,  15;
     1,   4,   8, -12;
     5,  33,   9,   3];
          
// Vetor de termos_independentes  
b = [ 8; 25; 18; 72 ];
exemplo_Gauss('2', A, b)

