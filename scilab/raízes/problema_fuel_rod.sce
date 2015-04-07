//
// Na teoria do transporte de nêutrons, 
// o comprimento crítico de uma barra de combustível nuclear (fuel rod) 
// é determinado pelas raízes da equação
// cot(x) = (x^2 - 1)/(2*x)
// Encontre a menor raiz positiva desta equação.
//
// Solução:
// cot(x) = (x^2 - 1)/(2*x) => f(x) = (x^2 - 1)/(2*x) - cot(x) = 0
//

clear;
clc;
getd('..\lib');

funcao = "(x^2 - 1)/(2*x) - cotg(x)";
derivada = "1/2*(1/x^2+1)+csc(x)^2";
deff("y = f(x)", "y = "+funcao);
deff("y = df(x)", "y = "+derivada);
eps = 0.001;
prec = 6; // casas decimais
iter = 100;
mprintf("\n## Problema do conbustível nuclear: %s = 0 (épsilon < %g)\n\n", funcao, eps);

x0 = 1;

t_nr = Newton_Raphson_py(f, df, x0, eps, iter);
mprintf("Raiz (partindo de %g) = %12.8f \n", x0, t_nr);
t_nr = Newton_Raphson_prec(f, df, x0, eps, iter, prec);
mprintf("Raiz (partindo de %g) = %12.8f \n", x0, t_nr);

a = 1;
b = 2;

t_b = bissecao_px(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, t_b);
t_b = bissecao_prec(f, a, b, eps, iter, prec);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, t_b);

// plot da função
a_plot = 0.1; // esta fração evita uma divisão por zero
b_plot = 8;
x_plot = [a_plot:0.01:b_plot]
y_plot = feval(x_plot, f)
// remove os pontos com valores absolutos "grandes" (tendendo ao infinito)
// isso remove a linha de descontinuidade da função (ex. -inf até +inf)
// note que esta é uma solução muito particular para este esboço específico
this_inf = 100;
for i = [1:size(y_plot, "*")]
    if abs(y_plot(i)) > this_inf then
        y_plot(i) = %inf
    end
end
// gera o gráfico limitando a região de desenho
plot2d(x_plot, y_plot, leg = funcao, rect = [a_plot,-10,b_plot,10]);
haxes=gca();                       // manipulador (handle) de eixos atual
haxes.x_location = "origin";       // posiciona eixo x na origem
haxes.y_location = "origin";       // posiciona eixo x na origem
axe = haxes.children(1);           // obtém o primeiro eixo (x,y) (2d)
line = axe.children(1);            // obtém a primeira linha do eixo
line.thickness = 1;                // ajusta a largura da linha
line.foreground = color('red');    // ajusta a cor da linha
