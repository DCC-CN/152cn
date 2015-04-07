// limpar a janela de comandos
clc;
// limpa as variáveis
clear;
// carga de todos os programas sci de um diretório
getd('..\lib')

mode(0)
mprintf("\nRaízes de equação: Método da Bisseção\n");

//----------------------------------------------------------------------------
funcao = "2*x^3 - cos(x+1) - 3";
a = -1;
b = 2;
eps = 0.01;
prec = 3; // casas decimais

mprintf("\n## Exemplo 1 do livro: %s = 0 (épsilon < %g)\n\n", funcao, eps);
deff("y = f(x)", "y = "+funcao);
iter = 100;

x = bissecao(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, x);

x = bissecao_px(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, x);
k = bissecao_iteracoes_px(a, b, eps)
mprintf("Iterações previstas k >= %g \n\n", k);

x = bissecao_pxr(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, x);

x = bissecao_py(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, x);

x = bissecao_prec(f, a, b, eps, iter, prec);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, x);

//----------------------------------------------------------------------------
funcao = "0.05*x^3 - 0.4*x^2 + 3*sin(x)*x";
a = 10;
b = 12;
eps = 0.005;

mprintf("\n## Exemplo 2 do livro: %s = 0 (épsilon < %g)\n\n", funcao, eps);
deff("y = f(x)", "y = "+funcao)
iter = 100;

x = bissecao(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n", a, b, x);

//----------------------------------------------------------------------------

func = "4*x^4 - 2*x^3 + 3*x^2 -x - 2";
deff("y = f(x)", "y = "+func);
eps = 0.01;
iter = 100;

mprintf("\n## Exercício de aula: %s = 0 (épsilon < %g)\n\n", func, eps);

a = 0;
b = 1;
x = bissecao(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f \n\n", a, b, x);

a = -1;
b = 0;
x = bissecao(f, a, b, eps, iter);
mprintf("Raiz no intervalo [%d, %d] = %.8f\n", a, b, x);

// Exemplo com erro
try
    func = "x^3 - 2*x^2 - 2*x - 1";
    a = 1;
    b = 2;
    deff("y = f(x)", "y = "+func);
    mprintf("\n## Exercício de lista: %s = 0\n", func);
    deff("y = f(x)", "y = "+func)
    x = bissecao(f, a, b, 10^(-5), 100);
    mprintf("Raiz no intervalo [%d, %d] = %.8f\n", a, b, x);
catch 
    mprintf("  !! Erro: %s\n", lasterror());
end
