//
//
//
clear;
clc;
getd('../lib');
getd('.');

// exemplo do livro Algoritmos Numéricos, 2a. ediçao
x = [ 1.2 2.5 3.0 4.1  6.2  7.1  8.8  9.5];
y = [ 6.8 6.1 9.9 9.7 12.1 17.9 18.0 21.5];
[b1 b0 r2 s2] = reglin_simples(x, y, %T);

x_reg = linspace(0,10,1000);
y_reg = b1*x_reg + b0;
plot(x, y, 'g.');
plot(x_reg, y_reg, 'r-');
