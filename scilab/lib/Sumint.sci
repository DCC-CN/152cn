// REF: http://www.infoclearinghouse.com/files/scilab/scilab07.pdf

function [I] = Sumint(stype, from, to, slices, f)
    
    // define a distância entre os pontos (eixo x)
    Dx = (to - from)/(slices - 1);
    // gera o conjunto de valores de x
    x = [from:Dx:to];
    // executa a função f(x) para cada valor do conjunto
    y = feval(x,f);
    
    // ajuste das coordenadas da janela
    [n m] = size(x);
    xmin = min(x);
    xmax = max(x);
    ymin = min(y);
    ymax = max(y);
    
    if ymin > 0 then
        ymin = 0;
    end;

    // desloca uma posição à esquerda 
    // caso 1: para o desenho da escada à direita
    // caso 2: para o cálculo do ponto médio do retângulo
    ym = f(xmax);
    yy = [y(2:m), ym];
   
    // tipos de gráficos e cálculos
    select stype,
    case 'L' then
        scf(1);  // seleciona a figura atual
        clf(1);  // limpa a figura
        plot2d(x, y, style=color('blue')); // desenha o gráfico da função
        plot2d2(x, y, style=color('green')); // desenha uma escada entre os pontos
        plot2d3(x, y, style=color('green')); // desenha a projeção dos pontos até o eixo x
        // define um título para a figura atualmente selecionada
        xtitle('Left sum', 'x', 'y');
        I = sum(y(1:m-1))*Dx;  // calcula o valor da integral 
    case 'M' then
        scf(2);  // seleciona a figura atual
        clf(2);  // limpa a figura
        plot2d(x, y, style=color('blue'));  // desenha o gráfico da função
        // encontra os pontos médios de cada retângulo por
        // soma de vetores e divisão por escalar
        yyy = (y+yy)/2;
        plot2d2(x, yyy, style=color('green')); // desenha uma escada entre os pontos
        plot2d3(x, yyy, style=color('green')); // desenha a projeção dos pontos até o eixo x
        xtitle('Middle sum', 'x', 'y');
        I = sum(yyy(1:m-1))*Dx;  // calcula o valor da integral 
    case 'R' then
        scf(3);  // seleciona a figura atual
        clf(3);  // limpa a figura
        plot2d(x, y, style=color('blue')); // desenha o gráfico da função
        plot2d2(x, yy, style=color('green')); // desenha uma escada entre os pontos
        plot2d3(x, yy, style=color('green')); // desenha a projeção dos pontos até o eixo x
        xtitle('Right sum', 'x', 'y');
        I = sum(yy(1:m-1))*Dx;  // calcula o valor da integral 
    else
        scf(4);  // seleciona a figura atual
        clf(4);  // limpa a figura
        plot2d(x, y, style=color('blue'));  // desenha o gráfico da função
        // Note-se que a plotagem de gráficos já é trapezoidal,
        // pois liga os pontos da amostra por retas.
        // Então, para tentar destacar visualmente a diferença entre o trapézio
        // da integração numérica, aumenta-se a distância Dx 
        slices = floor(slices / 5)
        Dx = (to - from)/slices;
        xl = [from:Dx:to];
        yl = feval(xl, f);
        // desenha os trapézios
        plot2d(xl, yl, style=color('green'));  // linhas mais destacadas entre pontos
        plot2d3(xl, yl, style=color('green')); // desenha a projeção dos pontos até o eixo x
        xtitle('Trapezoidal interpolation', 'x', 'y');
        I = inttrap(x, y);  // calcula o valor da integral 
    end
    
    // desenha eixo Y na posição original (se estiver na área de plotagem)
    if ymin < 0 then
        xpoly([xmin, xmax], [0,0], 'lines');
    end
    
    // desenha eixo X na posição original (se estiver na área de plotagem)
    if xmin < 0 then
        xpoly([0,0], [ymin, ymax], 'lines');
    end
    
endfunction
