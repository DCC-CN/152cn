//
//
//
clear;
clc;
getd('../lib');

function plot_all(fig, a, b, Px, f, funcao, wtitle) 
    fig_ctl = scf(fig); // Define o controle de figura 
    clf(fig); // Limpa a figura 
    fig_ctl.figure_name = wtitle;
    x_plot = linspace(a, b, 1000);
    p_plot = horner(Px, x_plot);
    y_plot = feval(x_plot, f);
    plot(x,y, 'ro');              // mostra pontos da amostra
    plot(x_plot, y_plot, 'r-');   // mostra a função exata
    plot(x_plot, p_plot, 'b-');   // mostra o polinômio interpolador
    legend('amostra', funcao, pol2str(Px), "lower_caption");
endfunction


funcao = "log(2*x-2)";
deff("y = f(x)", "y = "+funcao);

// pontos da abscissa (x) que serão interpolados 
// (note que z2 faz parte de todas as amostras)
z1 = 7;
z2 = 15;
exact_yz1 = f(z1);
exact_yz2 = f(z2);

mprintf("\n### Exemplo de interpolação polinomial:\n");
mprintf("Função original f(x) = %s\n", funcao);
mprintf("Pontos a serem interpolados: %g e %g\n", z1, z2);


///----------------------------------------------------------------------------
x = [5 15 25];
y = feval(x, f);
Px = poly_Gregory_Newton(x, y);

yz1 = horner(Px, z1);
yz2 = horner(Px, z2);

erro_c_z1 = abs(yz1 - exact_yz1);
erro_c_z2 = abs(yz2 - exact_yz2);

mprintf("\nPolinômio interpolador de grau %d\n", size(x, '*') - 1);
disp(x, 'amostra');
mprintf("Polinômio interpolador = %s\n", pol2str(Px));
mprintf("Erro no ponto z1 = %g = %g\n", z1, erro_c_z1);
mprintf("Erro no ponto z2 = %g = %g\n", z2, erro_c_z2);

plot_all(0,  5, 35, Px, f, funcao, "Pol. de grau 2 (no intervalo)");
plot_all(1,  -15, 60,   Px, f, funcao, "Pol. de grau 2 (fora do intervalo)");

///----------------------------------------------------------------------------
x = [5 15 25 35];
y = feval(x, f);
Px = poly_Gregory_Newton(x, y);

yz1 = horner(Px, z1);
yz2 = horner(Px, z2);

erro_b_z1 = abs(yz1 - exact_yz1);
erro_b_z2 = abs(yz2 - exact_yz2);

mprintf("\nPolinômio interpolador de grau %d\n", size(x, '*') - 1);
disp(x, 'amostra');
mprintf("Polinômio interpolador = %s\n", pol2str(Px));
mprintf("Erro no ponto z1 = %g = %g\n", z1, erro_b_z1);
mprintf("Erro no ponto z2 = %g = %g (MENOR ERRO)\n", z2, erro_b_z2);

plot_all(2,  5, 35, Px, f, funcao, "Pol. de grau 3 (no intervalo)");
plot_all(3,  -15, 60,   Px, f, funcao, "Pol. de grau 3 (fora do intervalo)");

///----------------------------------------------------------------------------
x = [5 10 15 20 25 30 35];
y = feval(x, f);
Px = poly_Gregory_Newton(x, y);

yz1 = horner(Px, z1);
yz2 = horner(Px, z2);

erro_a_z1 = abs(yz1 - exact_yz1);
erro_a_z2 = abs(yz2 - exact_yz2);

mprintf("\nPolinômio interpolador de grau %d\n", size(x, '*') - 1);
disp(x, 'amostra');
mprintf("Polinômio interpolador = %s\n", pol2str(Px));
mprintf("Erro no ponto z1 = %g = %g (MENOR ERRO)\n", z1, erro_a_z1);
mprintf("Erro no ponto z2 = %g = %g\n", z2, erro_a_z2);

plot_all(4,  5, 35, Px, f, funcao, "Pol. de grau 6 (no intervalo)");
plot_all(5,  -5, 50,   Px, f, funcao, "Pol. de grau 6 (fora do intervalo)");

mprintf("\n\nConclusão sobre erro:\n"+...
        "O aumento do grau do polinômio (amostra) "+...
        "tender a diminuir o erro,\n"+...
        "por causa do aumento da precisão. "+...
        "Porém, na prática, a distância entre o ponto interpolado\n"+...
        "e os pontos da amostra afeta mais o erro.\n"+...
        "POR ISSO, NO CÁLCULO DO POLINÔMIO INTERPOLADOR,\n"+...
        "É IMPORTANTE ESCOLHER OS PONTOS DA AMOSTRA MAIS PRÓXIMOS "+...
        "DO PONTO A SER INTERPOLADO. \n"+...
        "Obviamente, se houver como escolher :)");

mprintf("\n\nConclusão sobre interpolação (veja os gráficos):\n"+...
        "O ponto a ser interpolado (z), deve estar entre (inter) os "+...
        "pontos amostra.\n"+...
        "Calcular pontos desconhecidos (z) fora dos limites da amostra é extrapolação!");
