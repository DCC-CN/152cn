//
// A distancia vertical y que um paraquedista cai antes de abrir seu paraquedas 
// é dada pela equação:
// y = 1/k * log(cosh(t*sqrt(g*k)))
// sendo t o tempo transcorrido em segundos, 
// g = 9.8065 m/s^2 a aceleração devido à força da gravidade, 
// e k = 0.00341 m^(−1) uma constante relacionada à resistência do ar. 
// A função cosh é o cosseno hiperbólico. 
// Use o método de Newton e da bisseção para encontrar 
// o tempo necessário para ter uma queda de 1 km.
//
// Solução:
// y = 1000 => 1000 = 1/k * log(cosh(t*sqrt(g*k))) =>
// f(x) = 1/k * log(cosh(t*sqrt(g*k))) - 1000
//

clear;
clc;
getd('..\lib');

k = 0.00341;
g = 9.8065;

funcao = "1/k * log(cosh(t*sqrt(g*k))) - 1000";
derivada = "(g*tanh(t*sqrt(g*k)))/sqrt(g*k)";
deff("y = f(t)", "y = "+funcao);
deff("y = df(t)", "y = "+derivada);
eps = 0.001;
prec = 6; // casas decimais
iter = 100;
mprintf("\n## Problema do paraquedista: %s = 0 (épsilon < %g)\n\n", funcao, eps);

t0 = 1;

t_nr = Newton_Raphson_py(f, df, t0, eps, iter);
mprintf("Raiz (partindo de %g) = %12.8f \n", t0, t_nr);
t_nr = Newton_Raphson_prec(f, df, t0, eps, iter, prec);
mprintf("Raiz (partindo de %g) = %12.8f \n", t0, t_nr);

a = 22;
b = 23;

t_b = bissecao_px(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, t_b);
t_b = bissecao_prec(f, a, b, eps, iter, prec);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, t_b);

// plot da função
a = 0;
b = 50;
t_plot = [a:0.1:b];
y_plot = feval(t_plot, f);
plot2d(t_plot, y_plot, leg = funcao);
haxes=gca();                       // manipulador (handle) de eixos atual
haxes.x_location = "origin";       // posiciona eixo x na origem
haxes.y_location = "origin";       // posiciona eixo y na origem
axe = haxes.children(1);           // obtém o primeiro eixo (x,y) (2d)
line = axe.children(1);            // obtém a primeira linha do eixo
line.thickness = 1;                // ajusta a largura da linha
line.foreground = color('red');    // ajusta a cor da linha
