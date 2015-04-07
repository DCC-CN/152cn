// Lista de exercícios 1

// limpar a janela de comandos
clc;
// suprimir mensagem de redefição de função
funcprot(0);
// carga de todos os programas sci de um diretório
getd('../lib')

mprintf("\n#### Lista de exercícios 1\n\n");

//--------------------------------------------------------------------------
clear variables;
mprintf("\n## Questão 1: Raízes de equações\n\n");

func = "4*x^4 - 2*x^3 + 3*x^2 -x - 2";
deff("y = f(x)", "y = "+func);
eps = 0.1;
iter = 100;
mprintf("Equação: %s = 0\n\n", func);
mprintf("Método da bisseção (tolerância < %g):\n", eps);
a = 0;
b = 1;
x = bissecao(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %10.2f \n\n", a, b, x);

a = -1;
b = 0;
x = bissecao(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %10.2f \n\n", a, b, x);

k = bissecao_iteracoes_px(a, b, eps)
mprintf("Mínimo de iterações previstas no critério de parada |b-a| < eps: k >= %g \n\n", k);

//--------------------------------------------------------------------------
// limpa as variáveis
clear variables;
mprintf("\n## Questão 2: Raízes de equações\n\n");

func = "2*x^3 - 13*x^2 - 14*x + 26";
derivada = "6*x^2 - 26*x - 14"
deff("y = f(x)", "y = "+func);
deff("y = df(x)", "y = "+derivada);
eps = 10^(-5)
iter = 100;

mprintf("Equação: %s = 0\n", func);
mprintf("Derivada: %s \n\n", derivada);
mprintf("Método de Newton-Raphson (epsilon < %g):\n", eps);
a = 7;
b = 8;
x0 = a
x = Newton_Raphson(f, df, x0, eps, iter);
mprintf("Raiz (partindo de %g) = %10.5f \n", x0, x);

//--------------------------------------------------------------------------
// limpa as variáveis
clear variables;
mprintf("\n## Questão 3: Integração numérica\n\n");

func = "(1 + x^2)^(-1/2)";
deff("y = f(x)", "y = "+func);
a = 0;
b = 4;
mprintf("Integral definida de (%s)dx no intervalo de %g até %g \n", func, a, b);

mprintf("\nMétodo de Newton-Cotes:\n");
grau_poli_interp = 1;
pontos = 9;
subintervalos = pontos - 1;
h = (b - a)/subintervalos;
mprintf("--- Grau do polinômio interpolador: %g\n", grau_poli_interp);
mprintf("--- Número de subintervalos.......: %g\n", subintervalos);
mprintf("--- h (delta x)...................: %g\n", h);

integral = Newton_Cotes(f, a, b, grau_poli_interp, subintervalos);
mprintf("Integral = %10.5f\n", integral);

// solução analítica
mprintf("\nSolução analítica:\n");
ifunc = "asinh(x)"
deff("y = F(x)", "y = "+ifunc);
Fa = F(a);
Fb = F(b);
integral2 = Fb - Fa;
mprintf("Integral indefinida: %s + C\n", ifunc);

mprintf("Integral apurada analiticamente: (%g) - (%g) = %g\n", Fb, Fa, integral2);
erro1 = abs(integral2 - integral);
mprintf("Diferença (erro apurado numericamente) = %g\n", erro1);


//--------------------------------------------------------------------------
// limpa as variáveis
clear variables;
mprintf("\n## Questão 4: Integração numérica\n\n");

func = "2*x^3 + 2*x^2 -5*x + 4";
deff("y = f(x)", "y = "+func);
a = -2;
b = 0;

mprintf("Integral definida de (%s)dx no intervalo de %g até %g \n", func, a, b);

mprintf("\nMétodo de Gauss-Legendre:\n");
pontos = 2;
mprintf("--- Número de pontos: %g\n", pontos);

integral = Gauss_Legendre(f, a, b, pontos);
mprintf("Integral = %10.2f\n", integral);

// solução analítica
mprintf("\nSolução analítica:\n");
ifunc = "(2*x^4)/4 + (2*x^3)/3 -(5*x^2)/2 + 4*x"
deff("y = F(x)", "y = "+ifunc);
Fa = F(a);
Fb = F(b);
integral2 = Fb - Fa;
mprintf("Integral indefinida: %s + C\n", ifunc);

mprintf("Integral apurada analiticamente: (%g) - (%g) = %g\n", Fb, Fa, integral2);
erro1 = abs(integral2 - integral);
mprintf("Diferença (erro apurado numericamente) = %g\n", erro1);
