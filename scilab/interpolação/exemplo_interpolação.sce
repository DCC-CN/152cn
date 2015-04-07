// limpar a janela de comandos
clc;
// limpa as variáveis
clear;
// carga de todos os programas sci de um diretório
getd('.')
getd('../lib')


function exemplo_plot_interp(P, a, b, control, caption)
    fig = scf(control); // Define o controle de figura 
    clf(control); // Limpa a figura 
    fig.figure_name = caption;
    plot(x, y, 'ro');
    // 
    // linspace(a,b,n) retorna um vetor com n valores (pontos) igualmente 
    // espaçados entre a e b
    //
    inter_x = linspace(a, b, 100);
    inter_y = horner(Px, inter_x);
    plot(inter_x, inter_y, 'b-');
    legend('amostra', pol2str(Px));
endfunction

mode(0);
mprintf("\nExemplos de interpolação polinomial:\n");

//----------------------------------------------------------------------------
exemplo = "### Exemplo 1: Interpolação linear versus polinomial"
mprintf("\n================================================================\n");
mprintf("%s\n", exemplo);

x=[1 10 20 30 40];
y=[1 30 -10 20 40];
xi = -1:0.1:45;

fig = scf(0); 
clf(0);  
fig.figure_name = exemplo;
plot(x,y,'ro');
yi=interpln([x;y],xi);
plot(xi,yi,'g-');

//-----------------------------------------------------------------------------
// Interpolação pelo método de Newton
Px = poly_Newton(x, y);
yi = horner(Px, xi);
plot(xi,yi, 'b-');
legend("amostra", "interp. linear", pol2str(Px), "in_lower_left");
mprintf(">>> Veja o gráfico\n");

mprintf("\n================================================================\n");
mprintf("### Exemplo 2: Polinômios interpoladores\n");
x = [ 0      5     10     15]
y = [ 1.792  1.519  1.308  1.114]

// Pontos a serem definidos
inter_x = [8 12]
//-----------------------------------------------------------------------------
// Interpolação pelo método de Lagrange
mprintf("\n----------------------------------------------------------------\n");
Px = poly_Lagrange(x, y);
//
// horner(P, x) resolve o polinômio P para cada valor de x [substituição y=P(x)]
//
inter_y = horner(Px, inter_x);
mprintf("\nPolinômio interpolador pelo método de Lagrange:\n");
mprintf("P(x) = %s\n", pol2str(Px));
disp(inter_y, "y_inter = P(x_inter)");

//-----------------------------------------------------------------------------
// Interpolação pelo método de Newton
mprintf("\n----------------------------------------------------------------\n");
Px = poly_Newton(x, y, %T);
inter_y = horner(Px, inter_x);
mprintf("\nPolinômio interpolador pelo método de Newton:\n");
mprintf("P(x) = %s\n", pol2str(Px));
disp(inter_y, "y_inter = P(x_inter)");

//-----------------------------------------------------------------------------
// Interpolação pelo método de Gregory-Newton
exemplo = "Polinômio interpolador pelo método de Gregory-Newton";
mprintf("\n----------------------------------------------------------------\n");
Px = poly_Gregory_Newton(x, y, %T);
inter_y = horner(Px, inter_x);
mprintf("\n%s:\n", exemplo);
mprintf("P(x) = %s\n", pol2str(Px));
disp(inter_y, "y_inter = P(x_inter)");

exemplo_plot_interp(Px, x(1), x($), 1, exemplo);

//=============================================================================
exemplo = "### Exemplo 3: Ex. do livro pág. 136";
mprintf("\n================================================================\n");
mprintf("%s\n", exemplo);
x = [ 0.1    0.3    0.4    0.6    0.7]
y = [ 0.3162 0.5477 0.6325 0.7746 0.8387]
Px = poly_Newton(x, y, %T)
// Definição do ponto de interpolação
z = 0.2
r = horner(Px, z)

exemplo_plot_interp(Px, x(1), x($), 2, exemplo);

//=============================================================================
exemplo = "### Exemplo 4: Ex. do livro pág. 143";
mprintf("\n================================================================\n");
mprintf("%s\n", exemplo);
x = [ 110    120    130]
y = [ 2.0410 2.0790 2.1140]
Px = poly_Gregory_Newton(x, y, %T)
// Definição do ponto de interpolação
z = 115
r = horner(Px, z)

exemplo_plot_interp(Px, x(1), x($), 3, exemplo);

//----------------------------------------------------------------------------

