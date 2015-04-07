//------------------------------------------
mode(5)  // modo de execução com saída de comandos e resultados

// limpa a tela de comandos
clc  
// libera a memória de todas as variáveis 
// incluindo funções definidas dinamicamente
clear 

// cria um polinômio baseado nas raizes da equação P(x) = 0
raizes = [-1 0 2 3]
Pr = poly(raizes, 'x')

// cria um polinômio baseado nos coeficientes
coeficientes = [3 4 5 6]
Pc = poly(raizes, 'x', 'c')

// cria um monômio x
Pu = poly(0, 'x')

// Operações algébricas
// Soma de polinômios
Psp = Pr + Pu
// Soma por escalar
Pse = Pu + 100
// Multiplicação por escalar
Pmp = Pc * 10
// Multiplicação de polinômios
Pmp = Pc*Pu
// Divisão de polinômios 
Pdp = Pu / Pc
// Exponenciação
Pep = Pu ^ 3

// Derivação simbólica de polinômio
Pd=derivat(Pr)

// Susbtituição em polinômio
x = 2
y = horner(Pc, x)

// Gráfico com substituição de múltiplos pontos
// 
// linspace(a,b,n) retorna um vetor com valores igualmente espaçados entre a e b
//
plot_x = linspace(-3, 3, 200);
plot_y = horner(Pc, plot_x);
plot(plot_x, plot_y, 'b-');
plot(x, y, 'ro');
legend(pol2str(Pc), 'f(2)');
