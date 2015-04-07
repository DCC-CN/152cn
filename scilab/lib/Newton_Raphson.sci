function x = Newton_Raphson(f, df, x0, eps, n)
    // metodo de Newton-Raphson para encontrar raiz de equacao nao-linear f(x)=0
    // x0: ponto inicial
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro

    eps = abs(eps);
    fx0 = f(x0);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da Newton-Raphson:\n");
    txt = fun2string(f,'f');
    mprintf("  -- Função............: %s\n",txt(2:$-1));
    txt = fun2string(df,'df');
    mprintf("  -- Derivada da função: %s\n",txt(2:$-1));
    mprintf("  -- x0................: %g\n", x0);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em x e y, |x(n)-x(n-1)| < e ou |f(x)| < e\n");

    if (abs(fx0) < eps) then
        mprintf("raiz em x0");
        x = x0;
        return;
    end;

    mprintf("  i    x(i)        f(x(i))      f`(x(i))      x(i+1)      f(x(i+1))\n");
    for i = 1:1:n
        dfx0 = df(x0);
        x = x0 - fx0 / dfx0;
        fx = f(x);
        mprintf("%3d  %12.8f %12.8f %12.8f %12.8f %12.8f\n",...
                 i, x0, fx0, dfx0, x, fx);
        if ((abs(fx) < eps) | (abs(x - x0) < eps)) then
            if (abs(fx) < eps) then
                mprintf("  >> Parada pelo critério |f(x)| < e\n")
            end
            if (abs(x - x0) < eps) then
                mprintf("  >> Parada pelo critério |x(n)-x(n-1)| < e\n")
            end
            return;
        end
        x0 = x;
        fx0 = f(x0);
    end
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction

function x = Newton_Raphson_px(f, df, x0, eps, n)
    // metodo de Newton-Raphson para encontrar raiz de equacao nao-linear 
    // x0: ponto inicial
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro

    eps = abs(eps);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da Newton-Raphson:\n");
    txt = fun2string(f,'f');
    mprintf("  -- Função............: %s\n",txt(2:$-1));
    txt = fun2string(df,'df');
    mprintf("  -- Derivada da função: %s\n",txt(2:$-1));
    mprintf("  -- x0................: %g\n", x0);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em x, |x(n)-x(n-1)| < e\n");

    mprintf("  i    x(i)        f(x(i))      f`(x(i))      x(i+1)      f(x(i+1))\n");
    for i = 1:1:n
        fx0 = f(x0);
        dfx0 = df(x0);
        x = x0 - fx0 / dfx0;
        fx = f(x);
        mprintf("%3d  %12.8f %12.8f %12.8f %12.8f %12.8f\n",...
                 i, x0, fx0, dfx0, x, fx);
        if (abs(x - x0) < eps) then
            return;
        end
        x0 = x;
    end
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction

function x = Newton_Raphson_pxr(f, df, x0, eps, n)
    // metodo de Newton-Raphson para encontrar raiz de equacao nao-linear 
    // x0: ponto inicial
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro

    eps = abs(eps);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da Newton-Raphson:\n");
    txt = fun2string(f,'f');
    mprintf("  -- Função............: %s\n",txt(2:$-1));
    txt = fun2string(df,'df');
    mprintf("  -- Derivada da função: %s\n",txt(2:$-1));
    mprintf("  -- x0................: %g\n", x0);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em x, dif. relativa, |x(n)-x(n-1)|/x(n) < e\n");

    mprintf("  i    x(i)        f(x(i))      f`(x(i))      x(i+1)      f(x(i+1))\n");
    for i = 1:1:n
        fx0 = f(x0);
        dfx0 = df(x0);
        x = x0 - fx0 / dfx0;
        fx = f(x);
        mprintf("%3d  %12.8f %12.8f %12.8f %12.8f %12.8f\n",...
                 i, x0, fx0, dfx0, x, fx);
        if ((abs(x - x0)/x) < eps) then
            return;
        end
        x0 = x;
    end
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction

function x = Newton_Raphson_py(f, df, x0, eps, n)
    // metodo de Newton-Raphson para encontrar raiz de equacao nao-linear 
    // x0: ponto inicial
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro

    eps = abs(eps);
    fx0 = f(x0);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da Newton-Raphson:\n");
    txt = fun2string(f,'f');
    mprintf("  -- Função............: %s\n",txt(2:$-1));
    txt = fun2string(df,'df');
    mprintf("  -- Derivada da função: %s\n",txt(2:$-1));
    mprintf("  -- x0................: %g\n", x0);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em y, |f(x)| < e\n");

    if (abs(fx0) < eps) then
        mprintf("raiz em x0");
        x = x0;
        return;
    end;

    mprintf("  i    x(i)        f(x(i))      f`(x(i))      x(i+1)      f(x(i+1))\n");
    for i = 1:1:n
        dfx0 = df(x0);
        x = x0 - fx0 / dfx0;
        fx = f(x);
        mprintf("%3d  %12.8f %12.8f %12.8f %12.8f %12.8f\n",...
                 i, x0, fx0, dfx0, x, fx);
        if (abs(fx) < eps) then
            return;
        end
        x0 = x;
        fx0 = f(x0);
    end
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction

function x = Newton_Raphson_prec(f, df, x0, eps, n, prec)
    // metodo de Newton-Raphson para encontrar raiz de equacao nao-linear 
    // x0: ponto inicial
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro
    // prec: precisão = número de casas decimais

    prec = int(prec);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da Newton-Raphson:\n");
    txt = fun2string(f,'f');
    mprintf("  -- Função............: %s\n",txt(2:$-1));
    txt = fun2string(df,'df');
    mprintf("  -- Derivada da função: %s\n",txt(2:$-1));
    mprintf("  -- x0................: %g\n", x0);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em x e y, |x(n)-x(n-1)| < e ou |f(x)| < e\n");
    mprintf("  -- Precisão..........: %g casas decimais\n", prec);

    if (fround(eps, prec) <= 0) then
        error('tolerância negativa ou menor que a precisão')
    end

    fx0 = fround(f(x0), prec);
    if (abs(fx0) < eps) then
        mprintf("raiz em x0");
        x = x0;
        return;
    end;

    mprintf("  i    x(i)        f(x(i))      f`(x(i))      x(i+1)      f(x(i+1))\n");
    for i = 1:1:n
        dfx0 = fround(df(x0), prec);
        x = fround(x0 - fround(fx0 / dfx0, prec), prec);
        fx = fround(f(x), prec);
        mprintf("%3d  %12.8f %12.8f %12.8f %12.8f %12.8f\n",...
                 i, x0, fx0, dfx0, x, fx);
        if ((abs(fx) < eps) | (abs(x - x0) < eps)) then
            if (abs(fx) < eps) then
                mprintf("  >> Parada pelo critério |f(x)| < e\n")
            end
            if (abs(x - x0) < eps) then
                mprintf("  >> Parada pelo critério |x(n)-x(n-1)| < e\n")
            end
            return;
        end
        x0 = x;
        fx0 = fround(f(x0), prec);
    end
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction
