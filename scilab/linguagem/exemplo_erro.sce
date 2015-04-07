// limpar a janela de comandos
clc;
// limpa as variáveis
clear;
// suprimir menagem de redefição de função 
// Nota: no caso, é desenecessário por causa do comando "clear" anterior
funcprot(0);
// carga de todos os programas sci de um diretório
getd('..\lib')

printf("Example: Error handling\n");
printf("Note1: Try negative or non-integer numbers\n");
printf("Note2: Try expressions (see input command)\n");
x = input('Number (0 = exit):');
while x <> 0 
    try // inicia o bloco de tratamento de erro
       printf("fibonacci(%d) = %d\n", x, fibonacci(x));
    catch  // captura eventual erro
       printf("%s\n", lasterror());
    end
    x = input('Number (0 = exit):');
end
