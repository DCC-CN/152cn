function [b1, b0, r2, sigma2] = reglin_simples(x, y, exibir)
    // Cálcula a regressão linear simples pelo método dos quadrados mínimos
    // Retorno: os coeficientes b1*x + b0 da reta
    //          o coeficiente de determinação r2
    //          a variância residual sigma2

    n = size(x, '*');
    if (n < 2) then
        error('Amostra insuficiente.');
    end
    if (n ~= size(y, '*')) then
        error('Dimensões diferentes dos vetores x y');
    end
    //if (max(x) == min(x)) then
    //    error('Deve existir ao menos dois valores diferentes de x');
    //end
    soma_xi = sum(x);
    soma_yi = sum(y);
    xy = x.*y;
    soma_xiyi = sum(xy);
    x2 = x.^2;
    soma_xi2 = sum(x2);
    b1 = (soma_xi*soma_yi - n*soma_xiyi)/(soma_xi^2 - n*soma_xi2);
    b0 = (soma_yi - b1*soma_xi)/n;

    u = b0 + b1*x;
    d = (y - u);
    d2 = d.^2;
    D_b0b1 = sum(d2);
    y2 = y.^2;
    soma_yi2 = sum(y2);
    divisor = soma_yi2 - (soma_yi^2)/n;
    if divisor ~= 0 then
        r2 = 1 - D_b0b1/divisor;
    else
        r2 = 1;
    end
    // p: número de parâmetros da regressão (no caso, b0 e b1, ou seja p = 2)
    p = 2;
    if n > p then
        sigma2 = D_b0b1/(n - p);
    else
        sigma2 = 0
    end

    if ~exists("exibir","local") then
        exibir = %F;
    end
    if exibir then

        mprintf("\n-------------------------------------------------------------------------\n");
        mprintf("Dispositivo para regressão linear simples por quadrados mínimos\n");
        mprintf("  i    x          y           x^2           xy            y^2           u               d               d^2\n");
        for i = 1:1:n
            mprintf("%3d %9.4f  %9.4f %13.6f %13.6f %13.6f %15.8f %15.8f %15.8f\n",...
            i, x(i), y(i), x2(i), xy(i), y2(i), u(i), d(i), d2(i));
        end
        mprintf("sum %9.4f  %9.4f %13.6f %13.6f %13.6f %15.8f %15.8f %15.8f\n",...
        soma_xi, soma_yi, soma_xi2, soma_xiyi, soma_yi2, sum(u), sum(d), D_b0b1);
        mprintf("\nRegressão linear simples por quadrados mínimos = (%.8f)x + (%.8f)\n", b1, b0);
        [a b sig2] = reglin(x, y);
        mprintf("\nRegressão linear simples pela função reglin    = (%.8f)x + (%.8f)  sigma^2 = %.8f\n", a, b, sig2);
        mprintf("Coeficiente de determinação (r^2) = %.8f\n", r2);
        mprintf("Variância residual (sigma^2)      = %.8f\n", sigma2);
    end
endfunction
