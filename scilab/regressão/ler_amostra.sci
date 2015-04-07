function [x, y] = ler_amostra(arq)
    // inicializa variáveis
    x = [];
    y = [];
    fd = mopen(arq, "r");
    // lê dados do arquivo 
    while ~meof(fd)
        [n, xi, yi] = mfscanf(fd, "%lg %lg\n");
        if n ~= 2 then
            break;
        end
        x(1,$+1) = xi;
        y(1,$+1) = yi;
    end
    mclose(fd);
endfunction
