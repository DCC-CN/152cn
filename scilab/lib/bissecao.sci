function [x] = bissecao(f, a, b, eps, n)
    // metodo da bissecao para encontrar raiz de equacao nao-linear f(x)=0
    // a, b: intervalo (limite inferior e superior)
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro
    
    eps = abs(eps);
    fa = f(a);
    fb = f(b);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da bissecao:\n");
    txt = fun2string(f,'f');
    mprintf("%s\n",txt(2:$-1));
    mprintf("  -- Intervalo [a, b]..: [%g, %g]\n", a, b);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em x e y, |b-a| < e ou |f(x)| < e\n");

    if((fa * fb) > 0) then
        error("A função não muda de sinal nos extremos do intervalo")
    end;
    if(abs(fa) < eps) then
        mprintf("raiz em a");
        x = a;
        return;
    end;
    if(abs(fb) < eps) then
        mprintf("raiz em b");
        x = b;
        return;
    end;
    mprintf("iter      a        f(a)         b        f(b)         x        f(x)       |b-a|\n");
    for i = 1:1:n
        x = (a+b)/2;
        fx = f(x);
        mprintf("%3d  %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f\n",...
                 i, a, fa, b, fb, x, fx, abs(b-a));        
        if ((abs(b-a) < eps) | (abs(fx) < eps)) then
            if (abs(b-a) < eps) then
                mprintf("  >> Parada pelo critério |b-a| < e\n")
            end
            if (abs(fx) < eps) then
                mprintf("  >> Parada pelo critério |f(x)| < e\n")
            end
            return;
        end;
        if( fa * fx < 0) then
            b = x;
            fb = fx;
        else
            a = x;
            fa = fx;
        end;
    end;
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction

function [x] = bissecao_px(f, a, b, eps, n)
    // metodo da bissecao para encontrar raiz de equacao nao-linear f(x)=0
    // a, b: intervalo (limite inferior e superior)
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro
    
    eps = abs(eps);
    fa = f(a);
    fb = f(b);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da bissecao:\n");
    txt = fun2string(f,'f');
    mprintf("%s\n",txt(2:$-1));
    mprintf("  -- Intervalo [a, b]..: [%g, %g]\n", a, b);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em x, |b-a| < e\n");

    if((fa * fb) > 0) then
        error("A função não muda de sinal nos extremos do intervalo")
    end;
    mprintf("iter      a        f(a)         b        f(b)         x        f(x)       |b-a|\n");
    for i = 1:1:n
        x = (a+b)/2;
        fx = f(x);
        mprintf("%3d  %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f\n",...
                 i, a, fa, b, fb, x, fx, abs(b-a));        
        if (abs(b-a) < eps) then
            return;
        end;
        if( fa * fx < 0) then
            b = x;
            fb = fx;
        else
            a = x; 
            fa = fx;
        end;
    end;
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction

function [x] = bissecao_pxr(f, a, b, eps, n)
    // metodo da bissecao para encontrar raiz de equacao nao-linear f(x)=0
    // a, b: intervalo (limite inferior e superior)
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro
    
    eps = abs(eps);
    // garante a ordem a < b
    if (a > b) then
        t = a;
        a = b;
        b = t;
    end
    fa = f(a);
    fb = f(b);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da bissecao:\n");
    txt = fun2string(f,'f');
    mprintf("%s\n",txt(2:$-1));
    mprintf("  -- Intervalo [a, b]..: [%g, %g]\n", a, b);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em x, diferença relativa, |b-a|/b < e\n");

    if((fa * fb) > 0) then
        error("A função não muda de sinal nos extremos do intervalo")
    end;
    mprintf("iter      a        f(a)         b        f(b)         x        f(x)       |b-a|\n");
    for i = 1:1:n
        x = (a+b)/2;
        fx = f(x);
        mprintf("%3d  %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f\n",...
                 i, a, fa, b, fb, x, fx, abs(b-a));        
        if ((abs(b-a)/b) < eps) then
            return;
        end;
        if( fa * fx < 0) then
            b = x;
            fb = fx;
        else
            a = x;
            fa = fx;
        end;
    end;
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction

