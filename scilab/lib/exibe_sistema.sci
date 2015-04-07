function exibe_sistema(titulo, variavel, formato, matriz, vetor)
    //
    n = length(vetor);
    mprintf('%s: \n\n', titulo)
    for i = 1:n
        mprintf('| ')
        for j = 1:n
            mprintf(formato, matriz(i,j))
        end
        if i == ceil(n/2) 
            mprintf(' | | %s%i | = | '+formato+ ' |\n', variavel, i, vetor(i))
        else
            mprintf(' | | %s%i |   | '+formato+ ' |\n', variavel, i, vetor(i))
        end
    end
endfunction

function exibe_sistema_inv(titulo, inversa, coluna, formato, matriz, vetor)
    //
    n = length(vetor);
    mprintf('%s: \n\n', titulo)
    for i = 1:n
        mprintf('| ')
        for j = 1:n
            mprintf(formato, matriz(i,j))
        end
        if i == ceil(n/2) 
            mprintf(' | | %s(%i,%i) | = | '+formato+ ' |\n', inversa, i, coluna, vetor(i))
        else
            mprintf(' | | %s(%i,%i) |   | '+formato+ ' |\n', inversa, i, coluna, vetor(i))
        end
    end
endfunction

function exibe_sistema_pivot(titulo, variavel, formato, matriz, vetor, pivot)
    //
    n = length(vetor);
    mprintf('%s: \n\n', titulo)
    for i = 1:n
        mprintf('| ')
        for j = 1:n
            mprintf(formato, matriz(i,j))
        end
        if i == ceil(n/2) 
            mprintf(' | | %s%i | = | ', variavel, i)
        else
            mprintf(' | | %s%i |   | ', variavel, i)
        end
        for j = 1:n
            mprintf('%i ', pivot(i,j))
        end
         mprintf('| | '+formato+ ' |\n', vetor(i))
    end
endfunction

function exibe_solucao(titulo, x, formato_x, formato, matriz, vetor)
    //
    n = length(vetor);
    mprintf('%s: \n\n', titulo)
    for i = 1:n
        mprintf('| ')
        for j = 1:n
            mprintf(formato, matriz(i,j))
        end
        if i == ceil(n/2) 
            mprintf(' | | '+formato_x+ ' | = | '+formato+ ' |\n', x(i), vetor(i))
        else
            mprintf(' | | '+formato_x+ ' |   | '+formato+ ' |\n', x(i), vetor(i))
        end
    end
endfunction

function exibe_inversa(titulo, matriz, formato, inversa, formato_i, identidade)
    //
    n = size(matriz, 1);
    mprintf('%s: \n\n', titulo)
    for i = 1:n
        mprintf('| ')
        for j = 1:n
            mprintf(formato, matriz(i, j))
        end
        mprintf(' | | ')
        for j = 1:n
            mprintf(formato_i, inversa(i, j))
        end
        if i == ceil(n/2) 
            mprintf(' | = | ')
        else
            mprintf(' |   | ')
        end
        for j = 1:n
            mprintf('%1.0f ', identidade(i, j))
        end
        mprintf('|\n')
    end
endfunction
