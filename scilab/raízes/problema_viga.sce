//
// As frequências de vibração de uma viga de densidade uniforme e 
// de comprimento unitário, presa em uma das extremidades e livre na outra, 
// satisfaz a equação:
// tan(x)*tanh(x) = −1
// sendo tanh a tangente hiperbólica. 
// Use um método numérico para determinar a menor raiz positiva desta equação. 
// Faça o gráfico da função entre 0 e 5 antes.
//
// Solução:
// tan(x)*tanh(x) = −1 => f(x) = tan(x)*tanh(x) + 1 = 0
//

clear;
getd('..\lib');

funcao = "tan(x)*tanh(x) + 1";
derivada = "(sec(x)^2)*tanh(x) + tan(x)*(sech(x)^2)";
deff("y = f(x)", "y = "+funcao);
deff("y = df(x)", "y = "+derivada);
eps = 0.001;
prec = 3; // casas decimais
iter = 100;
mprintf("\n## Problema da frequências de vibração de uma viga: %s = 0 (épsilon < %g)\n\n", funcao, eps);

x0 = 1;

x_nr = Newton_Raphson_py(f, df, x0, eps, iter);
mprintf("Raiz (partindo de %g) = %12.8f \n", x0, x_nr);

a = 2;
b = 4;

t_b = bissecao_px(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, t_b);

// plot da função
a_plot = 0;
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
