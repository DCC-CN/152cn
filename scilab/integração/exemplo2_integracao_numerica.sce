// limpar a janela de comandos
clc;
// limpa as variáveis
clear;
// suprime a mensagem de redefinição de função
funcprot(0);
// ATENCÃO: Ao executar, selecione o diretório com os programas fontes do trabalho
// carrega arquivos .sci do diretório ('.' = diretório atual)
getd('../lib');

mprintf("Trabalho prático de integração numérica.\n");

//-----------------------------------------------------------------------------
funcao = "sin(x)"
integral = "-cos(x)"
a = 0;
b = %pi
mprintf("\nIntegração da função f(x) = %s no intervalo de %g a %g\n", funcao, a, b);
mprintf("\nIntegral indefinida de f(x): F(x) = %s + C\n", integral);

deff("y = f(x)", "y = "+funcao);
deff("y = F(x)", "y = "+integral);

solucaoTFC = F(b) - F(a);
mprintf("Solução analítica = %.8f\n", solucaoTFC);

integral = Newton_Cotes(f, a, b, 1, 6);
mprintf("Integral = %.8f\n", integral);

integral = Newton_Cotes(f, a, b, 2, 6);
mprintf("Integral = %.8f\n", integral);
erro1 = solucaoTFC - integral;

integral = Newton_Cotes(f, a, b, 3, 6);
mprintf("Integral = %.8f\n", integral);
erro2 = solucaoTFC - integral;

integral = Gauss_Legendre(f, a, b, 5);
mprintf("Integral = %.8f\n", integral);
erro3 = solucaoTFC - integral;

integral = Gauss_Legendre(f, a, b, 6);
mprintf("Integral = %.8f\n", integral);
erro4 = solucaoTFC - integral;

//-----------------------------------------------------------------------------
funcao = "4/(1+x^2)"; 
a = 0;
b = 1;
mprintf("\nIntegração da função f(x) = %s no intervalo de %g a %g\n", funcao, a, b);
deff("y = f(x)", "y = " + funcao);
exato = %pi;
integral = Gauss_Legendre(f, a, b, 10);
mprintf("Integral = %.8f\n", integral);
erro5 = exato - integral;

//-----------------------------------------------------------------------------
// Teste final
mprintf("-----------------------------------------------------------------")
mprintf("\nTestes (1/5):\n")
if abs(erro1) < 10^(-3) then
    mprintf("1 - OK\n")
else
    mprintf("1 - FALHA\n")
end
if abs(erro2) < 10^(-2) then
    mprintf("2 - OK\n")
else
    mprintf("2 - FALHA\n")
end
if abs(erro3) < 10^(-6) then
    mprintf("3 - OK\n")
else
    mprintf("3 - FALHA\n")
end
if abs(erro4) < 10^(-9) then
    mprintf("4 - OK\n")
else
    mprintf("4 - FALHA\n")
end
if abs(erro5) < 10^(-10) then
    mprintf("5 - OK\n")
else
    mprintf("5 - FALHA\n")
end