function [x] = bissecao_py(f, a, b, eps, n)
    // metodo da bissecao para encontrar raiz de equacao nao-linear f(x)=0
    // a, b: intervalo (limite inferior e superior)
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro
    
    eps = abs(eps);
    fa = f(a);
    fb = f(b);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da bissecao:\n");
    txt = fun2string(f,'f');
    mprintf("%s\n",txt(2:$-1));
    mprintf("  -- Intervalo [a, b]..: [%g, %g]\n", a, b);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em y, |f(x)| < e\n");

    if((fa * fb) > 0) then
        error("A função não muda de sinal nos extremos do intervalo")
    end;
    if(abs(fa) < eps) then
        mprintf("raiz em a");
        x = a;
        return;
    end;
    if(abs(fb) < eps) then
        mprintf("raiz em b");
        x = b;
        return;
    end;
    mprintf("iter      a        f(a)         b        f(b)         x        f(x)       |b-a|\n");
    for i = 1:1:n
        x = (a+b)/2;
        fx = f(x);
        mprintf("%3d  %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f\n",...
                 i, a, f(a), b, f(b), x, fx, abs(b-a));        
        if (abs(fx) < eps) then
            return;
        end;
        if( fa * fx < 0) then
            b = x;
            fb = fx;
        else
            a = x; 
            fa = fx;
        end;
    end;
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction

function [x] = bissecao_prec(f, a, b, eps, n, prec)
    // metodo da bissecao para encontrar raiz de equacao nao-linear f(x)=0
    // a, b: intervalo (limite inferior e superior)
    // f: função
    // n: número máximo de iterações (aproximações)
    // eps: Epson = tolerância ou margem de erro
    // prec: precisão = número de casas decimais
    
    prec = int(prec);
    if (fround(eps, prec) <= 0) then
        error('tolerância negativa ou menor que a precisão')
    end
    a = fround(a, prec);
    b = fround(b, prec);
    fa = fround(f(a), prec);
    fb = fround(f(b), prec);

    mprintf("\n------------------------------------------------------------\n");
    mprintf("Raiz de equação pelo método da bissecao:\n");
    txt = fun2string(f,'f');
    mprintf("%s\n",txt(2:$-1));
    mprintf("  -- Intervalo [a, b]..: [%g, %g]\n", a, b);
    mprintf("  -- Épsilon (e).......: %.8f\n", eps);
    mprintf("  -- Critério de parada: em x e y, |b-a| < e ou |f(x)| < e\n");
    mprintf("  -- Precisão..........: %g casas decimais\n", prec);

    if((fa * fb) > 0) then
        error("A função não muda de sinal nos extremos do intervalo")
    end;
    if(abs(fa) < eps) then
        mprintf("raiz em a");
        x = a;
        return;
    end;
    if(abs(fb) < eps) then
        mprintf("raiz em b");
        x = b;
        return;
    end;
    mprintf("iter      a        f(a)         b        f(b)         x        f(x)       |b-a|\n");
    for i = 1:1:n
        x = fround((a+b)/2, prec);
        fx = fround(f(x), prec);
        mprintf("%3d  %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f\n",...
                 i, a, fa, b, fb, x, fx, abs(b-a));        
        if(abs(b-a) < eps) | (abs(fx) < eps) then
            if (abs(b-a) < eps) then
                mprintf("  >> Parada pelo critério |b-a| < e\n")
            end
            if (abs(fx) < eps) then
                mprintf("  >> Parada pelo critério |f(x)| < e\n")
            end
            return;
        end;
        if( fa * fx < 0) then
            b = x;
            fb = fx;
        else
            a = x; 
            fa = fx;
        end;
    end;
    error("Raiz não encontrada, pois o método não convergiu após n iterações")
endfunction


function k = bissecao_iteracoes_px(a, b, eps)
    // calcula o número de iterações se o critério de para for (|b -a| < eps)
    // a, b: intervalo (limite inferior e superior)
    // eps: Epson = tolerância ou margem de erro

    eps = abs(eps);
    k = log2(abs(b - a)/eps) - 1;
endfunction
