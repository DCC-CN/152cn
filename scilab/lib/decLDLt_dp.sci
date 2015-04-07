function [L, D, x, r, Det] = decLDLt_dp(A, b, prec, Pausa, CampoA, precA)
    //
    //  Algoritmos Numéricos - Edição 2
    //  Capítulo 2 Sistemas lineares
    //  Seção 2.5 Decomposição de Cholesky e LDL^T
    //  Método: Decomposição de Cholesky
    //
    //  parâmetros de entrada:
    //     A: matriz dos coeficientes,
    //     b: vetor dos termos independentes e
    //     prec: especifica quantas casas decimais serão usadas nos cálculos e
    //            se haverá pausa na exibição entre os resultados intermediários:
    //        prec >  0: haverá pausa na exibição e
    //        prec <= 0: não haverá pausa na exibição.
    //
    //  parâmetros de saída:
    //     L: matriz triangular inferior,
    //     x: vetor solução,
    //     r: vetor resíduo e
    //     Det: determinante de A.
    //
    
    function [formatacao] = frm_int(tamanho, casasdec)
        if casasdec == 0 then
            formatacao = '%'+string(tamanho)+'i'
        else
            formatacao = '%'+string(tamanho-casasdec-2)+'i'
            for i = 0:casasdec+1
                formatacao = formatacao + ' ';
            end
        end
    endfunction

    //
    // define tamanho de campo e formato para para exibição
    if ~exists('Pausa', 'local') then
        Pausa = %F;
    end;
    if ~exists('CampoA', 'local') then
        CampoA = 7; // tamanho do campo de A, no formato %CampoA.precAf
    end;
    if ~exists('precA', 'local') then
        precA = 1;
    end;
    
    prec = abs(prec)
    precA = abs(precA)
    CampoA = abs(CampoA)
    Campo = prec+5 // tamanho do campo, resultados no formato %Campo.abs(prec)f
    formatoA = '%'+string(CampoA)+'.'+string(precA)+'f'
    formato = '%'+string(Campo)+'.'+string(prec)+'f'
    formatoTA = frm_int(CampoA, precA)
    formatoT = frm_int(Campo, prec)
    A = digitos(A, prec)
    b = digitos(b, prec)
    n = size(A,'r')
    Det = 1
    for i = 1:n-1
        for j = 1:i
            if A(i,j) ~= A(j,i) then
                error('A matriz não é simétrica.')
            end
        end
    end
    L = eye(A)
    erro = %F    
    try
        for j = 1:n
            Soma = 0,
            for k = 1:j-1
                Soma = Soma + digitos(L(j,k)^2, prec) * D(k,k)
            end
            D(j,j) = A(j,j) - Soma
            Det = digitos(Det * D(j,j), prec)
            for i = j+1:n
                Soma = 0
                for k = 1:j-1
                    Soma = Soma + digitos(L(i,k) * D(k,k) * L(j,k), prec)
                end
                L(i,j) = digitos((A(i,j) - Soma ) / D(j,j), prec)
            end
        end
    catch
        n = j
        erro = %T
    end
    
    // exibição do sistema completo Ax = b
    exibe_sistema(' Sistema Ax = b', 'x', formato, A, b)
    mprintf('\n');
    // exibição dos resultados intermediários
    for j = 1:n
        //if Pausa then, tohome, end
        linha = j*(CampoA+Campo*2)+24;
        mprintf('  Decomposição LDLt: Coluna %i\n', j)
        exibe_caractere(linha,'-'), mprintf('\n')
        mprintf('  matriz A')
        mprintf('%'+string(CampoA*j-3)+'s', ' ')
        mprintf('|  matriz D')
        mprintf('%'+string(Campo*j-3)+'s', ' ')
        mprintf('|  matriz L\n')
        exibe_caractere(linha,'-'), mprintf('\n')
        mprintf('%4s',' i\j |')
        for i = 1:j
            mprintf(formatoTA, i)
        end
        mprintf(' |%4s',' i\j |')
        for i = 1:j
            mprintf(formatoT, i)
        end
        mprintf('%4s',' | i\j |  ')
        for i = 1:j
            mprintf(formatoT, i)
        end
        mprintf('\n'), exibe_caractere(linha,'-'), mprintf('\n')
        for i = 1:n
            // número da lina
            mprintf(' %3i |', i)
            // dados da matriz A até a coluna atual
            for k = 1:min(i,j)
                mprintf(formatoA, A(i,k))
            end
            // espaço em branco (do sistema triangular superior)
            if i < j then
                mprintf('%'+string(CampoA*(j-i))+'s', ' ')
            end
            mprintf(' | %3i |', i)
            // dados da matriz D até a coluna atual
            for k = 1:min(i,j)
                mprintf(formato, D(i,k))
            end
            // espaço em branco (do sistema triangular superior)
            if i < j then
                mprintf('%'+string(Campo*(j-i))+'s', ' ')
            end
            // número da linha
            mprintf(' | %3i |', i)
            // dados da matriz L até a coluna atual
            for k = 1:min(i,j)
                mprintf(formato, L(i,k))
            end
            // espaço em branco (do sistema triangular superior)
            if i < j then
                mprintf('%'+string(Campo*(j-i))+'s', ' ')
            end
            mprintf(' | ')
            if i == j
                mprintf('D(%i,%i)=', i, j)
                mprintf('A(%i,%i)', i, j)
                if i > 1 then
                    mprintf('-(')
                    for ii = 1:j-1
                        if (ii > 1) then
                            mprintf('+')
                        end
                        mprintf('L(%i,%i)^2*D(%i,%i)', i, ii, ii, ii)
                    end
                    mprintf(')')
                end
                mprintf('; L(%i,%i)= 1', i, j)
            elseif i > j
                mprintf('L(%i,%i)=', i, j)
                mprintf('(A(%i,%i)', i, j)
                if j > 1 then
                    mprintf('-(')
                    for k = 1:j-1
                        if (k > 1) then
                            mprintf('+')
                        end
                        mprintf('L(%i,%i)*D(%i,%i)*L(%i,%i)', i, k, k, k, j, k)
                    end
                    mprintf(')')
                end
                mprintf(')/D(%i,%i)', j, j)
            end            
            mprintf('\n')
        end
        exibe_caractere(linha,'-'), mprintf('\n')
        if Pausa then, input('','s'), else, mprintf('\n'), end
    end

    if erro then
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        mprintf('Erro ""%s"" no cálculo da coluna %i.\n', lasterror(), j);
        mprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        error('Falha ao calcular a decomposição LDLt!')
    end
    
    exibe_sistema(' Sistema triangular inferior (Ly = b)', 'y', formato, L, b)
    if Pausa then, input('','s'), else, mprintf('\n'), end
    y = subsuc(L, b, prec)
    exibe_vetor(' vetor y', formato, y)
    
    if Pausa then, input('','s'), else, mprintf('\n'), end
    exibe_sistema(' Sistema diagonal (Dt = y)', 't', formato, D, y)
    if Pausa then, input('','s'), else, mprintf('\n'), end
    for i = 1:n
        t(i) = digitos(y(i)/D(i,i), prec)
    end
    exibe_vetor(' vetor t', formato, t)
    
    if Pausa then, input('','s'), else, mprintf('\n'), end
    exibe_sistema(' Sistema triangular superior (L''x = t)', 'x', formato, L', t)

    if Pausa then, input('','s'), else, mprintf('\n'), end
    x = subret(L', t, prec)
    exibe_vetor(' vetor solução x', formato, x)

    if Pausa then, input('','s'), else, mprintf('\n'), end
    mprintf(' det(A) = '+formato+'\n', Det)

    if Pausa then, input('','s'), else, mprintf('\n'), end
    r = digitos(b - A * x, prec)
    exibe_vetor(' vetor resíduo r', formato, r)
endfunction

