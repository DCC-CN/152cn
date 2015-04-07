// 
clc;
clear ;
getd('../lib');

function exemplo_LDLt(label, A, b, prec)
    if ~exists("prec", "local") then
        prec = 4;
    end
    tamanho = prec + 5;
    pausa = %F;
    mprintf("\n###################################################################################\n");
    mprintf("Exemplo %s de solução de sistema linear por decomposição LDLt\n", label)
    mprintf("-------------------------------------------------------------------------------------\n\n");
    [L, D, x, r, Det] = decLDLt_dp(A, b, prec, pausa, 4, 0)
endfunction

//------------------------------------------
// exemplo 1 de sistema linerar (pág. 72)
// Matriz de coeficientes
A = [  4  -2   2;
      -2  10  -1;
       2  -7  30];
          
// Vetor de termos_independentes  
b = [ 8; 11; -31];
exemplo_LDLt('1', A, b)

//------------------------------------------
// exemplo 2 de sistema linerar (pág. 74)
// Matriz de coeficientes
A = [ 9,  6, -3,  3;
      6, 20,  2, 22;
     -3,  2,  6,  2;
      3, 22,  2, 28];
          
// Vetor de termos_independentes  
b = [ 12; 64; 4; 82 ];
exemplo_LDLt('2', A, b)

//------------------------------------------
// exemplo 3 de sistema linerar (pág. 80)
// Matriz de coeficientes
A = [  5  -1   2;
      -1   8   4;
       2   4  10];

// Vetor de termos_independentes  
b = [ 21; 10; 50];
exemplo_LDLt('3', A, b, 4)

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
    exemplo_LDLt('4a', A, b)
catch
    mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    mprintf('%s\n',lasterror());
    mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
end

//------------------------------------------
// exemplo 4a de sistema linerar (pág. 63)
// Matriz de coeficientes
A = [ 4,  1,  0,  5;
      1, -2,  4,  0;
      0,  4, -4,  5;
      5,  0,  5, -1];
          
// Vetor de termos_independentes  
b = [ 1; -2; -3; 4 ];
try
    exemplo_LDLt('4b', A, b)
catch
    mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    mprintf('%s\n',lasterror());
    mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
end

//------------------------------------------
// exemplo 5 de sistema linerar (pág. 63)
// Matriz de coeficientes
A = [ 1  2  3  4; 
      2  4  1  3; 
      3  1  4  2; 
      4  3  2  5]

// Vetor de termos_independentes  
b = [ 13; 11; 19; 17];
try
    exemplo_LDLt('5', A, b)
catch
    mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    mprintf('%s\n',lasterror());
    mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
end
