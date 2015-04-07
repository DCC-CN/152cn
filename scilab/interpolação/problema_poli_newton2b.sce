//
//
//
clear;
clc;
getd('../lib');

function print_vect (name, v)
    mprintf("%s = [", name);
    mprintf("%8.6f", v(1));
    for i = 2:size(v, '*')
        mprintf(" %8.6f", v(i));
    end
    mprintf("]\n");
endfunction

function interpolar(x, y, z, f, funcao)
    exact_fz = f(z);
    P = poly_Newton(x, y, %T);
    Pz = horner(P, z);
    Pz_erro = abs(Pz - exact_fz);
    n = size(x, '*') - 1;
    mprintf("\nInterpolação com polinômio de grau %d = %8.6f (erro %8.6f)\n",...
        n, Pz, Pz_erro);
    mprintf("Polinômio interpolador = %s\n", pol2str(P));
    mprintf("--------------------------------------------------------------\n");
endfunction

funcao = "(2/3)*x^2+(1/5)*x-1";
deff("y = f(x)", "y = "+funcao);
z = 2;
exact_fz = f(z);

// amostra inicial
x = [0 1 3 4 5];
y = feval(x, f);

mprintf("\nAmostra :\n")
print_vect('x', x);
print_vect('y', y);
mprintf("Função original que relaciona os pontos da tabela (amostra)  = %s\n", funcao);
mprintf("Ponto a ser definido na interpolação z = %g\n", z)

interpolar(x, y, z, f, funcao);

