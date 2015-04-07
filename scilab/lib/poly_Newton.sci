function Px = poly_Newton(x, y, Exibe)
    //
    //  Polinomio de Newton usando dispositivo pratico
    //
    //  parametros de entrada:
    //     x: vetor contendo as abscissas,
    //     y: vetor contendo as ordenadas,
    //     [Exibe]: Parâmetro opcional de exibição da tabela de Dif. finitas
    //
    //  parametro de saida:
    //     Px: Polinômio interpolador.
    //

    // Processa parâmetros
    if ~exists("x","local") | ~exists("y","local") then
        error('Número insuficiente de argumentos: informe os vetores x e y');
    end
    if ~exists("Exibe","local") then
        Exibe = %F;
    end

    n = length(x);
    for i = 1:n
        Delta_y(i,1) = y(i);
    end
    //  construcao das diferencas divididas
    for k = 2:n
        for i = 1:n-k+1
            Delta_y(i,k) = (Delta_y(i+1,k-1)-Delta_y(i,k-1))/(x(i+k-1)-x(i));
        end
    end
    if Exibe then
        mprintf('\nInterpolação via polinômios de Newton\n')
        mprintf('\n  Tabela de diferenças divididas')
        mprintf('\n  i      x(i)        y(i) ')
        for j = 1:n-1
            mprintf('     DifDiv%i', j)
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
    //  avaliacao do polinomio pelo processo de Horner
    X = poly(0, 'x');
    Px = Delta_y(1,n);
    for i = n-1:-1:1
        Px = Px * (X - x(i)) + Delta_y(1,i);
    end;
endfunction

