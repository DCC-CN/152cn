//
//
//
clear;
clc;
getd('../lib');
getd('.');


function name = file_name(prefix, num, ext)
    name = msprintf("%s%d.%s", prefix, num, ext);
endfunction

function result = linear_complexity(n)
    i = 1;
    result = 0;
    while i < n
        result = result + i;
        i = i + 1;
    end
endfunction

function result = quardratic_complexity(n)
    i = 1;
    result = 0;
    while i < n
        harm = 1;
        for j = 2:1:i
            harm = harm + inv(j)
        end
        result = result + harm;
        i = i + 1;
    end
endfunction

function [var_independente, var_dependente] = executar_teste(inicio, fim, passo, func, random)
    var_independente = [];
    var_dependente = [];
    n = inicio;
    while n <= fim
        var_independente(1,$+1) = n;
        tic();
        result = func(n);
        tempo = toc();
        var_dependente(1,$+1) = tempo;
        mprintf("- Tempo de execução com %g iterações: %g\n", n, tempo);
        if random then
            n = n + round((passo - 1) * rand()) + 1
        else
            n = n + passo;
        end
    end
endfunction

function coletar_amostra(arq, func, inicio, fim, passo, random)

    // https://help.scilab.org/docs/5.5.1/en_US/fileinfo.html
    [info, ierr] = fileinfo(arq);
    if ierr | info(1) == 0 then
        [x, y] = executar_teste(inicio, fim, passo, func, random);
        gravar_amostra(arq, x, y);
    else
        mprintf("Arquivo %s já existente.\n", arq);
    end
endfunction

function modelo = regressao_linear(arq, fig)
    mprintf("\n-------------------------------------------------------------\n");
    [x y] = ler_amostra(arq);
    [b1 b0 r2 s2] = reglin_simples(x, y, %F);
    [a,b,sig] = reglin(x,y);
    mprintf("TESTE #%d\n\n", fig);
    mprintf("Regressão linear simples (Scilab reglin) = (%.9f)x + (%.9f)\n", a, b);
    mprintf("Regressão linear simples                 = (%.9f)x + (%.9f)\n", b1, b0);
    mprintf("Coeficiente de determinação (r^2)        = %.8f\n", r2);
    mprintf("Variância residual (sigma^2)             = %.8f\n", s2);

    modelo = poly([b0 b1], 'x', 'c');
    lx = linspace(min(x), max(x), 1000);
    ly = horner(modelo, lx);
    
    fig_ctl = scf(fig); // Define o controle de figura 
    clf(fig); // Limpa a figura 
    fig_ctl.figure_name = msprintf("Exemplo #%d de regrassão linear", fig);
    plot(x, y, "b.");  // desenha os pontos
    plot(lx, ly, "r-"); // desenha a reta de regressão
    xs2jpg(gcf(), file_name('teste', fig, 'jpg'));
endfunction

function tempo = teste_extrapolacao(func, x, y)
    mprintf("\nTempo PREVISTO de execução com %g iterações: %g\n", x, y);
    tic();
    result = func(x);
    tempo = toc();
    mprintf("Tempo APURADO de execução com %g iterações: %g\n", x, tempo);
    diferenca = tempo - y;
    percentual = (diferenca/tempo)*100;
    mprintf("Diferença entre o tempo apurado e o previsto: %g\n", diferenca);
    mprintf("Percentual da diferença pelo tempo apurado: %.2f%%\n", percentual);
endfunction

function testar_regressao(func, modelo, fig, intra, extra)
    x_intra = intra;
    y_intra = fround(horner(modelo, x_intra), 3);
    teste_extrapolacao(func, x_intra, y_intra);

    x_extra = extra;
    y_extra = fround(horner(modelo, x_extra), 3);
    teste_extrapolacao(func, x_extra, y_extra);
endfunction

// cria um diretório
result_dir = "teste";
[status, msg] = mkdir(result_dir)
// se não criar o dirtório, mostra a mensagem 
if status == -2 then
    printf("Existe um arquivo com o mesmo nome do dirtório %s", result_dir);
    abort;
elseif status == 0 then
    printf("Não foi possível criar o diretório %s\n", result_dir);
    abort;
end
// muda de diretório
atual_dir = pwd();
if ~chdir(result_dir) then
    printf("Falha ao mudar para o diretório %s\n", result_dir);
    abort;
end
printf("Mudou para o diretório %s\n", pwd());
// modifique essas informaçõess para o computador específico
diary ('relatorio.txt');

try
    mprintf("\n###############################################################\n");
    mprintf("#  Início da coleta de dados\n");
    mprintf("###############################################################\n");
    inicio = 0;
    fim    = 10^5;
    passo  = 10^4;
    coletar_amostra('amostra1.txt', linear_complexity, inicio, fim, passo, %F);
    coletar_amostra('amostra2.txt', linear_complexity, inicio, fim, passo, %T);

    inicio = 0;
    fim    = 10^3;
    passo  = 10^2;
    coletar_amostra('amostra3.txt', quardratic_complexity, inicio, fim, passo, %F);

    mprintf("\n###############################################################\n");
    mprintf("#  Fim da coleta de dados\n");
    mprintf("###############################################################\n");
    modelo = list();

    modelo(1) = regressao_linear('amostra1.txt', 1);
    testar_regressao(linear_complexity, modelo(1), 1, 10^3, 10^7);

    modelo(2) = regressao_linear('amostra2.txt', 2);
    testar_regressao(linear_complexity, modelo(2), 2, 10^3, 10^7);

    modelo(3) = regressao_linear('amostra3.txt', 3);
    testar_regressao(quardratic_complexity, modelo(3), 3, 100, 2*10^3);

catch
    mprintf("Ocooreu erro:", lasterror())
end
diary (0);  // desativa o diário
chdir(atual_dir);
