//
//
//
clear;
clc;
getd('../lib');

function plot_all(control, a, b, Px, f, funcao) 
    scf(control); // Define o controle de figura 
    clf(control); // Limpa a figura 
    x_plot = linspace(a, b, 1000);
    p_plot = horner(Px, x_plot);
    y_plot = feval(x_plot, f);
    plot(x,y, 'ro');              // mostra pontos da amostra
    plot(x_plot, y_plot, 'r-');   // mostra a função exata
    plot(x_plot, p_plot, 'b-');   // mostra o polinômio interpolador
    legend('amostra', funcao, pol2str(Px), "lower_caption");
endfunction

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
    try
        P = poly_Gregory_Newton(x, y, %T);
    catch
        P = poly_Newton(x, y, %T);
    end        
    Pz = horner(P, z);
    Pz_erro = abs(Pz - exact_fz);
    n = size(x, '*') - 1;
    plot_all(n, min(x), max(x), P, f, funcao) 
    mprintf("\nInterpolação com polinômio de grau %d = %8.6f (erro %8.6f)\n",...
        n, Pz, Pz_erro);
    mprintf("Polinômio interpolador = %s\n", pol2str(P));
    mprintf("--------------------------------------------------------------\n");
endfunction

funcao = "x^3+3*x^2-x-3";
deff("y = f(x)", "y = "+funcao);
z = 3;
exact_fz = f(z);

// amostra inicial
x = [-2 1 2 4 5 7];
y = feval(x, f);

mprintf("\nAmostra :\n")
print_vect('x', x);
print_vect('y', y);
mprintf("Função original que relaciona os pontos da tabela (amostra)  = %s\n", funcao);
mprintf("Ponto a ser definido na interpolação z = %g\n", z)

interpolar(x, y, z, f, funcao);

x = [1 2 4 5 7];
y = feval(x, f);
interpolar(x, y, z, f, funcao);

x = [1 2 4 5 7];
y = feval(x, f);
interpolar(x, y, z, f, funcao);

x = [1 2 4 5];
y = feval(x, f);
interpolar(x, y, z, f, funcao);

x = [1 2 4];
y = feval(x, f);
interpolar(x, y, z, f, funcao);

x = [2 4];
y = feval(x, f);
interpolar(x, y, z, f, funcao);

