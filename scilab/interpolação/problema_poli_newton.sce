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

function interpolar(x, y, z, exact_fz)
    P = poly_Newton(x, y, %T);
    Pz = horner(P, z);
    Pz_erro = abs(Pz - exact_fz);
    n = size(x, '*') - 1;
    mprintf("\nInterpolação com polinômio de grau %d = %8.6f (erro %8.6f)\n",...
        n, Pz, Pz_erro);
    mprintf("--------------------------------------------------------------\n");
    
endfunction

funcao = "log(x)";
deff("y = f(x)", "y = "+funcao);
z = 8;
exact_fz = f(z);

// amostra inicial
x = [1 2 3 5 9 10 12];
y = feval(x, f);

mprintf("\nAmostra :\n")
print_vect('x', x);
print_vect('y', y);
mprintf("Função original que relaciona os pontos da tabela (amostra)  = %s\n", funcao);
mprintf("Ponto a ser definido na interpolação z = %g\n", z)

interpolar(x, y, z, exact_fz);

x = [2 3 5 9 10 12];
y = feval(x, f);
interpolar(x, y, z, exact_fz);

x = [3 5 9 10 12];
y = feval(x, f);
interpolar(x, y, z, exact_fz);

x = [5 9 10 12];
y = feval(x, f);
interpolar(x, y, z, exact_fz);

x = [5 9 10];
y = feval(x, f);
interpolar(x, y, z, exact_fz);

x = [5 9];
y = feval(x, f);
interpolar(x, y, z, exact_fz);

// Erro de truncamento para polinômio interpolador de grau 1, 
// entre os pontos 5 e 9 da abscissa.
// Escolhendo o valor de "e" que representa o maior erro no intervalo [a,b],
// ou seja, max(|f''(x)|) sendo a <= x <= b.
// O código a seguir adota uma busca com precisão de mil pontos no intervalo.
// PS. No caso, essa busca poderia ser feita apenas com os dois pontos
// dos limites do intervalo (5 e 9), 
// pois a derivada é sempre crescente no intervalo [5 9].
// O código é um exemplo de uma possível solução geral (mesmo que imprecisa).
// O importante é sempre considerar que o maior erro possível no intervalo 
// pode não ser nos extremos, pode ser qualquer valor entre eles,
// depende da derivada n+1.
//
grau = 1;
derivada = "-x^(-2)";
deff("y = d2f(x)", "y = " + derivada);
busca_x = linspace(5,9,1000);
busca_y = feval(busca_x, d2f);
max_d2f = busca_y(1);
for i = [1:1000]
    if abs(busca_y(i)) > abs(max_d2f)
        max_d2f = busca_y(i);
    end
end

T2 = max_d2f/factorial(grau+1) * prod(z - x);
mprintf("Erro de truncamento T2(x) = %12.8f\n", T2);
