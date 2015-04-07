function Px = poly_Gregory_Newton(varargin)
    //
    //  Polinomio de Gregory-Newton usando dispositivo pratico
    //
    //  parametros de entrada:
    //     x: vetor contendo as abscissas,
    //     y: vetor contendo as ordenadas,
    //     [Exibe]: Parâmetro opcional de exibição da tabela de Dif. finitas
    //
    //  parametro de saida:
    //     Px: polinômio interpolador
    //
    
    // Processa parâmetros
    [lhs,rhs]=argn();
    if  rhs < 2 then
        error('Número insuficiente de argumentos: informe os vetores x e y');
    end
    x = varargin(1);
    y = varargin(2);
    if  rhs >= 3 then
        Exibe = varargin(3);
    else
        Exibe = %F;
    end
            
    n = length(x);
    if n < 2 then
        error('Poucos pontos (<2) para interpolar');
    end
    eps = 0.0000000001;
    space = abs(x(2) - x(1));
    for i = 2:n
        if abs(abs(x(i) - x(i-1)) - space) > eps then
            error('O método de Gregory-Newton exige espaçamento igual');
        end
    end
    // Inicializa a matriz de diferenças finitas
    for i = 1:n
        Delta_y(i,1) = y(i);
    end
    //  Construção das diferenças finitas
    for k = 2:n
        for i = 1:n-k+1
            Delta_y(i,k) = Delta_y(i+1,k-1) - Delta_y(i,k-1);
        end
    end
    // Exibe a tabela
    if Exibe then
        mprintf('\nInterpolação via polinômios de Gregory-Newton\n')
        mprintf('\n  Tabela de diferenças finitas')
        mprintf('\n  i      x(i)        y(i) ')
        for j = 1:n-1
            mprintf('     DifFin%i', j)
        end
        mprintf('\n')
        for i = 1:n
            mprintf('%3i %11.6f', i-1, x(i))
            for j = 1:n+1-i
                mprintf(' %11.6f', Delta_y(i,j))
            end
            mprintf('\n')
        end
    end
    // Geração do polinomio interpolador
    X = poly(0, 'x');
    u = (X - x(1)) / (x(2)-x(1));
    Px = Delta_y(1,n);
    for i = n-1:-1:1
        Px = Px * (u - i + 1) / i + Delta_y(1,i);
    end;
endfunction

