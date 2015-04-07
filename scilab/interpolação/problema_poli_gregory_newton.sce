//
//
//

clear;
clc;
getd('../lib');

function print_vect (name, v)
    mprintf("%s = [", name);
    mprintf("%8.6f", v(1));
    for i = 2:size(v, '*')
        mprintf(" %8.6f", v(i));
    end
    mprintf("]\n");
endfunction

funcao = "%e^(x)";
deff("y = f(x)", "y = "+funcao);
z = 1.46;
exact_z = f(z);

x = [1.000 1.200 1.400 1.600 1.800 2.000]
y = feval(x, f);

mprintf("\n");
print_vect("Amostra x", x);
mprintf("Função original que relaciona os pontos da tabela (amostra)  = %s\n", funcao);
mprintf("Ponto a ser definido na interpolação z = %g\n", z);

Px = poly_Gregory_Newton(x, y, %T);
Pz = horner(Px, z);

erro1 = abs(Pz - exact_z);

nplus1 = size(x, '*');
T4 = abs(((%e^(max(x)))/(factorial(nplus1)))*prod(z - x));

mprintf("\nPolinômio de Gregory-Newton = %s\n", pol2str(Px));
mprintf("Valor interpolado em z = %12.8f (erro = %12.8f)\n", Pz, erro1);
mprintf("Erro de truncamento T2(x) = %12.8f\n", T4);

mprintf("-----------------------------------------------------------------\n");

x = [1.200 1.400 1.600];
y = feval(x, f);

mprintf("\n");
print_vect("Amostra x", x);
mprintf("Função original que relaciona os pontos da tabela (amostra)  = %s\n", funcao);
mprintf("Ponto a ser definido na interpolação z = %g\n", z)

Px = poly_Gregory_Newton(x, y, %T);
Pz = horner(Px, z);

erro2 = abs(Pz - exact_z);

// Erro de truncamento:
// Nesse caso, qualquer derivada de e^x = e^x.
// Então, como e^x é sempre crescente e maior que zero, 
// o maior valor absoluto da derivada será dado pelo maior valor de x
nplus1 = size(x, '*');
T2 = abs(((%e^(max(x)))/(factorial(nplus1)))*prod(z - x));

mprintf("\nPolinômio de Gregory-Newton = %s\n", pol2str(Px));
mprintf("Valor interpolado em z = %12.8f (erro = %12.8f)\n", Pz, erro2)
mprintf("Erro de truncamento T2(x) = %12.8f\n", T2);

if  erro1 <= T4 & erro2 <= T2 then
    mprintf("\nOK\n");
else
    mprintf("\nERRO!\n");
end

