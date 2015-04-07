// limpar a janela de comandos
clc;
// limpa as variáveis
clear;
// carga de todos os programas sci de um diretório
getd('..\lib')

mode(0)
mprintf("\nRaízes de equação: Método de Newton-Raphson\n");

//----------------------------------------------------------------------------
funcao = "x^4 + 2*x^3 - 13*x^2 - 14*x + 24";
derivada = "4*x^3 + 6*x^2 - 26*x - 14"

deff("y = f(x)", "y = "+funcao);
deff("y = df(x)", "y = "+derivada);

x0 = 4;
eps = 10^(-5);
prec = 6; // casas decimais

mprintf("\n## Exemplo 1 do livro: %s = 0 (épsilon < %g)\n\n", funcao, eps);
deff("y = f(x)", "y = "+funcao);
iter = 100;


x = Newton_Raphson(f, df, x0, eps, iter);
mprintf("Raiz (partindo de %g) = %10.5f \n", x0, x);

x = Newton_Raphson_px(f, df, x0, eps, iter);
mprintf("Raiz (partindo de %g) = %10.5f \n", x0, x);

x = Newton_Raphson_pxr(f, df, x0, eps, iter);
mprintf("Raiz (partindo de %g) = %10.5f \n", x0, x);

x = Newton_Raphson_py(f, df, x0, eps, iter);
mprintf("Raiz (partindo de %g) = %10.5f \n", x0, x);

x = Newton_Raphson_prec(f, df, x0, eps, iter, prec);
mprintf("Raiz (partindo de %g) = %10.5f \n", x0, x);

//----------------------------------------------------------------------------
funcao = "2*x^3 - 13*x^2 - 14*x + 26";
derivada = "6*x^2 - 26*x - 14";

deff("y = f(x)", "y = "+funcao);
deff("y = df(x)", "y = "+derivada);

x0 = 7;
eps = 10^(-5);
iter = 100;
prec = 5; // casas decimais

x = Newton_Raphson(f, df, x0, eps, iter);
mprintf("Raiz (partindo de %g) = %10.5f \n", x0, x);

x = Newton_Raphson_prec(f, df, x0, eps, iter, prec);
mprintf("Raiz (partindo de %g) = %10.5f \n", x0, x);


//----------------------------------------------------------------------------

