function Integral = Newton_Cotes(f, a, b, n, m)
    // Integração numérica pelo método de Newton-Cotes
    // f: função
    // a, b: intervalo (limite inferior e superior) da função
    // n: grau do polinômio
    // m: número de subintervalos (slices)
    
    // verifica pré-condições (consitência dos parâmetros)
    if (n < 1) | (n > 8) then
        error("Grau do polinômio menor que 1 ou maior que 8");
    end
    if modulo(m, n) <> 0 then
        error("O número de subintervalos m não é múltiplo do grau do polinômio n");
    end
    // inicializa variáveis
    d = [ 2, 6, 8, 90, 288, 840, 17280, 28350];
    c = [ 1, 1, 4, 1, 3, 7, 32, 12, 19, 75, 50, 41, 216,...
          27, 272, 751, 3577, 1323, 2989, 989, 5888,...
          -928, 10496, -4540 ];
    Integral = 0;
    // Cálculo da integral
    p = int(0.25 * (n * (n + 2) + modulo(n, 2)));
    h = (b - a) / m;
    mprintf("\n------------------------------------------------------------\n");
    mprintf("Integração por Newton-Cotes:\n");
    txt = fun2string(f,'f');
    mprintf("%s\n",txt(2:$-1));
    mprintf("  -- Intervalo [a, b].: [%g, %g]\n", a, b);
    mprintf("  -- Grau do polinômio: %g\n", n);
    mprintf("  -- Subintervalos....: %g\n", m);
    mprintf("---- Solução:\n");
    printf("   i         x(i)        y(i)        c(i)\n");
    for i = 0:1:m
        x = a + i * h;
        y = f(x);
        j = p + int(0.5 * n - abs(modulo(i, n) - 0.5 * n));
        k = 1 + int((n - modulo(i, n)) / n) - int((m - modulo(i, m)) / m);
        Integral = Integral + y * c(j) * k;
        mprintf("%4d  %12.8f  %12.8f  %6d \n", i, x, y, k);
    end;
    fator = n/d(n);
    printf("  >> Integral = %d/%d * %12.8f * %12.8f\n", n, d(n), h, Integral);
    printf("              = %12.8f * %12.8f * %12.8f\n", fator, h, Integral);
    Integral = fator * h * Integral;
endfunction

function Integral = Newton_Cotes_prec(f, a, b, n, m, prec)
    // Integração numérica pelo método de Newton-Cotes
    // f: função
    // a, b: intervalo (limite inferior e superior) da função
    // n: grau do polinômio
    // m: número de subintervalos (slices)
    // prec: precisão em casas decimais (fround)
    
    // verifica pré-condições (consitência dos parâmetros)
    if (n < 1) | (n > 8) then
        error("Grau do polinômio menor que 1 ou maior que 8");
    end
    if modulo(m, n) <> 0 then
        error("O número de subintervalos m não é múltiplo do grau do polinômio n");
    end
    // inicializa variáveis
    d = [ 2, 6, 8, 90, 288, 840, 17280, 28350];
    c = [ 1, 1, 4, 1, 3, 7, 32, 12, 19, 75, 50, 41, 216,...
          27, 272, 751, 3577, 1323, 2989, 989, 5888,...
          -928, 10496, -4540 ];
    Integral = 0;
    // Cálculo da integral
    a = fround(a, prec);
    b = fround(b, prec);
    p = int(0.25 * (n * (n + 2) + modulo(n, 2)));
    h = fround((b - a) / m, prec);
    mprintf("\n------------------------------------------------------------\n");
    mprintf("Integração por Newton-Cotes:\n");
    txt = fun2string(f,'f');
    mprintf("%s\n",txt(2:$-1));
    mprintf("  -- Intervalo [a, b].: [%g, %g]\n", a, b);
    mprintf("  -- Grau do polinômio: %g\n", n);
    mprintf("  -- Subintervalos....: %g\n", m);
    mprintf("  -- Precisão.........: %g casas decimais\n", casas_decimais);
    mprintf("\n---- Solução:\n");
    printf("   i         x(i)        y(i)        c(i)\n");
    for i = 0:1:m
        x = fround(a + i * h, prec);
        y = fround(f(x), prec);
        j = p + int(0.5 * n - abs(modulo(i, n) - 0.5 * n));
        k = c(j) * (1 + int((n - modulo(i, n)) / n) - int((m - modulo(i, m)) / m));
        inc = fround(k * y, prec);
        Integral = fround(Integral + inc, prec);
        mprintf("%4d  %12.8f  %12.8f  %6d \n", i, x, y, k);
    end;
    fator = fround(n/d(n), prec);
    printf("  >> Integral = %d/%d * %12.8f * %12.8f\n", n, d(n), h, Integral);
    printf("              = %12.8f * %12.8f * %12.8f\n", fator, h, Integral);
    Integral = fround(fator * h * Integral, prec);
endfunction
