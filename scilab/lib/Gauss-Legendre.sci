function [A, t] = PesAbsGL(n)
    // Calculo de pesos e abscissas para fórmula de Gauss-Legendre
    // n: número de pontos

    if (n < 1) then
        error("O número de pontos deve ser igual ou maior que 1");
    end
    m = int(0.5 * (n+1));
    for i = 1:1:m
        z = cos(%pi * (i - 0.25)/(n + 0.5));
        while %T
            p1 = 1;
            p2 = 0;
            for j = 1:1:n
                p3 = p2;
                p2 = p1;
                p1 = ((2*j - 1) * z * p2 - (j - 1) * p3) / j;
            end
            // Derivada do polinômio de Legendre no ponto z
            pp = n * (z * p1 - p2)/(z^2 - 1);
            z1 = z;
            z = z1 - p1/pp;
            if abs(z - z1) < 10^(-15) then
                break;
            end
        end
        index = m+1-i;
        t(index) = z;  // abscissa
        A(index) = 2/((1 - z^2) * pp^2); // peso 
    end
endfunction

function Integral = Gauss_Legendre(f, a, b, n)
    // Integração numérica pelo método de Gauss-Legendre
    // f: função
    // a, b: intervalo (limite inferior e superior) da função
    // n: número de pontos

    Integral = 0;
    [A, t] = PesAbsGL(n);
    e1 = (b-a)/2;
    e2 = (a+b)/2;
    if modulo(n, 2) == 0 then
        c1 = 1;
        c2 = 0.5;
    else
        c1 = 0;
        c2 = 1;
    end
    mprintf("\n------------------------------------------------------------\n");
    mprintf("Integração por Gauss-Legendre:\n");
    txt = fun2string(f,'f');
    mprintf("%s\n",txt(2:$-1));
    mprintf("  -- Intervalo [a, b]: [%g, %g]\n", a, b);
    mprintf("  -- Pontos..........: %g\n", n);
    mprintf("  i      t(i)          x(i)         f(x(i))        A(i)\n");
    for i = 1:1:n
        k = int(i - 0.5*(n+1) + sign(i - 0.5*(n + c1)) * c2)
        tk = sign(k) * t(abs(k));
        x = e1 * tk + e2;
        y = f(x);
        c = A(abs(k));
        Integral = Integral + y * c;
        mprintf("%04d  %12.8f  %12.8f  %12.8f  %12.8f\n", i, tk, x, y, c);
    end
    printf("  >> Integral = ((%.8f) - (%.8f))/2 * %.8f\n", b, a, Integral);
    printf("              =  %.8f * %.8f\n", e1, Integral);
    Integral = e1 * Integral;
endfunction

function Integral = Gauss_Legendre_prec(f, a, b, n, prec)
    // Integração numérica pelo método de Gauss-Legendre
    // f: função
    // a, b: intervalo (limite inferior e superior) da função
    // n: número de pontos
    // prec: precisão em casas decimais (fround)

    Integral = 0;
    [A, t] = PesAbsGL(n);
    a = fround(a, prec);
    b = fround(b, prec);
    e1 = fround((b-a)/2, prec);
    e2 = fround((a+b)/2, prec);
    if modulo(n, 2) == 0 then
        c1 = 1;
        c2 = 0.5;
    else
        c1 = 0;
        c2 = 1;
    end
    mprintf("\n------------------------------------------------------------\n");
    mprintf("Integração por Gauss-Legendre:\n");
    txt = fun2string(f,'f');
    mprintf("%s\n",txt(2:$-1));
    mprintf("  -- Intervalo [a, b]: [%g, %g]\n", a, b);
    mprintf("  -- Pontos..........: %g\n", n);
    mprintf("  -- Precisão........: %g casas decimais\n", prec);
    mprintf("  i      t(i)          x(i)         f(x(i))        A(i)\n");
    for i = 1:1:n
        k = int(i - 0.5*(n+1) + sign(i - 0.5*(n + c1)) * c2)
        t = fround(sign(k) * t(abs(k)), prec);
        x = fround(e1 * t + e2, prec);
        y = fround(f(x), prec);
        c = A(abs(k));
        Integral = Integral + fround(y * c, prec);
        mprintf("%04d  %12.8f  %12.8f  %12.8f  %12.8f\n", i, t, x, y, c);
    end
    printf("  >> Integral = ((%.8f) - (%.8f))/2 * %.8f\n", b, a, Integral);
    printf("              =  %.8f * %.8f\n", e1, Integral);
    Integral = fround(e1 * Integral, prec);
endfunction
