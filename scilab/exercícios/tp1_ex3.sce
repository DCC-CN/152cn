// limpar a janela de comandos
clc;
// limpa as variáveis
clear;
// ATENCÃO: Ao executar, selecione o diretório com os programas fontes do trabalho
// carrega arquivos .sci do diretório ('.' = diretório atual)
getd('../lib');

mprintf("Trabalho prático de integração numérica.\n");

//-----------------------------------------------------------------------------
mprintf("\nIntegração da função f(x) = sen(x) no intervalo de 0 a pi\n")
deff("y = f(x)", "y = sin(x)");
a = 0;
b = %pi
Integral1 = -cos(b) - (-cos(a));
mprintf("Solução analítica = %10.6g\n", Integral1);


mprintf("\nIntegração por Newton-Cotes com polinômio de grau 2\n")
Integral2 = Newton_Cotes(f, a, b, 2, 6);
mprintf("Integral = %10.6g\n", Integral2);
Erro1 = Integral1 - Integral2
mprintf("Erro     = %15.11g\n", Erro1);

mprintf("\nIntegração por Newton-Cotes com polinômio de grau 3\n")
Integral3 = Newton_Cotes(f, a, b, 3, 6);
mprintf("Integral = %10.6g\n", Integral3);
Erro2 = Integral1 - Integral3
mprintf("Erro     = %15.11g\n", Erro2);

mprintf("\nIntegração por Gauss-Legendre com 5 pontos\n")
Integral4 = Gauss_Legendre(f, a, b, 5);
mprintf("Integral = %15.11g\n", Integral4);
Erro3 = Integral1 - Integral4
mprintf("Erro     = %15.11g\n", Erro3);

mprintf("\nIntegração por Gauss-Legendre com 6 pontos\n")
Integral5 = Gauss_Legendre(f, a, b, 6);
mprintf("Integral = %15.11g\n", Integral5);
Erro4 = Integral1 - Integral5
mprintf("Erro     = %15.11g\n", Erro4);

//-----------------------------------------------------------------------------
mprintf("\nIntegração da função f(x) = 4/(1+x^2) no intervalo de 0 a 1\n")
deff("y = g(x)", "y = 4/(1+x^2)");

mprintf("\nIntegração por Gauss-Legendre com 10 pontos\n")
Integral6 = Gauss_Legendre(g, 0, 1, 10);
mprintf("Integral   = %15.11g\n", Integral6);
Compara = %pi - Integral6
mprintf("Diferença com a constante pi = %15.11g\n", Compara);

//-----------------------------------------------------------------------------
// Teste final
mprintf("\nTestes (1/5):\n")
if abs(Erro1) < 10^(-3) then
    mprintf("1 - OK\n")
end
if abs(Erro2) < 10^(-2) then
    mprintf("2 - OK\n")
end
if abs(Erro3) < 10^(-6) then
    mprintf("3 - OK\n")
end
if abs(Erro4) < 10^(-9) then
    mprintf("4 - OK\n")
end
if abs(Compara) < 10^(-10) then
    mprintf("5 - OK\n")
end
