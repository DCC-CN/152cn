function exibe_sistema_pivotal(titulo, variavel, formato, matriz, vetor, pivot)
    //

    n = length(vetor);
    p = eye(n,n);
    p = p(pivot(1:n),1:n)
    pv = vetor(pivot(1:n))
    mprintf(' Cálculo da matriz triangular inferior L: \n\n')
    for i = 1:n
        if i == ceil(n/2) 
            mprintf('L = ');
        else
            mprintf('    ');
        end
        mprintf('| ')
        for j = 1:n
            if j == i then
                mprintf('     1     ')
            elseif j > i
                mprintf('     0     ')
            else
                mprintf(' m(p(%i),%i) ', i, j)
            end
        end
        if i == ceil(n/2) 
            mprintf('| = | ');
        else
            mprintf('|   | ');
        end
        for j = 1:n
            if j == i then
                mprintf('   1    ')
            elseif j > i
                mprintf('   0    ')
            else
                mprintf(' m(%i,%i) ', pivot(i), j)
            end
        end
        mprintf('|\n');
    end
    mprintf('\n%s: \n\n', titulo)
    for i = 1:n
        mprintf('| ')
        for j = 1:n
            mprintf(formato, matriz(i,j))
        end
        if i == ceil(n/2) 
            mprintf(' | | %s%i | = ', variavel, i);
        else
            mprintf(' | | %s%i |   ', variavel, i);
        end
        mprintf('| ');
        for j = 1:n
            mprintf('%1d ', p(i,j))
        end
        mprintf('| | '+formato+ ' |', vetor(i))
        if i == ceil(n/2) 
            mprintf(' = | '+formato+ ' |\n', pv(i));
        else
            mprintf('   | '+formato+ ' |\n', pv(i));
        end
    end
endfunction
