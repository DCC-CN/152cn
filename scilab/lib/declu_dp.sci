function [L, U, Pivot, x, r, Det] = declu_dp(A, b, Pivota, Tamanho, Prec, Pausa)
    //
    //  Algoritmos Numéricos - Edição 2
    //  Capítulo 2 Sistemas lineares
    //  Seção 2.4 Decomposição LU
    //  Método: Decomposição LU sem/com pivotação parcial
    //
    //  parâmetros de entrada:
    //     A: matriz dos coeficientes,
    //     b: vetor dos termos independentes,
    //     Pivota: define se será usada a estratégia da pivotação parcial:
    //        Pivota = %T: com pivotação parcial,
    //        Pivota = %F: sem pivotação parcial e
    //     Tamanho: tamanho do campo, resultados no formato %Tamanho.abs(Prec)f
    //     Prec: especifica quantas casas decimais serão usadas nos cálculos e
    //            se haverá pausa na exibição entre os resultados intermediários:
    //        Prec >  0: haverá pausa na exibição e
    //        Prec <= 0: não haverá pausa na exibição.
    //
    //  parâmetros de saída:
    //     L: matriz triangular inferior,
    //     U: matriz triangular superior,
    //     Pivot: vetor com as linhas pivotais,
    //     x: vetor solução,
    //     r: vetor resíduo e
    //     Det: determinante de A.
    //
    //  Código disponível no material da disciplina de Cálculo Numérico
    //  Professor Leonardo B. Oliveira
    //  Adapatado em 2014/2: Frederico Sampaio
    //

    n = size(A,'r')
    if n < 2 then
        error("O sistema deve ter ao menos duas equações.")
    end
    // n > 9 irá causar falha no alinhamento da formatação
    if ~issquare(A) then
        error('Matriz A deve ser quadrada');
    end
    if size(b, 'r') ~= n  then
        error('Matriz b deve ter o mesmo número de linhas que a matriz A');         
    end
    Prec = abs(Prec)
    Tamanho = abs(Tamanho)
    if Prec > Tamanho - 3 then
        error('Formatação incorreta');
    end
    if ~exists("Pausa","local") then 
        Pausa = %F
    end
    if Prec == 0 then
        Tamanho = Tamanho + 3;
        formato = '%'+string(Tamanho)+'.2f'
    else
        formato = '%'+string(Tamanho)+'.'+string(Prec)+'f'
    end

    Pivot = 1:n
    Uman = Pivot
    Det = 1
    U = digitos(A, Prec)
    b = digitos(b, Prec)
    L = zeros(n,n)

    if Pivota then
        mprintf('\n  Decomposição LU com pivotação parcial\n')
    else
        mprintf('\n  Decomposição LU sem pivotação parcial\n')
    end
    NumCar = Tamanho * (n + 2) + 9 + 8 + 7 + 12 // número de caracteres para exibição
    exibe_caractere(NumCar,'-'), mprintf(' \n')
    mprintf(' L  | mult%'+string(Tamanho+5)+'s | matriz A%'...
            +string(Tamanho*n-9)+'s | p     | Operações \n', ' ', ' ')
    exibe_caractere(NumCar,'-'), mprintf(' \n')
    
    try
        Operacao(n, n) = ''
        Li = 0
        for j = 1:n-1
            //  escolha do elemento pivot
            if Pivota then
                p = Pivot(j), Amax = abs(U(p,j))
                for k = j+1:n
                    if abs(U(Pivot(k),j)) > Amax then
                        Amax = abs(U(Pivot(k),j))
                        p = Pivot(k)
                    end
                end
            else
                p = j
            end
            Det = digitos(Det * U(p,j), Prec)
            Lii = Li
            //  eliminação de Gauss
            for ii = j:n
                Li = Li + 1
                i = Pivot(ii)
                if i == p then
                    Lp = Li;
                    mprintf('%3i |%'+string(Tamanho+10)+'s |', Li, ' ')
                    mprintf(formato, U(i,1:n)'), mprintf(' |%2i U(%i)', i, j)
                else
                    Mult = digitos(U(i,j) / U(p,j), Prec)
                    L(i,j) = Mult
                    mprintf('%3i | m(%i,%i) = '+formato+' |', Li, i, j, Mult)
                    mprintf(formato, U(i,1:n)')
                    mprintf(' |%2i     ', i)
                    U(i,j) = 0
                    for k = j+1:n
                        U(i,k) = digitos(U(i,k) - Mult * U(p,k), Prec)
                    end
                end
                mprintf('| %'+string(Tamanho+8)+'s', Operacao(i,j));
                mprintf(' \n');
            end
            //  gera os textos das operações
            for ii = j:n
                Lii = Lii + 1
                i = Pivot(ii)
                if i ~= p then
                    Operacao(i,j+1) = sprintf('('+formato+'*L%i)+L%i',...
                    -L(i,j), Lp, Lii)
                end
            end
            if Pivota then
                [x,k] = find(Uman == p), Uman(k) = [], Pivot(j) = p
                Pivot = [Pivot(1:j) Uman]
            end
            exibe_caractere(NumCar,'-')
            if Pausa then, input('','s'), else, mprintf(' \n'), end
        end
    catch
        Det = 0
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        mprintf('Erro ""%s"", durante cálculo do multiplicador m(%i, %i).\n', lasterror(), p, j);
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        error('Falha ao calcular a decomposição LU!')
    end
    
    mprintf('%3i |%'+string(Tamanho+10)+'s |', Li+1, ' ')
    mprintf(formato, U(Pivot(n),1:n)')
    mprintf(' |%2i U(%i)', Pivot(n), n)
    if n > 1 then
        i = Pivot(n)
        mprintf('| %s', Operacao(i,n));
    end
    mprintf(' \n');
    
    Sinal = troca_sinal(Pivot)
    Det = Sinal * digitos(Det * U(Pivot(n),n), Prec)
    // ordena elementos de L
    for j = 1:n-1
        Coluna = L(Pivot(j+1:n),j)
        L(:,j) = [zeros(j-1,1); 1; Coluna]
    end
    L(:,n) = [zeros(n-1,1); 1]

    // exibe resultados
    exibe_caractere(NumCar,'-'), mprintf(' \n')
    if Pausa then, input('','s'), else, mprintf(' \n'), end
    if Pivota then
        exibe_vetor(' Linhas pivotais (p)', ' %i ', Pivot);
        mprintf('\n');
        exibe_sistema_pivotal(' Sistema triangular inferior (Ly = Pb)', 'y', ...
        formato, L, b, Pivot);
    else
        exibe_sistema(' Sistema triangular inferior (Ly = b)', 'y', ...
        formato, L, b(Pivot(1:n)));
    end
    if Pausa then, input('','s'), else, mprintf(' \n'), end
    y = subsuc(L, b(Pivot(1:n)), Prec)
    exibe_vetor(' vetor y', formato, y)
    
    // ordena linhas de U
    U = U(Pivot(1:n),1:n)
    if Pausa then, input('','s'), else, mprintf(' \n'), end
    exibe_sistema(' Sistema triangular superior (Ux = y)', 'x', formato, U, y)
    
    if Det == 0 then
        if Pausa then, input('','s'), else, mprintf(' \n'), end
        mprintf(' det(A) = '+formato+' \n', Det)
        mprintf('\n*** Sistema singular (determinante = 0)\n\n')
        x = [];
        r = [];
    else
        if Pausa then, input('','s'), else, mprintf(' \n'), end
        x = subret(U, y, Prec)
        exibe_vetor(' vetor solução x', formato, x)

        if Pausa then, input('','s'), else, mprintf(' \n'), end
        mprintf(' det(A) = '+formato+' \n', Det)

        if Pausa then, input('','s'), else, mprintf(' \n'), end
        r = digitos(b - A * x, Prec)
        exibe_vetor(' vetor resíduo r', formato, r)
    end
endfunction

