function solucao = solucao_sistema_linear(coeficientes, termos_independentes)
    [n, m] = size(coeficientes);
    if n <> m then
        printf("Essa função aceita apenas matriz de coeficiente quadrada.\n");
        return [];
    end
    [p, q] = size(termos_independentes)
    if p <> n or q <> 1 then
        printf("Essa função aceita apenas matriz de termos independentes com uma coluna e mesmo número de linhas da matriz de coeficientes.\n");
        return([]);
    end
    if det(coeficientes) == 0 then
        printf("A matriz de coeficientes é singular, pois não adimite inversa.\n");
        printf("Entao, o sistema linear é singular, ou seja, é indeterminado (infinitas soluções) ou é imposível (sem solução).\n");
        solucao = [];
        return;
    end
    solucao = coeficientes\termos_independentes;
endfunction
