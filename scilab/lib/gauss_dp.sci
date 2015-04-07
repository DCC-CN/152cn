function [x, r, Det] = gauss_dp(A, b, Pivota, Campo, precisao, Pausa)
    //
    //  Algoritmos Numéricos - Edição 2
    //  Capítulo 2 Sistemas lineares
    //  Seção 2.3 Eliminação de Gauss
    //  Método: Eliminação de Gauss sem/com pivotação parcial
    //
    //  parâmetros de entrada:
    //     A: matriz dos coeficientes,
    //     b: vetor dos termos independentes,
    //     Pivota: define se será usada a estratégia da pivotação parcial:
    //        Pivota = %T: com pivotação parcial,
    //        Pivota = %F: sem pivotação parcial e
    //     Campo: tamanho do formato de exibição dos campos numéricos
    //     precisao: especifica quantas casas decimais serão usadas nos cálculos
    //     Pausa: se haverá pausa na exibição entre os resultados intermediários
    //
    //  parâmetros de saída:
    //     x: vetor solução,
    //     r: vetor resíduo e
    //     Det: determinante de A.
    //

    //
    // define tamanho de campo e formato para para exibição
    precisao = abs(precisao)
    formato = '%'+string(Campo)+'.'+string(precisao)+'f'
    n = size(A,'r')
    Pivot = 1:n
    Uman = Pivot
    Det = 1, Li = 0
    U = digitos(A, precisao)
    U(:,n+1) = digitos(b, precisao)
    NumCar = Campo * (n + 2) + 9  // número de caracteres para exibição

    if Pivota then
        mprintf('\n  Eliminação de Gauss com pivotação parcial\n')
    else
        mprintf('\n  Eliminação de Gauss sem pivotação parcial\n')
    end
    exibe_caractere(NumCar,'-'), mprintf('\n')
    mprintf('  L |  mult%'+string(Campo-6)+'s |  matriz A e vetor b\n', ' ')
    exibe_caractere(NumCar,'-'), mprintf('\n')

    for j = 1:n-1
        //  escolha do elemento pivot
        if Pivota then
            p = Pivot(j), Amax = abs(U(Pivot(j),j))
            for k = j+1:n
                if abs(U(Pivot(k),j)) > Amax then
                    Amax = abs(U(Pivot(k),j)), p = Pivot(k)
                end
            end
        else
            p = j
        end
        Det = digitos(Det * U(p,j), precisao)
        if abs(U(p,j)) ~= 0 then
            //  eliminação de Gauss
            for ii = j:n
                Li = Li + 1
                i = Pivot(ii)
                if i == p then
                    mprintf('%3i%2s%'+string(Campo)+'s%2s', Li, '|', ' ', '|')
                    mprintf(formato, U(i,1:n)')
                    mprintf('%2s'+formato+'%2s', '|', U(i,n+1), ' <'),
                    mprintf('\n')
                else
                    Mult = digitos(U(i,j) / U(p,j), precisao) 
                    mprintf('%3i%2s'+formato+'%2s', Li, '|', Mult, '|')
                    mprintf(formato, U(i,1:n)')
                    mprintf('%2s'+formato, '|', U(i,n+1)), mprintf('\n')
                    U(i,j) = 0
                    for k = j+1:n+1
                        U(i,k) = digitos(U(i,k) - Mult * U(p,k), precisao)
                    end
                end
            end
            if Pivota then
                [x,k] = find(Uman == p ), Uman(k) = [], Pivot(j) = p
                Pivot = [Pivot(1:j) Uman]
            end
        else
            error('Pivot nulo') // abandona a function
        end
        exibe_caractere(NumCar,'-')
        if Pausa then, input('','s'), else, mprintf('\n'), end
    end
    mprintf('%3i%2s%'+string(Campo)+'s%2s', Li+1, '|', ' ', '|')
    mprintf(formato, U(Pivot(n),1:n)')
    mprintf('%2s'+formato+'%2s\n', '|', U(Pivot(n),n+1), ' <')
    exibe_caractere(NumCar,'-'), mprintf('\n')
    
    Sinal = troca_sinal(Pivot)
    Det = Sinal * digitos(Det * U(Pivot(n),n), precisao)
    if Pausa then, input('','s'), else, mprintf('\n'), end

    exibe_sistema(' Sistema triangular superior equivalente', 'x', ...
    formato, U(Pivot(1:n),1:n), U(Pivot(1:n),n+1))
    if Pausa then, input('','s'), else, mprintf('\n'), end
    x = subret(U(Pivot(1:n),1:n), U(Pivot(1:n),n+1), precisao)
    exibe_vetor(' vetor solução x', formato, x)

    if Pausa then, input('','s'), else, mprintf('\n'), end
    mprintf(' det(A) = '+formato+'\n', Det)

    if Pausa then, input('','s'), else, mprintf('\n'), end
    r = digitos(b - A * x, precisao)
    exibe_vetor(' vetor resíduo r', formato, r)
endfunction

