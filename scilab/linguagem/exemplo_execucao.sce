// limpar a janela de comandos
clc;
// limpa as variáveis
clear;
// carrega arquivos .sci do diretório ('.' = diretório atual)
getd('..\lib');

disp("Exemplo de execução de funções.");

function execution_test(title, func_name, n)
    // mostra um título da função
    printf("###########################################\n%s\n", title);
    // adiciona a função no profiling 
    // (coleta dados de TODAS as execuções da função)
    add_profiling(func_name);
    // inicia a cronometragem
    tic();
    // executa a função passando apenas um argumento
    execstr('r = ' + func_name+"(n)");
    // termina a cronometragem e mostra o resultado
    printf('Tempo de execução = %g\n', toc()); 
    // mostra o resultado da função
    printf("Resultado f(%d) = %d\n", n, r);
    // mostra o resultado da execução da função até o momento
    // 1 - Número de execuções da linha
    // 2 - tempo de execução por linha
    // 3 - tempo de interpretação de cada linha
    execstr('showprofile(' + func_name + ')');
    // reinicia a contagem das execuções
    reset_profiling(func_name);
    // remove a função do profiling
    remove_profiling(func_name);
endfunction

n = 30;
execution_test("Fibonacci recursivo", "fibonacci_rec", n)
execution_test("Fibonacci iterativo", "fibonacci", n)
execution_test("Fatorial recursivo", "fat_rec", n)
execution_test("Fatorial iterativo", "fat", n)
execution_test("Fatorial Scilab", "factorial", n)

