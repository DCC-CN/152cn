function gravar_amostra(arq, x, y)
    // inicializa variáveis
    fd = mopen(arq, "w");
    // grava dados no arquivo 
    n = size(x, '*');
    for i = 1:1:n
        mfprintf(fd, "%g %g\n", x(i), y(i));
    end
    mclose(fd);
endfunction
