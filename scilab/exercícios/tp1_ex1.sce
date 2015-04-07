mode(5)
clear
clc

deff("y = f(x)", "y = 4*x^3 + 3*x^2 + x + 1")
deff("y = F(x)", "y = x^4 + x^3 + (x^2)/2 + x")
a = 0
b = 4
exato = F(b) - F(a)
p = 5
m = p - 1
dx = (b - a)/m
x = a:dx:b
y = feval(x, f);
i = dx*((y(1)+y($))/2 + sum(y(2:$-1)))
erro = abs(exato - i)

// Verificação da igualdade com o inttrap
i2 = inttrap(x, y)

if i == i2  then
    mprintf("Os valores são iguais.")
end

// Gráfico
plot2d(x, y)
plot2d3(x, y)
// para salva automaticamente a figura:
//xs2png(gcf(), 'ex1.png');

