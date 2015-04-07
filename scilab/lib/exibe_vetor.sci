function exibe_vetor(titulo, formato, vetor)
    //
    n = length(vetor);
    mprintf('%s: ', titulo)
    for i = 1:n
        mprintf(formato, vetor(i))
    end
    mprintf(' \n')
endfunction
