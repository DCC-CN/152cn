//
//
//
clear;
clc;
getd('../lib');
getd('.');

// exemplos do livro Algoritmos Numéricos, 2a. ediçao

x = [0.3 2.7 4.5 5.9 7.8];
y = [1.8 1.9 3.1 3.9 3.3];

[b1 b0 r2 s2] = reglin_simples(x, y, %T);

x_reg = linspace(0,10,1000);
y_reg = b1*x_reg + b0;
plot(x, y, 'g.');
plot(x_reg, y_reg, 'r-');
